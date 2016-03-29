//
//  newHomeViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/9/9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "newHomeViewController.h"

#import "ScrollMenu.h"
#import "SecretaryScrollCellView.h"


#import "ZMPresentWebViewController.h"
#import "UIImageView+WebCache.h"



#import "MineCenterViewController.h"
#import "AdDetailViewController.h"
#import "MarqueeLabel.h"

#import "NewProductDetailViewController.h"
#import "GTCommontHeader.h"
#import "Reachability.h"
#import "HUD.h"
#import "CycleScrollView.h"
#import "NewProductCellView.h"
#import "MobClick.h"
@interface newHomeViewController (){
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
    NSMutableArray* bannerAry;
    NSMutableArray   *_picAry;       //轮播图数据源
    NSString * BaseUrl;
    UIImageView *mallImageview; //轮播图placeholder;
    UIView* noNetView; //没网页面加载;
    int newsPage; //
    BOOL isWiFi;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *middleScrollView;
@property (nonatomic, strong) CycleScrollView *cycleView;   //轮播图

@end
#define BANNERH 175
@implementation newHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:60];
//    [self.cycleView.animationTimer setFireDate:[NSDate distantPast]];
    [self.cycleView.animationTimer setFireDate:[NSDate date]];

    [self.navigationController.navigationBar setHidden:YES];
    NSTimeInterval tentime = 3;
    [adScrollView setContentOffset:CGPointMake( 0, GTFixHeightFlaot(22*newsPage)) animated:YES];
    [adtimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:tentime]];
    
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
    if ([productInfoArray count] > 0) {
        productInfoArray = nil;
        [self requestProduct];
    }else{
        [self requestListData];
    }
    [MobClick beginLogPageView:@"首页"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (int i = 0; i < productInfoArray.count; i++) {
        NSDictionary * singleProInfo =[NSMutableDictionary dictionaryWithDictionary:[productInfoArray objectAtIndex:i]];
        NewProductCellView * singleProductCell =[productCellViewArray objectAtIndex:i];
        [singleProInfo setValue:[singleProInfo objectForKey:@"amount"] forKey:@"availabeAmount"];
        [singleProductCell setupProductInfo:singleProInfo];
    }
    [self.cycleView.animationTimer setFireDate:[NSDate distantFuture]];
    [adtimer setFireDate:[NSDate distantFuture]];
    
    [MobClick endLogPageView:@"首页"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (CURRENT_SYSTEM_VERSION>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
    }
    self.middleScrollView.frame = GetFramByXib(self.middleScrollView.frame);
    newsPage = 0;
    
    isWiFi = NO;
    
    AdlabAry = [[NSMutableArray alloc] init];
    bannerAry = [[NSMutableArray alloc] init];
    
//    [self viewChangeFrame];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 77, 26)];
    logoImageView.image = [UIImage imageNamed:@"caihangjialogo"];
    self.navigationItem.titleView = logoImageView;
    
    
    
    productInfoArray = [[NSMutableArray alloc]init];
    
    
    //中间滚动栏
    self.middleScrollView.pagingEnabled = YES;
    self.middleScrollView.delegate = self;
    //    self.middleScrollView.scrollEnabled = NO;
    
    //广告栏目
    
//    [self setupSingoleProductCell];
    
    [self creatADBar];
    [self creatNoNetView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}
-(void)creatNoNetView{
    mallImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH))];
    mallImageview.image = [UIImage imageNamed:@"BannerPl"];
    [self.view addSubview:mallImageview];
    
    noNetView = [[UIView alloc] initWithFrame:self.middleScrollView.frame];
    noNetView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* tipMen = [[UIImageView alloc] init];
    tipMen.image = [UIImage imageNamed:@"tishiren"];
    [tipMen setFrame:CGRectMake(0, 0, GTFixWidthFlaot(97), GTFixHeightFlaot(116))];
    tipMen.center = CGPointMake(GTFixWidthFlaot(160), GTFixHeightFlaot(150));
    [noNetView addSubview:tipMen];
    
    UILabel* label  = [[UILabel alloc] initWithFrame:CGRectMake(0, tipMen.bottom+10, WIDTH_OF_SCREEN, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.tag = 201;
    [label setText:@"精彩马上呈现,请稍候..."];
    [label setTextColor:[UIColor colorWithRed:160/255.0f green:160/255.0f blue:160/255.0f alpha:1]];
    
    [noNetView addSubview:label];
    
    if (HEIGHT_OF_SCREEN == 480) {
        tipMen.center = CGPointMake(GTFixWidthFlaot(160), GTFixHeightFlaot(100));
        label.frame =  CGRectMake(0, tipMen.bottom+10, WIDTH_OF_SCREEN, 20);
        
    }
    
    [self.view addSubview:noNetView];
    
    

}
//请求数据
-(void)requestListData{

    [[ZMServerAPIs shareZMServerAPIs] getAdBannersSuccess:^(id response) {
        BaseUrl = [[response objectForKey:@"data"] objectForKey:@"picUrl"];
        if (bannerAry.count>0) {
            [bannerAry removeAllObjects];
        }
        [bannerAry addObjectsFromArray:[[response objectForKey:@"data" ] objectForKey:@"banners"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initCycleView];
        });
                       
    } failure:^(id response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [mallImageview setImage:[UIImage imageNamed:@"bannerdefault.jpg"]];
            });
            CLog(@"首页推荐项目－失败 ＝ %@", response);
    }];
    [self requestProduct];

}
-(void)requestProduct{
    [[ZMServerAPIs shareZMServerAPIs] recommendedItemsSuccess:^(id response) {
        CLog(@"首页推荐项目－成功 ＝ %@", response);
        
        productInfoArray = [[response objectForKey:@"data"] objectForKey:@"ALLProductVOs"];
        newsary = [[response objectForKey:@"data"] objectForKey:@"news"] ;
        //刷新首页项目数据
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            if (productCellViewArray.count == 0) {
                if (productInfoArray.count>0) {
                    for (UIView * view in self.middleScrollView.subviews ) {
                        [view removeFromSuperview];
                    }

                }else{
                    UILabel* label =(UILabel*)[noNetView viewWithTag:201];
                    [label setText:@"暂时无可用数据哦"];
                    
                }
//                [self performSelector:@selector(removernoNet) withObject:nil afterDelay:2.0f];
                [self removernoNet];

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
            UILabel* label =(UILabel*)[noNetView viewWithTag:201];
            [label setText:@"网络异常,暂时无法显示数据哦"];
        });
        CLog(@"首页推荐项目－失败 ＝ %@", response);
    }];
    

}
-(void)removernoNet{
    [UIView animateWithDuration:0.25 animations:^{
        noNetView.alpha =0 ;
    }];
//    [noNetView removeFromSuperview];

}
//网络连接检查
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable])
    {
        if (newsary.count == 0) {
//            if ([reach.currentReachabilityString isEqualToString:@"WiFi"]) {
                [self requestListData];
//            }
        }
        
    }
    else
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"网络异常,请检查网络"];
        
    }
    
}
#pragma mark - 轮播图生成

- (void)createScorePic
{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i < bannerAry.count; ++i) {
        UIImageView *tempImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH))];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",BaseUrl,[[bannerAry objectAtIndex:i] objectForKey:@"bgimg"]];

        [tempImage sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@""]];
        
        //        [tempImage sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/3b87e950352ac65c478e556ff8f2b21193138a26.jpg"] placeholderImage:[UIImage imageNamed:@"picmoren"]];
        
        //        [tempImage setImage:[UIImage imageNamed:@"msxq_0008_content_activity"]];
        //        tempImage.contentMode = UIViewContentModeScaleAspectFit;
        tempImage.backgroundColor = [UIColor whiteColor];
        [viewsArray addObject:tempImage];
    }
    self.cycleView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH)) animationDuration:2];
    self.cycleView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:self.cycleView];
    
    self.cycleView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    
    //轮播图个数
    self.cycleView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    
    //轮播图点击事件
    __block newHomeViewController *blockSelf = self;
    self.cycleView.TapActionBlock = ^(NSInteger pageIndex){
//        NSLog(@"点击了第%d个",pageIndex);
        
        
//        blockSelf-> _pageIndex = [NSNumber numberWithInt:pageIndex];
//        NSString*  actid =[[blockSelf->_LunbotudataArray objectAtIndex:pageIndex] objectForKey:@"activityId"];
//        ActioninfoViewController* actinfo = [[ActioninfoViewController alloc] init];
//        actinfo.ActyID = actid;
//        actinfo.bmsccess = ^ void (BOOL isSuccessful){
//        };
//        [blockSelf.navigationController pushViewController:actinfo animated:YES];
        //        NSString* str = [NSString stringWithFormat:@"http://192.168.10.85:8084/HPYUserServer/staticHtml/activity/%@/%@_activityDetail.html",actid,actid];
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
}


-(void)initCycleView
{
    if (!_picAry) {
        _picAry = [@[] mutableCopy];
    }
    //截取最新5张轮播图
    //    if (_LunbotudataArray.count > 5) {
    //        [_LunbotudataArray removeObjectsInRange:NSMakeRange(5,_LunbotudataArray.count - 5)];
    //    }
    //添加轮播图数据源
    if (bannerAry.count ==1) {
        UIImageView *tempImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH))];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",BaseUrl,[[bannerAry objectAtIndex:1] objectForKey:@"bgimg"]];
        [tempImage sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@""]];
        
        //        [tempImage sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/3b87e950352ac65c478e556ff8f2b21193138a26.jpg"] placeholderImage:[UIImage imageNamed:@"picmoren"]];
        
        //        [tempImage setImage:[UIImage imageNamed:@"msxq_0008_content_activity"]];
        //        tempImage.contentMode = UIViewContentModeScaleAspectFit;
        tempImage.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tempImage];
//        [self.midview addSubview:tempImage];
        return;
    }
    //    if (_LunbotudataArray.count > 5) {
    //        [_LunbotudataArray removeObjectsInRange:NSMakeRange(5,_LunbotudataArray.count - 5)];
    //    }
    [_picAry removeAllObjects];
    for (int i = 0; i < bannerAry.count; ++i) {
        UIImageView *tempImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH))];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",BaseUrl,[[bannerAry objectAtIndex:i] objectForKey:@"bgimg"]];
        [tempImage sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"BannerPl"]];
        
        //        [tempImage sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/3b87e950352ac65c478e556ff8f2b21193138a26.jpg"] placeholderImage:[UIImage imageNamed:@"picmoren"]];
        
        //        [tempImage setImage:[UIImage imageNamed:@"msxq_0008_content_activity"]];
        //        tempImage.contentMode = UIViewContentModeScaleAspectFit;
        tempImage.backgroundColor = [UIColor whiteColor];
        [_picAry addObject:tempImage];
    }
    //添加轮播图
    [self addCycleViewwithCount:_picAry.count];
}
-(void)addCycleViewwithCount:(NSInteger)count
{
    //无轮播图
    if (count > 0) {
        [mallImageview removeFromSuperview];
    }else if(count == 0){
        [mallImageview setImage:[UIImage imageNamed:@"bannerdefault.jpg"]];
    }
    //有轮播图 重置数据源
    NSMutableArray *viewsArray = [@[] mutableCopy];
    [viewsArray performSelector:@selector(removeAllObjects) withObject:self];
    viewsArray = [NSMutableArray arrayWithArray:_picAry];
    
    //若无轮播图生成轮播图
    if (!self.cycleView) {
        self.cycleView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0 , 0, WIDTH_OF_SCREEN, GTFixHeightFlaot(BANNERH)) animationDuration:5];
        self.cycleView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
        [self.view addSubview:self.cycleView];
    }
    
    //轮播图数据源
    self.cycleView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    
    //轮播图个数
    self.cycleView.totalPagesCount = ^NSInteger(void){
        return count;
    };
    
    //轮播图点击事件

    __block newHomeViewController *blockSelf = self;
    self.cycleView.TapActionBlock = ^(NSInteger pageIndex){
      NSDictionary* dic =  (NSDictionary*)[bannerAry objectAtIndex:pageIndex];
        
     NSString* url =   [dic objectForKey:@"url"];
        if ([url isEqualToString:@""]) {
            return;
        }
        
        HXWebViewController * webVC = [[HXWebViewController alloc]init];
        webVC.title = @"详情";
        [webVC setValue:url forKey:@"detailUrl"];
        
        webVC.shareTitle = [dic objectForKey:@"shareTitle"];
        webVC.shareContent =[dic objectForKey:@"shareCenter"];
        webVC.shareImage =[NSString stringWithFormat:@"%@%@",BaseUrl,[dic objectForKey:@"shareImgurl"]];
        
        webVC.shareUrl = [dic objectForKey:@"shareUrl"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

        [blockSelf.navigationController pushViewController:webVC animated:YES];
        
//
//        
//        blockSelf-> _pageIndex = [NSNumber numberWithInt:pageIndex];
//        NSString*  actid =[[blockSelf->_LunbotudataArray objectAtIndex:pageIndex] objectForKey:@"activityId"];
//        ActioninfoViewController* actinfo = [[ActioninfoViewController alloc] init];
//        actinfo.ActyID = actid;
//        actinfo.bmsccess = ^ void (BOOL isSuccessful){
//        };
//        [blockSelf.navigationController pushViewController:actinfo animated:YES];
//        //        NSString* str = [NSString stringWithFormat:@"http://192.168.10.85:8084/HPYUserServer/staticHtml/activity/%@/%@_activityDetail.html",actid,actid];
//        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
}
#pragma mark - 广告条生成

//广告条
-(void)creatADBar{
    UIView* bgview = [[UIView alloc] init];
    [bgview setBackgroundColor: [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1]];
    bgview.frame = CGRectMake(0,GTFixHeightFlaot(175), GTFixWidthFlaot(320),GTFixHeightFlaot(22));
    [self.view addSubview:bgview];
    
    UIImageView* labImg = [[UIImageView alloc] init];
    [labImg setImage:[UIImage imageNamed:@"gonggao"]];
    [labImg setFrame:CGRectMake(0,GTFixHeightFlaot(175), GTFixWidthFlaot(22), GTFixHeightFlaot(22))];
    [self.view addSubview:labImg];
    
    adScrollView = [[UIScrollView alloc] init];
    adScrollView.frame = CGRectMake(GTFixWidthFlaot(22), GTFixHeightFlaot(175), GTFixHeightFlaot(300), GTFixHeightFlaot(22));
    adScrollView.contentSize = CGSizeMake(GTFixWidthFlaot(300) , GTFixHeightFlaot(22*newsary.count));
    adScrollView.scrollEnabled = NO;
    [self.view addSubview:adScrollView];
}
//刷新广告条

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
        AdLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(13)];
        AdLabel.backgroundColor = [UIColor clearColor];
        //        [AdLabel pauseLabel];
        //        AdLabel.trailingBuffer = 30.0f;
        AdLabel.text = @"紫马理财正式上线啦,多种活动哦！";
        AdLabel.text = [[newsary objectAtIndex:i] objectForKey:@"title"];
        AdLabel.frame = CGRectMake(GTFixHeightFlaot(5),GTFixHeightFlaot(22)*i, GTFixWidthFlaot(295),GTFixHeightFlaot(22));
        [adScrollView addSubview:AdLabel];
        [AdlabAry addObject:AdLabel];
        AdLabel.userInteractionEnabled = YES; // Don't forget this, otherwise the gesture recognizer will fail (UILabel has this as NO by default)
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 500+i;
        button.frame = AdLabel.bounds;
        [button addTarget:self action:@selector(pauseTap:) forControlEvents:UIControlEventTouchUpInside];
        [AdLabel addSubview:button];
        
    }
    adtimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoChangeNews) userInfo:nil repeats:YES];
    
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
    [adScrollView setContentOffset:CGPointMake( 0, GTFixHeightFlaot(22*newsPage)) animated:YES];
}

-(void)creatScrollBtn{
    if (!leftScrollBtn) {
        leftScrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftScrollBtn.hidden = YES;
        [leftScrollBtn setFrame:CGRectMake(GTFixWidthFlaot(15), self.view.center.y+40, GTFixWidthFlaot(10),GTFixHeightFlaot(22))];
        [leftScrollBtn setBackgroundImage:[UIImage imageNamed:@"qiantou1"] forState:UIControlStateNormal];
        [self.view addSubview:leftScrollBtn];
        rightScrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightScrollBtn setFrame:CGRectMake(GTFixWidthFlaot(320-15-18), self.view.center.y+40, GTFixWidthFlaot(10),GTFixHeightFlaot(22))];
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
        
        float cellHeight = GTFixHeightFlaot(335);
        cellHeight = self.middleScrollView.height;
        //标记为日紫宝
        BOOL isRizibao = NO;
        if (i == 0) {
            isRizibao = YES;
        }
//        ProductCellView *singleProductCell = [[ProductCellView alloc]initWithFrame:CGRectMake(i * (WIDTH_OF_SCREEN), 0, WIDTH_OF_SCREEN, cellHeight) isRIZIBAO:isRizibao];
//        singleProductCell.backgroundColor = [UIColor whiteColor];
//        
//        
//        /*
//         * 回调
//         */
//        singleProductCell.investActionBlock = ^(id productInfo){
//            [self pushOutProductDetailViewController:productInfo];
//        };
//        
//        [productCellViewArray addObject:singleProductCell];
//        
//        self.middleScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * (i + 1), cellHeight);
//
        NewProductCellView* newview = [[NewProductCellView alloc] initWithFrame:CGRectMake(i * (WIDTH_OF_SCREEN), 0, WIDTH_OF_SCREEN,GTFixHeightFlaot(335))];
        [productCellViewArray addObject:newview];
        newview.investActionBlock = ^(id productInfo){
            [self pushOutProductDetailViewController:productInfo];
        };
        self.middleScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * (i + 1), cellHeight);
        [self.middleScrollView addSubview: newview];

    }
    if(productInfoArray.count>1){
        [self creatScrollBtn];
    }
}
/*
 * 进入详细投资页面
 */
- (void)reloadProductData:(NSMutableArray *)proInfoArray
{
    for (int i = 0; i < productInfoArray.count; i++) {
        NSDictionary * singleProInfo = [productInfoArray objectAtIndex:i];
        NewProductCellView * singleProductCell =[productCellViewArray objectAtIndex:i];
        [singleProductCell setupProductInfo:singleProInfo];
    }
}

/*
 * 进入详细投资页面
 */
- (void)pushOutProductDetailViewController:(NSDictionary *)singleInfo
{
   
    
    NewProductDetailViewController* newDetail = [[NewProductDetailViewController alloc] init];
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"RIZIBAO"])
        newDetail.titleStr = @"财行宝";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"MORE_DAY"])
        newDetail.titleStr = @"财行加";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"YUEMANYING"])
        newDetail.titleStr = @"财月盈";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"CAIXIANGYU"])
        newDetail.titleStr = @"财相遇";
    if([[singleInfo valueForKey:@"productType"] isEqualToString:@"JIJIFENG"])
        newDetail.titleStr = @"财季盈";
    
    [newDetail setValue:singleInfo forKey:@"productInfoDic"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
    [self.navigationController pushViewController:newDetail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
