//
//  NewProductDetailViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/24.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "NewProductDetailViewController.h"
#import "GTCommontHeader.h"
#import "CircleView.h"
#import "POP.h"
#import "AssetRecordsTableViewCell.h"
#import "ZMInvestFinishedViewController.h"
#import "ZMRealNameSettingViewController.h"
#import "BankCardTableViewControllerForRecharge.h"
#import "RechargeViewController.h"
#import "HUD.h"
#import "InvestSuccessViewController.h"
#import "AdDetailViewController.h"
#import "tzxyViewController.h"
#import "MobClick.h"
#import "RechargeViewController.h"
#import "BankCardViewController.h"

#define Alert_In_Detail_For_Login      2000
#define Alert_In_Detail_For_RealName   2001
#define Alert_In_Detail_For_Recharge   2002
#define Alert_In_Detail_For_Shoutou   2003

@interface NewProductDetailViewController (){
    UIImageView* detailImage;//项目详情；
    UIWebView* detailWebView;//财行加项目详情
    UIWebView* detailWebView1;//财行加安全保障
    
    UIImageView* saftImage; //安全保障
    UITableView* touzilist; //投资列表;
    UIView* touziView; //投资view；
    NSString *loanId_nameStr;    //用于投资的loanId（代码名称）
    NSString * repaymentType;
    NSString * finishedRatio;    //投资百分比
    float minInvestAmount; //最低可投金额
    NSMutableString *currentInvestAmountString;
    float currentAmount;
    float appendAmount;
    BOOL canInvest;      //是否可投
    NSString *reuseIdentifier;
    UILabel* listTip; //暂无记录；
    NSString *couponsString;     //红包
    UIButton* nowSelectButton; //当前选择按钮；
    NSString* intereststr;
    
    NSString *proDesc;
    NSString *riskControl;
    

}

@end

@implementation NewProductDetailViewController
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaulsView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"投资详情"];
    [self.navigationController.navigationBar setHidden:NO];
    [self requestData];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"投资详情"];
    
    [_tztextfield resignFirstResponder];
}
-(void)initDefaulsView{
    //初始化数据;
    couponsString  = @"0";

    //适配views;
    if (Version>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
    }
    
    self.satflabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(10)];
    self.baozhangLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(10)];
    self.huanxilabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(10)];
    self.jixilabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(10)];
    
    self.tztextfield.font = [UIFont systemFontOfSize:GTFixHeightFlaot(13)];
    self.keyongnumlabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(12)];
    self.yuqishouyiLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(12)];
    self.querenNumLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(11)];
    

    
    self.bgScrollView.frame = CGRectMake(0, 64, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN-64-44);
    self.bgScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN, self.bgScrollView.height*1.25);
    self.bgScrollView.delegate = self;
    self.childBgView.delegate = self;
    self.tztextfield.delegate = self;
    self.tztextfield.keyboardType = UIKeyboardTypeNumberPad;

    self.touziButton.frame = CGRectMake(0, HEIGHT_OF_SCREEN-44, WIDTH_OF_SCREEN, 44);
    self.touziVIew.frame =CGRectMake(0, HEIGHT_OF_SCREEN-44-GTFixHeightFlaot(self.touziVIew.height),WIDTH_OF_SCREEN, GTFixHeightFlaot(self.touziVIew.height));
//    self.touziVIew.layer.cornerRadius = GTFixHeightFlaot(15);
//    [self.touziVIew.layer masksToBounds];
    [self.view insertSubview:self.touziVIew belowSubview:self.touziButton];
    
    self.touziVIew.origin = CGPointMake(0, HEIGHT_OF_SCREEN);
    for (UIView* view in self.touziVIew.subviews){
        view.frame = GetFramByXib(view.frame);
    }
    for (UIView* view in self.bgScrollView.subviews){
        view.frame = GetFramByXib(view.frame);
    }
    for (UIView* view in self.midBg.subviews){
        view.frame = GetFramByXib(view.frame);
    }
    //初始化控件显示状态；
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"0%"];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(14)] range:NSMakeRange(str1.length-1,1)];
    self.nianhuashouyi.attributedText = str1;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"0天"];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(15)] range:NSMakeRange(str2.length-1,1)];
    self.qixian.attributedText = str2;
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"0%"];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(15)] range:NSMakeRange(str3.length-1,1)];
    self.wanchenglabel.attributedText = str3;
    
    [self.touziButton setBackgroundColor:[UIColor colorWithRed:208/255.0f green:208/255.0f blue:208/255.0f alpha:1]];
    [self.touziButton setSelected:NO];
    [self.touziButton setTitle:@"已结束" forState:UIControlStateNormal];
    
    
    self.zongeLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(13)];
    self.qitoulabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(13)];
    
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //添加按钮响应方法；
    [self.leftbutton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    self.leftbutton.titleLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(14)];
    self.leftbutton.selected = YES;
    nowSelectButton = self.leftbutton;
    self.leftbutton.tag = 600;
    
    [self.midbutton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    self.midbutton.titleLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(14)];
    self.midbutton.tag = 601;
    
    [self.rightbutton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    self.rightbutton.tag = 602;
    self.tzjllabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(14)];
    self.tznumlabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(10)];

    
    [self.touziButton addTarget:self action:@selector(touziButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.touziCloseButton addTarget:self action:@selector(CloseTouziView) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.delbutton addTarget:self action:@selector(delbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.userxieyiBtn addTarget:self action:@selector(toUserXieyi:) forControlEvents:UIControlEventTouchUpInside];
    UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    UISwipeGestureRecognizer* rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
    
//    [self requestData];
    [self creatChildView];
    [self creatCirCle];
}
-(void)creatChildView{
    
//    saftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(448))];
//    [saftImage setImage:[UIImage imageNamed:@"SaftDetail.jpg"]];
////    saftImage.hidden = YES;
//    saftImage.alpha = 0;
    
    
    self.childBgView.size = CGSizeMake(self.childBgView.width, self.bgScrollView.contentSize.height-self.childBgView.top);
//    if ([self.titleStr isEqualToString:@"财行宝"]) {
//        detailImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(454.5))];
//        [detailImage setImage:[UIImage imageNamed:@"chbaodetail"]];
////        [detailImage setContentMode:UIViewContentModeCenter];
//        [self.childBgView addSubview:detailImage];
//        self.childBgView.contentSize = CGSizeMake(WIDTH_OF_SCREEN, detailImage.height);
//
//    }
//    if ([self.titleStr isEqualToString:@"财行加"] || [self.titleStr isEqualToString:@"财相遇"] || [self.titleStr isEqualToString:@"财月盈"]||[self.titleStr isEqualToString:@"财季盈"])
//    {
        detailWebView1 = [[UIWebView alloc] init];
        [detailWebView1 setFrame:self.childBgView.frame];
        detailWebView1.backgroundColor = [UIColor whiteColor];
        detailWebView1.opaque = NO;
        [self.bgScrollView addSubview:detailWebView1];
        
        
        
        
        detailWebView = [[UIWebView alloc] init];
        [detailWebView setFrame:self.childBgView.frame];
        detailWebView.backgroundColor = [UIColor whiteColor];
        detailWebView.opaque = NO;
        [self.bgScrollView addSubview:detailWebView];
        

    
//    if ([self.titleStr isEqualToString:@"财行加"]) {
//        
//        detailWebView = [[UIWebView alloc] init];
//        [detailWebView setFrame:self.childBgView.frame];
//        detailWebView.backgroundColor = [UIColor whiteColor];
//        detailWebView.opaque = NO;
//        [self.bgScrollView addSubview:detailWebView];
////        NSString* path = [[NSBundle mainBundle] pathForResource:@"More_Day_Detail" ofType:@"html"];
////        NSURL* url = [NSURL fileURLWithPath:path];
//        NSURL *url = [NSURL URLWithString:proDesc];
//        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//        [detailWebView loadRequest:request];
//    }
//    if ([self.titleStr isEqualToString:@"财月盈"]) {
//        detailWebView = [[UIWebView alloc] init];
//        [detailWebView setFrame:self.childBgView.frame];
//        detailWebView.backgroundColor = [UIColor whiteColor];
//        detailWebView.opaque = NO;
//        [self.bgScrollView addSubview:detailWebView];
//        NSString* path = [[NSBundle mainBundle] pathForResource:@"indexcyy" ofType:@"html"];
//        NSURL* url = [NSURL fileURLWithPath:path];
//        
//        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//        [detailWebView loadRequest:request];
//    }
//    if ([self.titleStr isEqualToString:@"财相遇"]) {
//        detailWebView = [[UIWebView alloc] init];
//        [detailWebView setFrame:self.childBgView.frame];
//        detailWebView.backgroundColor = [UIColor whiteColor];
//        detailWebView.opaque = NO;
//        [self.bgScrollView addSubview:detailWebView];
//        NSString* path = [[NSBundle mainBundle] pathForResource:@"More_Day_Detail" ofType:@"html"];
//        NSURL* url = [NSURL fileURLWithPath:path];
//        
//        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//        [detailWebView loadRequest:request];
//    }
//    if ([self.titleStr isEqualToString:@"财季盈"]) {
//        detailWebView = [[UIWebView alloc] init];
//        [detailWebView setFrame:self.childBgView.frame];
//        detailWebView.backgroundColor = [UIColor whiteColor];
//        detailWebView.opaque = NO;
//        [self.bgScrollView addSubview:detailWebView];
//        NSString* path = [[NSBundle mainBundle] pathForResource:@"indexcyy" ofType:@"html"];
//        NSURL* url = [NSURL fileURLWithPath:path];
//        
//        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//        [detailWebView loadRequest:request];
//    }
//    [self.childBgView addSubview:saftImage];
    
    touzilist = [[UITableView alloc] init];
    touzilist.frame = self.childBgView.frame;
//    touzilist.hidden = YES;
    touzilist.alpha = 0;
    touzilist.delegate = self;
    touzilist.dataSource = self;
    touzilist.backgroundView = nil;
    listTip = [[UILabel alloc] init];
    listTip.text = @"暂无投资记录";
    listTip.textColor = [UIColor colorWithRed:208/255.0f green:208/255.0f blue:208/255.0f alpha:1];
    listTip.textAlignment = NSTextAlignmentCenter;
    listTip.hidden = YES;
    [listTip setFont:[UIFont systemFontOfSize:22]];
    [listTip setFrame:CGRectMake(0,touzilist.height/4, WIDTH_OF_SCREEN, 50)];
    listTip.tag = 201;
    [touzilist addSubview:listTip];
    touzilist.tableFooterView = [[UIView alloc]init];
    touzilist.tableHeaderView= nil;
    //投资记录
    if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
    {
        reuseIdentifier = @"AssetRecordsTableViewCell6";
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        reuseIdentifier = @"AssetRecordsTableViewCell6Plus";
    }
    else
    {
        reuseIdentifier = @"AssetRecordsTableViewCell";
    }
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    [touzilist registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    
    [self.bgScrollView addSubview:touzilist];
}
-(void)creatCirCle{
    CGRect frame = CGRectMake(GTFixWidthFlaot(125),GTFixHeightFlaot(93), GTFixHeightFlaot(70), GTFixHeightFlaot(70));
    CircleView* circleView1 = [[CircleView alloc] initWithFrame:frame andLine:7.0f];
    circleView1.circleLayer.lineCap = kCALineCapButt;

    circleView1.strokeColor = [UIColor colorWithRed:258/255.0 green:214/255.0 blue:138/255.0 alpha:1];

    circleView1.tag = 111;
    circleView1.center = self.yellowCicle.center;
    [circleView1 setStrokeEnd:1 animated:NO];
    [self.bgScrollView addSubview:circleView1];
    
    CircleView* circleView2 = [[CircleView alloc] initWithFrame:frame andLine:7.0f];
    circleView2.strokeColor = [UIColor colorWithRed:225/255.0 green:85/255.0 blue:72/255.0 alpha:1];
    circleView2.tag = 666;
    [self.bgScrollView addSubview:circleView2];
    circleView2.circleLayer.lineCap = kCALineCapButt;

    circleView2.center = self.yellowCicle.center;
    
    [circleView2 setStrokeEnd:0 animated:NO];
    
}

-(void)requestData{
    if(_productInfoDic == nil)
        return;
    
    if ([ZMTools isNullObject:[_productInfoDic valueForKey:@"id"]] ||
        [ZMTools isNullObject:[_productInfoDic valueForKey:@"productType"]]) {
        return;
    }
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"玩命加载中..."];
    
    long loanId = [[_productInfoDic objectForKey:@"id"] longValue];
    NSString *loanTypeName = [_productInfoDic objectForKey:@"productType"];
    CLog(@"%@",loanTypeName);
    
    /*
     * 获取详情信息／以及刷新信息
     */
    [[ZMServerAPIs shareZMServerAPIs] getProductDetailWithType:loanTypeName LoanId:loanId success:^(id response) {
        
        CLog(@"“日紫宝”产品详情信息response = %@", response);
        self.productDetailInfoDic = [[response objectForKey:@"data"] mutableCopy];
        
        loanId_nameStr = [[response objectForKey:@"data"] objectForKey:@"loanId"];
        proDesc = [[response objectForKey:@"data"] objectForKey:@"proDesc"];
        riskControl = [[response objectForKey:@"data"] objectForKey:@"riskControl"];
        finishedRatio = [[response objectForKey:@"data"] objectForKey:@"finishedRatio"];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            progressHUD.tag = 2001;
            [progressHUD hide:YES afterDelay:.5];
            
            self.title = [NSString stringWithFormat:@"%@%@",self.titleStr,loanId_nameStr];

            minInvestAmount = [[[response objectForKey:@"data"] objectForKey:@"minAmount"] integerValue];
//            currentAmount = minInvestAmount;
            appendAmount = [[[response objectForKey:@"data"] objectForKey:@"appendAmount"] integerValue];
            
         /*
            //还款计息的类型
            repaymentType = [[response objectForKey:@"data"] objectForKey:@"repaymentType"];
            if(repaymentType == nil || [ZMTools isNullObject:repaymentType])
            {
                repaymentType = @"PWRIOD_REPAYS_CAPTITAL";
            }
            
            
            if([repaymentType isEqualToString:@"PWRIOD_REPAYS_CAPTITAL"])//"按月付息，到期还本"
            {
                repaymentType = @"PWRIOD_REPAYS_CAPTITAL";
            }
            else if ([repaymentType isEqualToString:@"AVERAGE_CAPITAL_PLUS_INTEREST"])//"等额本息"
            {
                repaymentType = @"AVERAGE_CAPITAL_PLUS_INTEREST";
            }
          */
            
            [self updateViews];
            if (!detailWebView) {
                [self creatChildView];
            }
            //清除webview缓存
//            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
            NSURL *url1 = [NSURL URLWithString:riskControl];
            NSURLRequest* request1 = [NSURLRequest requestWithURL:url1];
            [detailWebView1 loadRequest:request1];
            NSURL *url = [NSURL URLWithString:proDesc];
            NSURLRequest* request = [NSURLRequest requestWithURL:url];
            [detailWebView loadRequest:request];

        });
    } failure:^(id response) {
        
        CLog(@"产品详情 失败 response = %@", response);
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert = nil;
            progressHUD.tag = 2001;
            [progressHUD setLabelText:@"获取失败"];
            [progressHUD hide:YES afterDelay:2.0];
            
        });
    }];
    [self getAssetRecords];
}
/*
 * 获取产品投资记录
 */
- (void)getAssetRecords{
    if ([ZMTools isNullObject:[_productInfoDic valueForKey:@"id"]] ||
        [ZMTools isNullObject:[_productInfoDic valueForKey:@"productType"]]) {
        return;
    }
    
    //请求数据
    NSString *productType = [_productInfoDic valueForKey:@"productType"];
    long loadId = [[_productInfoDic valueForKey:@"id"] longValue];
    
    [[ZMServerAPIs shareZMServerAPIs] getAssetRecordsWithLoanType:productType andLoanId:loadId andPage:1 andPageSize:10 Success:^(id response){
        
        CLog(@"获取产品投资记录 %@",response);
        
        /*
         获取产品投资记录 {
         code = 1000;
         data =     {
         message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
         records =         (
         {
         amount = 1000;
         bidDate = "2015-05-22 16:12:58";
         name = "136*****577";
         status = "HAS_PAID";
         }
         );
         totalCount = 4;
         };
         }
         */
        
        self.investRecordsArray = [[response valueForKey:@"data"] valueForKey:@"records"];
        
        if ([ZMAdminUserStatusModel isNullObject:self.investRecordsArray]||self.investRecordsArray == nil)
        {
            self.investRecordsArray = [NSArray array];
        }
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            //刷新投资记录信息
            long totalCount = [[[response valueForKey:@"data"] valueForKey:@"totalCount"] integerValue];
            if (totalCount > 99) {
                self.tznumlabel.text = [NSString stringWithFormat:@"99+"];
                listTip.hidden = YES;
            }
            else{
                self.tznumlabel.text = [NSString stringWithFormat:@"%ld", totalCount];
                listTip.hidden = YES;
            }
            
            if (totalCount >= 1)
            {
//                [self changeControllerClicked:self.assetRecordButton];
//                //------------addBy吉祥-------------------
//                if(canInvest == NO)
//                {
//                    [self changeControllerClicked:self.productDescriptionButton];
//                    
//                    [self.assetTableView setHidden: YES];
//                }
                listTip.hidden = YES;
            }
            if (totalCount == 0) {
                listTip.hidden = NO;
            }
            [touzilist reloadData];
        });
    }
                                                          failure:^(id response){
                                                              dispatch_async(dispatch_get_main_queue(), ^(){
                                                                  if ([ZMAdminUserStatusModel isNullObject:self.investRecordsArray] || self.investRecordsArray == nil)
                                                                  {
                                                                      self.investRecordsArray = [NSArray array];
                                                                  }
//                                                                  [self.assetTableView reloadData];
                                                              });
                                                          }];
}

-(void)updateViews{
    //刷新可投
    float availabeAmountValue = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue];
    NSString *availabeAmountStr = [ZMTools moneyStandardFormatByData:availabeAmountValue];
    //            self.availableAmountLabel.text = [NSString stringWithFormat:@"可投：¥%@", availabeAmountStr];
    self.querenNumLabel.text = [NSString stringWithFormat:@"可投金额:￥%@",availabeAmountStr];
    //从产品详情数据中获取产品状态
    NSString * productPhaseStatus = [self.productDetailInfoDic objectForKey:@"productPhaseStatus"];
    
    if([ZMTools isNullObject:productPhaseStatus] == YES){
        productPhaseStatus  = [self.productDetailInfoDic objectForKey:@"loanStatus"];
    }
    //是否可投（默认可投）
    if([productPhaseStatus isEqualToString:@"PUBLISHED"] ||
       [productPhaseStatus isEqualToString:@"OPEN"])
    {
        canInvest = YES;
        [self.touziButton setSelected:YES];
        [self.touziButton setBackgroundColor:[UIColor colorWithRed:205/255.0f green:58/255.0f blue:54/255.0f alpha:1]];
        [self.touziButton setTitle:@"立即投资" forState:UIControlStateNormal];
    }
    else
    {
        canInvest = NO;
        [self.touziButton setSelected:NO];
        [self.touziButton setBackgroundColor:[UIColor colorWithRed:208/255.0f green:208/255.0f blue:208/255.0f alpha:1]];
        [self.touziButton setTitle:@"已结束" forState:UIControlStateNormal];
    }
    float interetValue = [[self.productDetailInfoDic objectForKey:@"interest"] floatValue];
    
    NSString *str = [NSString stringWithFormat:@"%f",interetValue];
    if ([str floatValue]==[str intValue]){
        intereststr = [NSString stringWithFormat:@"%.0f%@",interetValue,@"%"];
        
    }else{
        intereststr = [NSString stringWithFormat:@"%.1f%@",interetValue,@"%"];
    }
    
//    NSString* intereststr = [NSString stringWithFormat:@"%.1f%@",interetValue,@"%"];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:intereststr];
    if ([intereststr floatValue] >= 10) {
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(36)] range:NSMakeRange(0,2)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(18)] range:NSMakeRange(2,str1.length-2)];
    }else {
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(36)] range:NSMakeRange(0,1)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(18)] range:NSMakeRange(1,str1.length-1)];
    }
    self.nianhuashouyi.attributedText = str1;

    if ([self.titleStr isEqualToString:@"财月盈"]) {
        intereststr = [NSString stringWithFormat:@"%.1f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intereststr];
        if ([intereststr floatValue] > 10) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(15)] range:NSMakeRange(2,str2.length-2)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(15)] range:NSMakeRange(3,str2.length-3)];
        self.nianhuashouyi.attributedText = str2;

    }
   
    
    [self changeDate];
    
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1: 0.11:0.94];
    animation.fromValue = @(0);
    animation.duration = 1;
//    int tovalue = (1-[[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue] / [[self.productDetailInfoDic objectForKey:@"amount"] floatValue])*100;
    
    int tovalue = [finishedRatio floatValue];
    
//    if (tovalue == 0) {
//        int a = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] intValue];
//        int b = [[self.productDetailInfoDic objectForKey:@"amount"] intValue];
//        if (a!=b) {
//            tovalue = 1;
//        }
//    }
    animation.toValue =@(tovalue);
    
    CircleView* cirview = (CircleView*)[self.view viewWithTag:666];
//    [cirview setStrokeEnd:1-[[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue] / [[self.productDetailInfoDic objectForKey:@"amount"] floatValue] animated:YES];
    
    [cirview setStrokeEnd:[finishedRatio floatValue]/100 animated:YES];
    
#pragma mark - 文字的动画
    [self.wanchenglabel pop_addAnimation:animation forKey:@"numberLabelAnimation"];
    if ([self.productDetailInfoDic objectForKey:@"amount"] == nil) {
        self.zongeLabel.text = [NSString stringWithFormat:@"¥%@", @"0.00"];
    }
    else
    {
        NSString *amountStr = [ZMTools isNullObject:[self.productDetailInfoDic objectForKey:@"amount"]] ? @"0.00" : [[self.productDetailInfoDic objectForKey:@"amount"] stringValue];
        amountStr = [ZMTools moneyStandardFormatByString:amountStr];
        self.zongeLabel.text = [NSString stringWithFormat:@"总金额:¥%@", amountStr];
    }
    minInvestAmount = [[self.productDetailInfoDic objectForKey:@"minAmount"] floatValue];
    self.qitoulabel.text = [NSString stringWithFormat:@"起投金额:￥%.2f",minInvestAmount];
    self.tztextfield.placeholder = [NSString stringWithFormat:@"%.0f元起",minInvestAmount];
    
    self.keyongnumlabel.text = [NSString stringWithFormat:@"可用余额:￥%.2f",[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints];
}
-(void)changeDate{
    //期限
    if ([[self.productDetailInfoDic objectForKey:@"productType"] isEqualToString:@"RIZIBAO"]) {
        self.qixian.text = @"无限期";
    }
    else
    {
        int numday = [[self.productDetailInfoDic objectForKey:@"numDay"] intValue];
        if (numday>0) {
            NSString* numday = [self.productDetailInfoDic objectForKey:@"numDay"];
            NSString* qxstr = [NSString stringWithFormat:@"%@天", numday];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:qxstr];
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(13)] range:NSMakeRange(str2.length-1,1)];
            self.qixian.attributedText = str2;
        }else{
            NSString * month= [self.productDetailInfoDic objectForKey:@"month"];
            
            NSString *monthValue= [NSString stringWithFormat:@"%d天",[[month substringWithRange:NSMakeRange(0,1)] intValue]*30];
            
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:monthValue];
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(13)] range:NSMakeRange(str2.length-1,1)];
            self.qixian.attributedText = str2;
        }
       
    }
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        UIButton* button;
        if (nowSelectButton.tag == 600) {
            button = (UIButton*)[self.midBg viewWithTag:602];
        }else{
            button = (UIButton*)[self.midBg viewWithTag:nowSelectButton.tag-1];
        }
            [self changeView:button];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            UIButton* button;
            if (nowSelectButton.tag == 602) {
                button = (UIButton*)[self.midBg viewWithTag:600];
            }else{
                button = (UIButton*)[self.midBg viewWithTag:nowSelectButton.tag+1];
            }
            [self changeView:button];
    }
}
-(void)changeView:(UIButton*)selectBtn{
    
    [self touziViewHidden];
    
    
    self.leftbutton.selected = NO;
    self.midbutton.selected = NO;
    self.rightbutton.selected = NO;
    selectBtn.selected = YES;
    nowSelectButton = selectBtn;
    
    
    self.tzjllabel.textColor = [UIColor blackColor];
    self.tzjllabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    if (selectBtn.tag == 600) {
     
//        saftImage.hidden = YES;
//        detailImage.hidden = NO;
        self.childBgView.contentSize = CGSizeMake(WIDTH_OF_SCREEN, detailImage.height);
        [UIView animateWithDuration:0.25 animations:^{
            self.childBgView.alpha = 0;
            touzilist.alpha = 0;
            detailWebView.alpha = 1;
            detailWebView1.alpha = 0;
//            detailWebView1.hidden = YES;
//            detailWebView.hidden = NO;
        }];
        
        
//        if ([self.titleStr isEqualToString:@"财行加"] || [self.titleStr isEqualToString:@"财相遇"]) {
////            self.childBgView.hidden = YES;
////            detailWebView.hidden = NO;
//            [UIView animateWithDuration:0.25 animations:^{
//                self.childBgView.alpha = 0;
//                touzilist.alpha = 0;
//                detailWebView.alpha = 1;
//                detailWebView1.alpha = 0;
//            }];
//        }
//        if ([self.titleStr isEqualToString:@"财行宝"]){
//            [UIView animateWithDuration:0.25 animations:^{
//                self.childBgView.alpha = 1;
//                detailWebView1.alpha = 0;
//                detailImage.alpha = 1;
//                touzilist.alpha = 0;
//                detailWebView.alpha = 0;
//            }];
//        }
//        if ([self.titleStr isEqualToString:@"财月盈"] || [self.titleStr isEqualToString:@"财季盈"]){
//            [UIView animateWithDuration:0.25 animations:^{
//                self.childBgView.alpha = 0;
//                touzilist.alpha = 0;
//                detailWebView.alpha = 1;
//                detailWebView1.alpha = 0;
//            }];
//        }
        
    }
    if (selectBtn.tag == 601) {
        [UIView animateWithDuration:0.25 animations:^{
//            saftImage.hidden = NO;
//            detailImage.hidden = YES;
            saftImage.alpha = 1;
            self.childBgView.alpha = 1;
            touzilist.alpha = 0;
            detailImage.alpha = 0;
            detailWebView.alpha = 0;
            detailWebView1.alpha = 1;
        }];
     
        self.childBgView.contentSize = CGSizeMake(WIDTH_OF_SCREEN, saftImage.height);
    }
    if (selectBtn.tag == 602) {
        
//        self.childBgView.hidden = YES;
        self.tzjllabel.textColor = [UIColor colorWithRed:205/255.0f green:58/255.0f blue:54/255.0f alpha:1];
//        touzilist.hidden = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            //            saftImage.hidden = NO;
            //            detailImage.hidden = YES;
            touzilist.alpha = 1;
            self.childBgView.alpha = 0;
        }];
        
    }
    
}

- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty
            propertyWithName:@"com.curer.test"
            initializer:^(POPMutableAnimatableProperty *prop) {
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    UILabel *label = (UILabel *)obj;
                    NSNumber *number = @(values[0]);
                    int num = [number intValue];
                    label.text = [@(num) stringValue];
                    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",[@(num) stringValue],@"%"]];
                    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(15)] range:NSMakeRange(str2.length-1,1)];
                    
                    self.wanchenglabel.attributedText = str2;
                    
                };
            }];
}
-(void)touziButtonClick:(UIButton*)sender{
    
    if (canInvest && self.touziVIew.top == HEIGHT_OF_SCREEN) {
        if (![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        {
            // [[HUD sharedHUDText] showForTime:1.5 WithText:@"登录后才能投资"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                            message:@"登录后才能投资"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            alert.tag = Alert_In_Detail_For_Login;
            [alert show];
            
            return;
        }

        [self touziViewShow];
    }else{
        [self.tztextfield resignFirstResponder];
        //投资操作;
        
        [self investAction:sender];
    }
}
-(void)CloseTouziView{
    [self touziViewHidden];
}
-(void)touziViewHidden{
    [self.tztextfield resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.touziVIew.origin = CGPointMake(0, HEIGHT_OF_SCREEN);
        self.tztextfield.text = @"";
        self.yuqishouyiLabel.text = @"预期收益:￥0.00";
    }];
}
-(void)touziViewShow{
    [UIView animateWithDuration:0.25 animations:^{
        self.touziVIew.origin = CGPointMake(0, HEIGHT_OF_SCREEN-44-self.touziVIew.height);
    }];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.touziVIew.origin = CGPointMake(0, HEIGHT_OF_SCREEN-height-self.touziVIew.height-self.touziButton.height);
        self.touziButton.origin = CGPointMake(0, HEIGHT_OF_SCREEN-height-self.touziButton.height);
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.25 animations:^{
        self.touziVIew.origin = CGPointMake(0,HEIGHT_OF_SCREEN-self.touziVIew.height-44);
        self.touziButton.origin = CGPointMake(0, HEIGHT_OF_SCREEN-self.touziButton.height);
    }];
    
}
-(void)addButtonClick:(UIButton*)sender{
    
    int textfont =  [self.tztextfield.text intValue]+ [[self.productDetailInfoDic objectForKey:@"minAmount"] intValue];
    int availabeAmountValue = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] intValue];
    
    if ( textfont > availabeAmountValue) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:[NSString stringWithFormat:@"最大可投金额为%d元", availabeAmountValue]];
        return;
    }
    self.tztextfield.text = [NSString stringWithFormat:@"%d",textfont];
    [self anticipatedIncome:self.tztextfield.text];
}
-(void)delbuttonClick:(UIButton*)sender{
    int textfont =  [self.tztextfield.text intValue] - [[self.productDetailInfoDic objectForKey:@"minAmount"] intValue];
    if (textfont < [[self.productDetailInfoDic objectForKey:@"minAmount"] intValue]) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:[NSString stringWithFormat:@"不能小于最低起投金额%.0f元", minInvestAmount]];
        return;
    }
    self.tztextfield.text = [NSString stringWithFormat:@"%d",textfont];
    [self anticipatedIncome:self.tztextfield.text];

}


- (void)investAction:(UIButton *)button
{
    CLog(@"执行投资操作");
    if(canInvest == NO)
    {
        return;
    }
    if (![self.title isEqual:@"财行宝"]) {
        int var1 = [currentInvestAmountString intValue]% (NSInteger)minInvestAmount;
        if (var1 != 0) {
//            [[HUD sharedHUDText] showForTime:1.5 WithText:@"请输入100的倍数哦,亲"];
            [[HUD sharedHUDText] showForTime:1.5 WithText:[NSString stringWithFormat:@"请输入%.0f的倍数哦,亲",minInvestAmount]];
            return;
        }

    }
   
    if ([self.tztextfield.text isEqualToString:@""]) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"请输入要投资的金额"];
        return;
    }
    
    if (![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
    {
        // [[HUD sharedHUDText] showForTime:1.5 WithText:@"登录后才能投资"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"登录后才能投资"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.tag = Alert_In_Detail_For_Login;
        [alert show];
        return;
    }
    //安全认证(实名认证)
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.idCard isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"请先进行实名认证"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.tag = Alert_In_Detail_For_RealName;
        [alert show];
        return;
    }
    
    
    //对可投金额的判断
    float availabeAmount = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue];
    if(currentAmount > availabeAmount)
    {
        [[HUD sharedHUDText] showForTime:1.5 WithText:[NSString stringWithFormat:@"最大可投金额为%.0f元", availabeAmount]];
        return;
    }
    //不能小于最低起投金额
    if(currentAmount < minInvestAmount) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:[NSString stringWithFormat:@"不能小于最低起投金额%.0f元", minInvestAmount]];
        return;
    }
    
    //最小投资金额大于可投资金额（特殊情况，需要人工结标）
    if(minInvestAmount > availabeAmount)
    {
        [[HUD sharedHUDText] showForTime:1.5 WithText:[NSString stringWithFormat:@"最小起投金额为%d元", (int)minInvestAmount]];
        return;
    }
    
    
    //不满足“100元起且以100元的倍数递增”投资条件
    if((((int)currentAmount - (int)minInvestAmount) % (int)appendAmount) != 0.0)
    {
        NSString * message = [NSString stringWithFormat:@"不满足“%d元起且以%d元的倍数递增”投资条件", (int)minInvestAmount, (int)appendAmount];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //超过用户可用余额
    if(currentAmount > [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints)
    {
        //        NSString *message = [NSString stringWithFormat:@"金额不足，可用余额为%.0f元，请去网站充值", [ZMAdminUserStatusModel shareAdminUserStatusModel].availablePoints];
        
        NSString *message = [NSString stringWithFormat:@"金额不足,可用余额为%.2f元,请充值", [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"好的", nil];
        alert.tag = Alert_In_Detail_For_Recharge;
        [alert show];
        return;
    }
    
    //安全认证
    if(0)
    {
        
    }
    
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.mode = MBProgressHUDModeIndeterminate; //有菊花
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"抢购中..."];
    
    
    [[ZMServerAPIs shareZMServerAPIs] confirmInvestmentWith:[[_productInfoDic objectForKey:@"id"] integerValue]
                                                     LoanId:loanId_nameStr
                                                   loanType:[_productInfoDic objectForKey:@"productType"]
                                              andLendAmount:currentAmount
                                                    Coupons:nil
                                                    success:^(id response) {
                                                        CLog(@"投资成功   %@", response);
                                                        
                                                        //        确认投资 loan id ddd 1接收到的数据：{"message":"投标成功","code":1000}
                                                        //        2015-05-13 16:30:45.348 ZiMaCaiHang[19172:5074950] 投资成功   {
                                                        //            code = 1000;
                                                        //            message = "\U6295\U6807\U6210\U529f";
                                                        //        }
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.tztextfield.text = @"";
                                                            self.yuqishouyiLabel.text =@"预期收益:￥0.00";
                                                            //更新首页的回调
                                                            if (self.updateHomePageAllDataBlock)
                                                            {
                                                                CLog(@"更新首页的回调方法");
                                                                self.updateHomePageAllDataBlock();
                                                            }
                                                            
                                                            //更新用户数据
                                                            [self updateAdminUserInfo];
                                                            
                                                            //详情页面数据
                                                            [self requestData];
                                                            
                                                            //百度统计
                                                            //            [[BaiduMobStat defaultStat] logEvent:@"investment" eventLabel:@"投资成功"];
                                                            
                                                            progressHUD.tag = 2001;
                                                            [progressHUD setLabelText:@""];
                                                            [progressHUD hide:YES afterDelay:0.5];
                                                            
                                                            InvestSuccessViewController *finishedVC = [[InvestSuccessViewController alloc] init];
//                                                            finishedVC.isSucceed = YES;
                                                            if([_productInfoDic[@"productType"] isEqualToString:@"RIZIBAO"])
//                                                            {
//                                                                
//                                                                finishedVC.currentTime = @"当天计息";
//                                                                finishedVC.getCurrentMoneyTime = @"次日到账";
//                                                            }
//                                                            else
                                                            {
                                                                finishedVC.currentTime = response[@"data"][@"lendTime"];
                                                               
                                                                finishedVC.getCurrentMoneyTime = response[@"data"][@"dueDate"];
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
//                                                                if([_productInfoDic[@"dayNum"] integerValue]>0)
//                                                                {
//                                                                  finishedVC.getCurrentMoneyTime = [NSString stringWithFormat:@"%@天后",_productInfoDic[@"dayNum"]];
//                                                                }
//                                                                else
//                                                                {
//                                                                    finishedVC.getCurrentMoneyTime = [NSString stringWithFormat:@"%@月后",_productInfoDic[@"loanMonthsValue"]];
//                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            finishedVC.currentMoney = [NSString stringWithFormat:@"￥%.2f",currentAmount];
                                                            
                                                            
                                                            [self.navigationController pushViewController:finishedVC animated:YES];
                                                            
                                                        });
                                                        
                                                    } failure:^(id response) {
                                                        CLog(@"投资失败   %@", response);
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            
                                                            
//                                                            progressHUD.tag = 2002;
//                                                            [progressHUD setLabelText:@""];
                                                            [progressHUD hide:YES afterDelay:0.5];
                                                            
                                                            ZMInvestFinishedViewController *finishedVC = [[ZMInvestFinishedViewController alloc] init];
                                                            finishedVC.isSucceed = NO;
                                                            
                                                            
                                                            NSString *message = [response objectForKey:@"message"];
                                                            if (message != NULL) {
                                                                [[HUD sharedHUDText] showForTime:1.5 WithText:message];
                                                                return;
                                                            }
                                                            
//                                                                [[HUD sharedHUDText] showForTime:1.5 WithText:message];
//                                                                return;
                                                            
                                                            [self presentViewController:finishedVC animated:NO completion:^{
                                                                
                                                            }];
                                                        });
                                                    }];
}
-(void)toUserXieyi:(UIButton*)sender{
    tzxyViewController* userxieyi =[[tzxyViewController alloc] init];
    userxieyi.productId = [_productInfoDic valueForKey:@"id"];
    [self.navigationController pushViewController:userxieyi animated:YES];
    
}
- (void)updateAdminUserInfo
{
    NSString * loginKey = [[ZMAdminUserStatusModel shareAdminUserStatusModel] getLoginKey];
    
    //是否已经登录
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn] &&
       loginKey != nil)
    {
        //        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAssert];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAccount];
    }
}




#pragma mark  --------------- UITableView Delegate ----------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    [self relayoutView];
    return [self.investRecordsArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, WIDTH_OF_SCREEN - 20, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]];
    
    UILabel *assetMobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, headerView.frame.size.width/3*0.8, headerView.frame.size.height - 5)];
    assetMobileLabel.text = @"投资用户";
    assetMobileLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
    assetMobileLabel.font = [UIFont systemFontOfSize:12];
    [assetMobileLabel setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *assetMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3*0.8, 5, headerView.frame.size.width/3*1, headerView.frame.size.height - 5)];
    assetMoneyLabel.text = @"投资金额";
    assetMoneyLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
    assetMoneyLabel.font = [UIFont systemFontOfSize:12];
    [assetMoneyLabel setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *assetTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width/3*1.8, 5, headerView.frame.size.width/3*1.2, headerView.frame.size.height - 5)];
    assetTimeLabel.text = @"投资时间";
    assetTimeLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
    assetTimeLabel.font = [UIFont systemFontOfSize:12];
    [assetTimeLabel setTextAlignment:NSTextAlignmentCenter];
    
    [headerView addSubview:assetMobileLabel];
    [headerView addSubview:assetMoneyLabel];
    [headerView addSubview:assetTimeLabel];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN - 20, 1)];
    [topLine setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]];
    topLine.text = @"";
    [headerView addSubview:topLine];
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, WIDTH_OF_SCREEN - 20, 1)];
    [bottomLine setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]];
    bottomLine.text = @"";
    [headerView addSubview:bottomLine];
    [headerView addSubview:topLine];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AssetRecordsTableViewCell *cell = (AssetRecordsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        cell = [[AssetRecordsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
    if(![ZMTools isNullObject:self.investRecordsArray])
    {
        cell.dataDic = self.investRecordsArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark  --------------- UIScrollView Delegate ----------------
//上下滑动scroll 用于隐藏输入法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self touziViewHidden];
}
#pragma mark  --------------- UITextField Delegate ----------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    CLog(@"ShouldBegin ===  %@", textField.text);
    
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    CLog(@"DidBegin ===  %@", textField.text);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CLog(@"ShouldEnd ===  %@", textField.text);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CLog(@"DidEnd ===  %@", textField.text);
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *tempString = [NSMutableString stringWithString: textField.text];
    
    if([string isEqualToString:@""] && range.location != 0)
    {
        [tempString deleteCharactersInRange:NSMakeRange(range.location, 1)];
    }
    else if ([string isEqualToString:@""] && range.location == 0)
    {
        if ([textField.text length] > 0)
        {
            [tempString deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    else
    {
        [tempString insertString:string atIndex:range.location];
    }
    
    currentInvestAmountString = tempString;
    float availabeAmountValue = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue];

    if ([tempString floatValue]> availabeAmountValue) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:[NSString stringWithFormat:@"最大可投金额为%.0f元", availabeAmountValue]];
        self.tztextfield.text = [NSString stringWithFormat:@"%.0f",availabeAmountValue];
        [self anticipatedIncome:self.tztextfield.text];

        return NO;
    }
//    if (![self isPureInt:currentInvestAmountString]) {
//            [[HUD sharedHUDText] showForTime:1.5 WithText:@"请输入整数哦,亲"];
//            return NO;
//    }
    
    NSRange _range = [currentInvestAmountString rangeOfString:@"."];
    if (_range.location != NSNotFound) {
        //有“.”
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"请输入整数哦,亲"];
        return NO;
    }
    
    [self anticipatedIncome:currentInvestAmountString];
    return YES;
}
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  手动输入投资金额，显示确认投资、计算预计收益
 */
-(NSString *)anticipatedIncome:(NSString *)currentInvestMoney
{
    //当前输入金额
    float currtentMoney = currentInvestMoney.doubleValue;
    currentAmount = currtentMoney;
    
    
    //可投金额
//    float restAmount = [[self.productDetailInfoDic objectForKey:@"availabeAmount"] floatValue];
    //月数
//    NSInteger loanMonthsValue;
//    NSInteger dayNumValue = 0;
    if ([self.titleStr isEqualToString:@"财行宝"]) {
        float interetValue = [[self.productDetailInfoDic objectForKey:@"interest"] floatValue];
         float lilv = interetValue/100* [currentInvestMoney floatValue]/365;
//        lilv = interetValue*self.
            self.yuqishouyiLabel.text = [NSString stringWithFormat:@"预期收益:￥%.2f",lilv];
    }else{
        float interetValue = [[self.productDetailInfoDic objectForKey:@"interest"] floatValue];
        int numday = [[self.productDetailInfoDic objectForKey:@"numDay"] intValue];
        float lilv;
        if (numday>0) {
            NSString* numday = [self.productDetailInfoDic objectForKey:@"numDay"];
          lilv  = interetValue/100* [currentInvestMoney floatValue]/365*[numday intValue];
        }else{
            NSString * monthValue= [self.productDetailInfoDic objectForKey:@"month"];
            lilv  = interetValue/100* [currentInvestMoney floatValue]*[monthValue intValue]*30/365;
        }
        

        self.yuqishouyiLabel.text = [NSString stringWithFormat:@"预期收益:￥%.2f",lilv];
    }
//    if
    //年数
//    float years = loanMonthsValue / 12.0;
    
   /* //年化利率
    float interest = [[_productInfoDic objectForKey:@"interest"] floatValue] / 100.0;
    
    if([repaymentType isEqualToString:@"PWRIOD_REPAYS_CAPTITAL"])
    {
        
        //可用余额低于最低投资金额
        
        
        //不能超过用户的可用余额
        
        if(currtentMoney > restAmount)  //不能大于剩余可投资金额
        {
            currtentMoney = restAmount;
        }
        
        
        //确认投资金额标签
//        self.investAmountLabel.text = [NSString stringWithFormat:@"确认投资：¥%@", [ZMTools moneyStandardFormatByData:currentAmount]];
        
        float investProfileValue = currentAmount * interest * years;
        self.yuqishouyiLabel.text = [NSString stringWithFormat:@"预期收益：¥%.2f", investProfileValue];
//        self.investProfileValueLabel.text = [NSString stringWithFormat:@"预期收益："];
        
        return nil;
    }
    
    //等额本息
    if ([repaymentType isEqualToString:@"AVERAGE_CAPITAL_PLUS_INTEREST"])
    {
        //月利率(yearInterest/12.0)
        float mounthInterest = interest / 12.0;
        
        //月数
        NSInteger loanMonths = loanMonthsValue;
        
        float everyMonthMoney = (currtentMoney * mounthInterest * pow((1+mounthInterest), loanMonths)) / (pow((1+mounthInterest), loanMonths) - 1);
        
        CLog(@"等额本息 = %f", everyMonthMoney * loanMonths - currtentMoney);
        
        
        double income = everyMonthMoney * loanMonths - currtentMoney;
        
        //确认投资金额标签
//        self.investAmountLabel.text = [NSString stringWithFormat:@"确认投资：¥%@", [ZMTools moneyStandardFormatByData:currentAmount]];
        
        self.yuqishouyiLabel.text = [NSString stringWithFormat:@"¥%.2f",income];
//        self.investProfileValueLabel.text = [NSString stringWithFormat:@"预期收益："];
        
        return nil;
    }
    //一次性还本付息
    if ([repaymentType isEqualToString:@"ALL_PAY_DUE_DATE"])
    {
        //月利率(yearInterest/12.0)
        
        float mounthInterest = interest / 12.0;
        
        //月数
        NSInteger loanMonths = loanMonthsValue;
        double income;
        if(dayNumValue>0)
        {
            income = interest * currtentMoney / 365 * dayNumValue;
        }
        else
        {
            income = mounthInterest * currtentMoney /12 * loanMonths;
        }
        //确认投资金额标签
//        self.investAmountLabel.text = [NSString stringWithFormat:@"确认投资：¥%@", [ZMTools moneyStandardFormatByData:currentAmount]];
        
        self.querenNumLabel.text = [NSString stringWithFormat:@"¥%.2f",income];
        
//        self.investProfileValueLabel.text = [NSString stringWithFormat:@"预期收益："];
        
        return nil;
    }
    
    */
    return nil;
}


#pragma mark  --------------- 提示消息（登录／实名认证／充值） ----------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case Alert_In_Detail_For_Login:
        {
            if (buttonIndex == 1){
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
            }
        }
            break;
        case Alert_In_Detail_For_RealName:
        {
            if (buttonIndex == 1){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    ZMRealNameSettingViewController * next = [[ZMRealNameSettingViewController alloc] init];
                    next.isAlreadyAuthen = NO;
                    next.realNameAuthenticationBlock = ^(BOOL isAuthentication){
                        if (isAuthentication) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                CLog(@"投资的时候：实名认证成功了");
                            });
                        }
                    };
                    
                    [self.navigationController pushViewController:next animated:YES];
                });
            }
        }
            break;
        case Alert_In_Detail_For_Recharge:
        {
            if (buttonIndex == 1){
                [self getUserLLBankList];
            }
        }
            break;
            
        default:
            break;
    }
}


/*
 * 获取用户银行卡列表
 */
-(void)getUserLLBankList
{
    
    
       [[ZMServerAPIs shareZMServerAPIs] getUserBankListForWithdraw:NO Success:^(id response)
     {
         NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];

         //第一次充值
         if(tempBankCardArray.count == 0)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 BankCardViewController * next = [[BankCardViewController alloc]init];
                 next.isRechargeView = YES;
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
                 [self.navigationController pushViewController: next animated:YES];
             });
         }
         else
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSDictionary *LLPayUserBankInfo = [response objectForKey:@"data"];
                 RechargeViewController *rechargeViewController = [[RechargeViewController alloc]init];
                 rechargeViewController.title = @"充值";
                 rechargeViewController.selectedBankInfo = LLPayUserBankInfo;
                 [self.navigationController pushViewController:rechargeViewController animated:YES];
             });
         }

         dispatch_async(dispatch_get_main_queue(), ^(){
           
         });
         CLog(@"用户银行卡列表：success = %@", response);
     }
    failure:^(id response){
        
    }];

    
    
    return;
    
    
    
    [[ZMServerAPIs shareZMServerAPIs] isFirstRechargeSuccess:^(id response) {
        
        //        {"message":"获取数据成功","data":null,"code":1000}
        
        CLog(@"success 用户是否第一次充值：%@", response);
        
        //第一次充值
        if([ZMTools isNullObject:[response objectForKey:@"data"]] == YES)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                CLog(@"%d",[ZMTools isNullObject:[response objectForKey:@"data"]]);
                
                BankCardTableViewControllerForRecharge * next = [[BankCardTableViewControllerForRecharge alloc]init];
                next.isRechargeView = YES;
                
//                RechargeViewController *next = [[RechargeViewController alloc] init];
                
                [self.navigationController pushViewController: next animated:YES];
                
                return ;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *LLPayUserBankInfo = [response objectForKey:@"data"];
                RechargeViewController *rechargeViewController = [[RechargeViewController alloc]init];
                rechargeViewController.title = @"充值";
                rechargeViewController.selectedBankInfo = LLPayUserBankInfo;
                [self.navigationController pushViewController:rechargeViewController animated:YES];
            });
        }
        
    } failure:^(id response) {
        
        CLog(@"failure 用户是否第一次充值：%@", response);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
