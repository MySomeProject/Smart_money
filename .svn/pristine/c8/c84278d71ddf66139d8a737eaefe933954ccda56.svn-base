//
//  ViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-1.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "HomePageViewController.h"

#import "ScrollMenu.h"

#import "ProductCellView.h"

#import "SecretaryScrollCellView.h"


#import "ZMPresentWebViewController.h"




#import "MineCenterViewController.h"
#import "AdDetailViewController.h"
#import "MarqueeLabel.h"

#import "NewProductDetailViewController.h"
#import "GTCommontHeader.h"
#import "Reachability.h"
#import "HUD.h"
#import "MobClick.h"

#define NAVHEIGHT 64
@interface HomePageViewController ()<SecretaryScrollCellViewDelegate, UIScrollViewDelegate>
{
    NSArray * productCategoryArray;
    NSMutableArray *productCellViewArray;
    
    NSMutableArray * productInfoArray;//产品信息数组
    UIButton*  leftScrollBtn;
    UIButton* rightScrollBtn;
    UILabel* Adlabel ; //公告条；
    NSTimer* adtimer;//公告条计时器
    NSMutableArray* newsary;
    UIScrollView* adScrollView;
    NSMutableArray* AdlabAry;
    int newsPage; //
    BOOL isWiFi;
    
    
}

@property (unsafe_unretained, nonatomic) IBOutlet ScrollMenu *topScrollMenu;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *middleContainer;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *middleScrollView;

@property (unsafe_unretained, nonatomic) IBOutlet SecretaryScrollCellView *topBannerView;

@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSTimeInterval tentime = 10;
    [adScrollView setContentOffset:CGPointMake( 0, GTFixHeightFlaot(17*newsPage)) animated:YES];
    [adtimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:tentime]];

//    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
    if ([productInfoArray count] > 0) {
//        productInfoArray = nil;
//        [self requestListData];
    }else{
        [self requestListData];
    }
    [MobClick beginLogPageView:@"首页"];

}
-(void)viewWillDisappear:(BOOL)animated{
    if ([productInfoArray count] > 0) {
        productInfoArray = nil;
        [self requestListData];
    }
    [super viewWillDisappear:animated];
    [adtimer setFireDate:[NSDate distantFuture]];
    
    [MobClick endLogPageView:@"首页"];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
}
-(void)requestListData{
    
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    
    
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    
    [[ZMServerAPIs shareZMServerAPIs] recommendedItemsSuccess:^(id response) {
        CLog(@"首页推荐项目－成功 ＝ %@", response);
        
        productInfoArray = [[response objectForKey:@"data"] objectForKey:@"ALLProductVOs"];
        newsary = [[response objectForKey:@"data"] objectForKey:@"news"] ;
        //刷新首页项目数据
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [HUDjz hide:YES afterDelay:1.0];

            
            if (productCellViewArray.count == 0) {
                if (productInfoArray.count>0) {
                    for (UIView * view in self.middleScrollView.subviews ) {
                        [view removeFromSuperview];
                    }
                }else{
                    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    [HUDjz setLabelText:@"暂无数据"];
                    [HUDjz hide:YES afterDelay:1.0];

                }
                [self setupProductCellViews];
                [self refushAdBar];

            }
            [self reloadProductData:productInfoArray];
        });
        
        /*
         amount = 100000;
         appendAmount = 1;
         availabeAmount = 90000;
         id = 249;
         interest = 15;
         minAmount = 1;
         month = "MORE_DAY";
         numDay = 7;
         productType = "MORE_DAY";
         status = PUBLISHED;
         */
        
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:1.0];
        });

        CLog(@"首页推荐项目－失败 ＝ %@", response);
    }];

}
-(void)updateAfterSuccessInvested
{
    if ([productInfoArray count] > 0) {
        productInfoArray = nil;
    }
    
    
    [[ZMServerAPIs shareZMServerAPIs] recommendedItemsSuccess:^(id response) {
        CLog(@"首页投资成功后的刷新 OK ＝ %@", response);
        
        productInfoArray = [[response objectForKey:@"data"] objectForKey:@"ALLProductVOs"];
        
        //刷新首页项目数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadProductData:productInfoArray];
        });
    } failure:^(id response) {
        CLog(@"首页投资成功后的刷新 OK ＝ %@", response);
    }];
}



/*
 *添加左侧个人中心入口按钮
 */
- (UIButton *)setupLeftCenterEntranceButton{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setBackgroundColor:[UIColor clearColor]];
    menuButton.frame = CGRectMake(0, 0, 44, 44);
    [menuButton setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [menuButton setImage:[UIImage imageNamed:@"headerBG"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"headerBG"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(leftCenterEntranceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return menuButton;
}

/*
 * 进入个人中心
 */
-(void)leftCenterEntranceButtonPressed:(UIButton *)button
{
    //登录
    if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    
    //进入个人中心
    else
    {
        UIStoryboard * myCenterStoryboard = [UIStoryboard storyboardWithName:@"MineCenter" bundle:nil];
        MineCenterViewController *myCenterVC = [myCenterStoryboard instantiateViewControllerWithIdentifier:@"MineCenterViewController"];
        
        [self.navigationController pushViewController:myCenterVC animated:YES];
    }
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
-(void)viewChangeFrame{
    self.topBannerView.frame = GetFramByXib(self.topBannerView.frame);
    self.topBannerView.origin = CGPointMake(0,NAVHEIGHT);
    
    
    self.topScrollMenu.hidden = YES;
    //    self.topScrollMenu.origin = CGPointMake(self.topScrollMenu.origin.x, self.topBannerView.frame.size.height+30+NAVHEIGHT);
    
    self.middleContainer.frame = GetFramByXib(self.middleContainer.frame);
    self.middleContainer.frame = CGRectMake(self.middleContainer.origin.x, self.middleContainer.origin.y, self.middleContainer.width, HEIGHT_OF_SCREEN-self.topBannerView.bottom-GTFixHeightFlaot(17)-46);
    self.middleContainer.origin =CGPointMake(self.middleScrollView.origin.x, self.topBannerView.bottom+GTFixHeightFlaot(17));
    self.middleScrollView.frame = self.middleContainer.bounds;
    self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.contentSize.width  , self.middleScrollView.height);
    
    self.middleScrollView.origin = CGPointMake(0, 0);
    //    [self creatADBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    newsPage = 0;
    
    isWiFi = NO;
    
    AdlabAry = [[NSMutableArray alloc] init];
    
    [self viewChangeFrame];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 77, 26)];
    logoImageView.image = [UIImage imageNamed:@"caihangjialogo"];
    self.navigationItem.titleView = logoImageView;
    
    
    
    productInfoArray = [[NSMutableArray alloc]init];
    
    
    //中间滚动栏
    self.middleScrollView.pagingEnabled = YES;
    self.middleScrollView.delegate = self;
    //    self.middleScrollView.scrollEnabled = NO;
    
    //广告栏目
    self.topBannerView.delegate = self;
       
    [self setupSingoleProductCell];
    
    //滚动菜单传值
    self.topScrollMenu.userInteractionEnabled = YES;
    
    self.topScrollMenu.scrollMenuChangeBlock = ^(NSInteger productIndex){
        CLog(@"productIndex  ==  %ld", productIndex);
        productIndex = productIndex + 1;
        [self.middleScrollView setContentOffset:CGPointMake(WIDTH_OF_SCREEN * productIndex, 0) animated:YES];
    };
    
    [self creatADBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable])
    {
        if (newsary.count == 0) {
            if ([reach.currentReachabilityString isEqualToString:@"WiFi"]) {
                [self requestListData];
            }
        }
            
    }
    else
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"网络异常,请检查网络"];

    }
    
}
-(void)creatADBar{
    UIView* bgview = [[UIView alloc] init];
    [bgview setBackgroundColor: [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1]];
    bgview.frame = CGRectMake(0,self.topBannerView.bottom, GTFixWidthFlaot(320),GTFixHeightFlaot(17));
    [self.view addSubview:bgview];
    
    UIImageView* labImg = [[UIImageView alloc] init];
    [labImg setImage:[UIImage imageNamed:@"gonggao"]];
    [labImg setFrame:CGRectMake(0,self.topBannerView.bottom, GTFixWidthFlaot(20), GTFixHeightFlaot(17))];
    [self.view addSubview:labImg];
    
    adScrollView = [[UIScrollView alloc] init];
    adScrollView.frame = CGRectMake(GTFixWidthFlaot(20), self.topBannerView.bottom, GTFixHeightFlaot(300), GTFixHeightFlaot(17));
    adScrollView.contentSize = CGSizeMake(GTFixWidthFlaot(300) , GTFixHeightFlaot(17*newsary.count));
    adScrollView.scrollEnabled = NO;
    [self.view addSubview:adScrollView];
}

-(void)refushAdBar{
    if (AdlabAry.count != 0) {
        return;
    }
    for (UIView* view in adScrollView.subviews) {
        [view removeFromSuperview];
    }
    [AdlabAry removeAllObjects];

    for (int i = 0; i<newsary.count; i++) {
        
        
        UILabel* AdLabel;
//        MarqueeLabel* AdLabel;//滚动label；
        AdLabel = [[UILabel alloc] init];
//        AdLabel.marqueeType = MLContinuous;
//        AdLabel.scrollDuration = 10.0f;
        AdLabel.textColor = [UIColor grayColor];
//        AdLabel.fadeLength = 10.0f;
        AdLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(11)];
        AdLabel.backgroundColor = [UIColor clearColor];
//        [AdLabel pauseLabel];
//        AdLabel.trailingBuffer = 30.0f;
        AdLabel.text = @"紫马理财正式上线啦,多种活动哦！";
        AdLabel.text = [[newsary objectAtIndex:i] objectForKey:@"title"];
        AdLabel.frame = CGRectMake(GTFixHeightFlaot(5),GTFixHeightFlaot(17)*i, GTFixWidthFlaot(295),GTFixHeightFlaot(17));
        [adScrollView addSubview:AdLabel];
        [AdlabAry addObject:AdLabel];
        AdLabel.userInteractionEnabled = YES; // Don't forget this, otherwise the gesture recognizer will fail (UILabel has this as NO by default)
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 500+i;
        button.frame = AdLabel.bounds;
        [button addTarget:self action:@selector(pauseTap:) forControlEvents:UIControlEventTouchUpInside];
        [AdLabel addSubview:button];
        
    }
    adtimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoChangeNews) userInfo:nil repeats:YES];
    
}
-(void)pauseTap:(UIButton*)tap{
    AdDetailViewController* addetail = [[AdDetailViewController alloc] init];
    addetail.titleStr = [[newsary objectAtIndex:tap.tag-500] objectForKey:@"title"];
    addetail.contenstr = [[newsary objectAtIndex:tap.tag-500] objectForKey:@"content"];

    [self.navigationController pushViewController:addetail animated:YES];
}
-(void)autoChangeNews{
    newsPage ++;
    if (newsPage >= newsary.count) {
        newsPage=0;
    }
    //    self.lunboPage.currentPage = currentPage;
//    for (MarqueeLabel* lab in AdlabAry) {
//        [lab pauseLabel];
//    }
//    MarqueeLabel *label = [AdlabAry objectAtIndex:newsPage];
//    [label unpauseLabel];
    
    if (newsPage == 0) {
        [adScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        return;
    }
    [adScrollView setContentOffset:CGPointMake( 0, GTFixHeightFlaot(17*newsPage)) animated:YES];
}
-(void)creatScrollBtn{
    if (!leftScrollBtn) {
        leftScrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftScrollBtn.hidden = YES;
        [leftScrollBtn setFrame:CGRectMake(GTFixWidthFlaot(15), self.view.center.y+40, GTFixWidthFlaot(18),GTFixHeightFlaot(30))];
        [leftScrollBtn setBackgroundImage:[UIImage imageNamed:@"qiantou1"] forState:UIControlStateNormal];
        [self.view addSubview:leftScrollBtn];
        rightScrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightScrollBtn setFrame:CGRectMake(GTFixWidthFlaot(320-15-18), self.view.center.y+40, GTFixWidthFlaot(18),GTFixHeightFlaot( 30))];
        [rightScrollBtn setBackgroundImage:[UIImage imageNamed:@"qiantou2"] forState:UIControlStateNormal];
        [self.view addSubview:rightScrollBtn];
        [rightScrollBtn addTarget:self action:@selector(torightCell) forControlEvents:UIControlEventTouchUpInside];
        [leftScrollBtn addTarget:self action:@selector(toLeftCell) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
-(void)toLeftCell{
    [self.middleScrollView setContentOffset:CGPointMake(self.middleScrollView.contentOffset.x-WIDTH_OF_SCREEN
                                                        , 0) animated:YES];
    
    [UIView animateWithDuration:.4 animations:^{
        leftScrollBtn.origin = CGPointMake(-leftScrollBtn.width, leftScrollBtn.origin.y);
        rightScrollBtn.origin = CGPointMake(ScreenWidth+rightScrollBtn.width, rightScrollBtn.origin.y);
        leftScrollBtn.transform =  CGAffineTransformMakeScale(0.1, 0.1);
        rightScrollBtn.transform  =  CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        
        leftScrollBtn.hidden = NO;
        rightScrollBtn.hidden = NO;
        if (self.middleScrollView.contentOffset.x == 0) {
            leftScrollBtn.hidden = YES;
        }
        [UIView animateWithDuration:.4 animations:^{
            leftScrollBtn.transform =  CGAffineTransformMakeScale(1, 1);
            rightScrollBtn.transform  =  CGAffineTransformMakeScale(1, 1);
            leftScrollBtn.origin = CGPointMake(GTFixWidthFlaot(15), leftScrollBtn.origin.y);
            rightScrollBtn.origin = CGPointMake(GTFixWidthFlaot(320-15-18), rightScrollBtn.origin.y);
            
        } completion:^(BOOL finished) {
        }];
    }];
}
-(void)torightCell{
    
    [self.middleScrollView setContentOffset:CGPointMake(WIDTH_OF_SCREEN+self.middleScrollView.contentOffset.x, 0) animated:YES];
    
    [UIView animateWithDuration:.4 animations:^{
        leftScrollBtn.origin = CGPointMake(-leftScrollBtn.width, leftScrollBtn.origin.y);
        rightScrollBtn.origin = CGPointMake(ScreenWidth+rightScrollBtn.width, rightScrollBtn.origin.y);
        leftScrollBtn.transform =  CGAffineTransformMakeScale(0.1, 0.1);
        rightScrollBtn.transform  =  CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        
        leftScrollBtn.hidden = NO;
        rightScrollBtn.hidden = NO;
        if (self.middleScrollView.contentOffset.x == self.middleScrollView.contentSize.width-self.middleScrollView.width) {
            rightScrollBtn.hidden = YES;
        }
        [UIView animateWithDuration:.4 animations:^{
            leftScrollBtn.transform =  CGAffineTransformMakeScale(1, 1);
            rightScrollBtn.transform  =  CGAffineTransformMakeScale(1, 1);
            leftScrollBtn.origin = CGPointMake(GTFixWidthFlaot(15), leftScrollBtn.origin.y);
            rightScrollBtn.origin = CGPointMake(GTFixWidthFlaot(320-15-18), rightScrollBtn.origin.y);
            
            
        } completion:^(BOOL finished) {
            
        }];


    }];
}
- (void)setupProductCellViews
{
    productCellViewArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < productInfoArray.count; i++) {
        
        float cellHeight = 258;
        cellHeight = self.middleContainer.height;
        //标记为日紫宝
        BOOL isRizibao = NO;
        if (i == 0) {
            isRizibao = YES;
        }
        ProductCellView *singleProductCell = [[ProductCellView alloc]initWithFrame:CGRectMake(i * (WIDTH_OF_SCREEN), 0, WIDTH_OF_SCREEN, cellHeight) isRIZIBAO:isRizibao];
        singleProductCell.backgroundColor = [UIColor whiteColor];
        
        
        /*
         * 回调
         */
        singleProductCell.investActionBlock = ^(id productInfo){
            [self pushOutProductDetailViewController:productInfo];
        };
        
        [productCellViewArray addObject:singleProductCell];
        
        self.middleScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * (i + 1), cellHeight);
        
        [self.middleScrollView addSubview: singleProductCell];
    }
    if(productInfoArray.count>1){
        [self creatScrollBtn];
    }
}

- (void)setupSingoleProductCell
{
//    float cellHeight = 258;
//    cellHeight = self.middleContainer.height;
//    ProductCellView *singleProductCell = [[ProductCellView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, cellHeight) isRIZIBAO:YES];
//    singleProductCell.backgroundColor = [UIColor whiteColor];
//    
//    singleProductCell.investActionBlock = ^(id productInfo){
//        
//    };
//    self.middleScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN, cellHeight);
//    [self.middleScrollView addSubview: singleProductCell];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 * 进入详细投资页面
 */
- (void)reloadProductData:(NSMutableArray *)proInfoArray
{
    for (int i = 0; i < productInfoArray.count; i++) {
        NSDictionary * singleProInfo = [productInfoArray objectAtIndex:i];
        ProductCellView * singleProductCell =[productCellViewArray objectAtIndex:i];
        [singleProductCell setupProductInfo:singleProInfo];
    }
}


/*
 * 进入详细投资页面
 */
- (void)pushOutProductDetailViewController:(NSDictionary *)singleInfo
{
//    [self.navigationController pushViewController:[[NewProductDetailViewController alloc] init] animated:YES];
//    return;
    
    NewProductDetailViewController* newDetail = [[NewProductDetailViewController alloc] init];
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"RIZIBAO"])
    newDetail.titleStr = @"财行宝";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"MORE_DAY"])
    newDetail.titleStr = @"财行加";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"YUEMANYING"])
    newDetail.titleStr = @"财月盈";

    [newDetail setValue:singleInfo forKey:@"productInfoDic"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
    [self.navigationController pushViewController:newDetail animated:YES];
    return;
  /*  if([[singleInfo valueForKey:@"productType"] isEqualToString:@"RIZIBAO"])
    {
       
        CLog(@"RIZIBAO");
        UIStoryboard * productDetail = [UIStoryboard storyboardWithName:@"RZBProductDetail" bundle:nil];
        RZBProductDetailViewController *ProductDetailVC = [productDetail instantiateViewControllerWithIdentifier:@"RZBProductDetailViewController"];
        
        //投资详情的信息
        [ProductDetailVC setIsFromHomePageVC:YES];
        [ProductDetailVC setValue:singleInfo forKey:@"productInfoDic"];
        if (!____IOS7____) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

        }
        [self.navigationController pushViewController:ProductDetailVC animated:YES];
        
    }
    else if ([[singleInfo valueForKey:@"productType"] isEqualToString:@"YUEMANYING"]||
             [[singleInfo valueForKey:@"productType"] isEqualToString:@"JIJIFENG"]||
             [[singleInfo valueForKey:@"productType"] isEqualToString:@"SHUANGJIXIN"]||
             [[singleInfo valueForKey:@"productType"] isEqualToString:@"NIANNIANHONG"])
    {
        UIStoryboard * productDetail = [UIStoryboard storyboardWithName:@"ProductDetail" bundle:nil];
        ProductDetailViewController *ProductDetailVC = [productDetail instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
        
        
        //投资成功后的刷新回调
        ProductDetailVC.updateHomePageAllDataBlock = ^(){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateAfterSuccessInvested];
            });
        };
        
        //投资详情的信息
        [ProductDetailVC setIsFromHomePageVC:YES];
        [ProductDetailVC setValue:singleInfo forKey:@"productInfoDic"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
        [self.navigationController pushViewController:ProductDetailVC animated:YES];
    }
    else
    {
        if ([[singleInfo valueForKey:@"productType"] isEqualToString:@"GONGYLJR"]
            ||[[singleInfo valueForKey:@"productType"] isEqualToString:@"PEIZIDAI"]
            ||[[singleInfo valueForKey:@"productType"] isEqualToString:@"PEIZI"])
        {
            UIStoryboard * productDetail = [UIStoryboard storyboardWithName:@"GYLProductDetail" bundle:nil];
            GYLProductDetailViewController *GYLProductDetailVC = [productDetail instantiateViewControllerWithIdentifier:@"GYLProductDetailViewController"];
            
            //投资详情的信息
            [GYLProductDetailVC setIsFromHomePageVC:YES];
            [GYLProductDetailVC setValue:singleInfo forKey:@"productInfoDic"];
            [self.navigationController pushViewController:GYLProductDetailVC animated:YES];
        }
        else
        {
            UIStoryboard * productDetail = [UIStoryboard storyboardWithName:@"ZDBProductDetail" bundle:nil];
            ZDBProductDetailViewController *ZDBProductDetailVC = [productDetail instantiateViewControllerWithIdentifier:@"ZDBProductDetailViewController"];
            //投资详情的信息
            [ZDBProductDetailVC setIsFromHomePageVC:YES];
            [ZDBProductDetailVC setValue:singleInfo forKey:@"productInfoDic"];
            if (!____IOS7____) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
                
            }
            [self.navigationController pushViewController:ZDBProductDetailVC animated:YES];
        }
    }
   */
}


#pragma mark ------------------ (滚动) UIScrollView delegate --------------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[self.middleScrollView class]]) {
        [self animationScrollBtnhidden];
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[self.middleScrollView class]]) {
        [self animationScrollBtnshow];
    }
    CLog(@"中间滚动栏位置 %f", scrollView.contentOffset.x / WIDTH_OF_SCREEN);
    
    [self.topScrollMenu scrollMenuToIndex: (NSInteger) scrollView.contentOffset.x / WIDTH_OF_SCREEN];
}

-(void)animationScrollBtnhidden{

    [UIView animateWithDuration:.4 animations:^{
        leftScrollBtn.origin = CGPointMake(-leftScrollBtn.width, leftScrollBtn.origin.y);
        rightScrollBtn.origin = CGPointMake(ScreenWidth+rightScrollBtn.width, rightScrollBtn.origin.y);
        leftScrollBtn.transform =  CGAffineTransformMakeScale(0.1, 0.1);
        rightScrollBtn.transform  =  CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)animationScrollBtnshow{
    leftScrollBtn.hidden = NO;
    rightScrollBtn.hidden = NO;
    if (self.middleScrollView.contentOffset.x == 0) {
        leftScrollBtn.hidden = YES;
    }
    if (self.middleScrollView.contentOffset.x == self.middleScrollView.contentSize.width-self.middleScrollView.width) {
        rightScrollBtn.hidden = YES;
    }
    [UIView animateWithDuration:.4 animations:^{
        leftScrollBtn.transform =  CGAffineTransformMakeScale(1, 1);
        rightScrollBtn.transform  =  CGAffineTransformMakeScale(1, 1);
        leftScrollBtn.origin = CGPointMake(GTFixWidthFlaot(15), leftScrollBtn.origin.y);
        rightScrollBtn.origin = CGPointMake(GTFixWidthFlaot(320-15-18), rightScrollBtn.origin.y);
        

    } completion:^(BOOL finished) {
       
    }];
}
#pragma mark ------------ （广告）SecretaryScrollCellView delegate ----------

-(void)openSecretaryDetailsWithUrl:(NSString *)url
{
#warning 关闭网页的打开
//    return;
    

//    self.hidesBottomBarWhenPushed=YES;
    
    
        HXWebViewController * webVC = [[HXWebViewController alloc]init];
    webVC.title = @"详情";
        [webVC setValue:url forKey:@"detailUrl"];
    if ([url isEqualToString:@""]) {
        return;
    }
    
    
//    
//    ZMPresentWebViewController * webVC = [[ZMPresentWebViewController alloc]init];
//    
    
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}



@end
