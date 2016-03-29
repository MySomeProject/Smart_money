//
//  SecretaryScrollCellView.m
//  miXin
//
//  Created by HAIXUN on 10/11/14.
//  Copyright (c) 2014 HAIXUN. All rights reserved.
//

#import "SecretaryScrollCellView.h"
#import "GTCommontHeader.h"

//广告数据库
#import "ZMFMDBOperation+AdBanner.h"

#define WIDTH_OF_IMAGE [[UIScreen mainScreen] bounds].size.width

//#define  K_Secretary_Height  125 * Ratio_OF_WIDTH_FOR_IPHONE6
//#define  K_Secretary_Height  153 * Ratio_OF_WIDTH_FOR_IPHONE6   
//#define  K_Secretary_Height  141 * Ratio_OF_WIDTH_FOR_IPHONE6
#define  K_Secretary_Height   GTFixHeightFlaot(110)



@implementation SecretaryScrollCellView

/*
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 
 if (self) {
 secretaryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, K_Secretary_Height)];
 [secretaryScrollView setBackgroundColor:[UIColor grayColor]];
 secretaryScrollView.delegate = self;
 secretaryScrollView.pagingEnabled = YES;
 secretaryScrollView.showsHorizontalScrollIndicator = NO;
 secretaryScrollView.showsVerticalScrollIndicator = NO;
 [secretaryScrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * 1, K_Secretary_Height)];
 
 pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((secretaryScrollView.frame.size.width - 240)/2,
 secretaryScrollView.frame.size.height - 40,
 240,
 20)];
 
 
 
 pageControl.pageIndicatorTintColor = [UIColor grayColor];           //MAIN_COFFEE_COLOR;
 pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];   //MAIN_BASE_COLOR;
 pageControl.currentPage = 0;
 pageControl.numberOfPages = 1;
 
 [self addSubview:secretaryScrollView];
 [self addSubview:pageControl];
 
 
 [self setUpAdBannerViews];
 
 //加载老数据
 //        [self loadingLocalSecretaries];
 
 
 
 
 
 
 
 
 //来的时候
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(applicationWillEnterForeground_getIcon:)
 name:UIApplicationWillEnterForegroundNotification
 object:nil];
 }
 return self;
 }
 */

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        secretaryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, K_Secretary_Height)];
        [secretaryScrollView setBackgroundColor:[UIColor whiteColor]];
        secretaryScrollView.delegate = self;
        secretaryScrollView.pagingEnabled = YES;
        secretaryScrollView.showsHorizontalScrollIndicator = NO;
        secretaryScrollView.showsVerticalScrollIndicator = NO;
        [secretaryScrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * 1, K_Secretary_Height)];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((secretaryScrollView.frame.size.width - 240)/2,
                                                                      secretaryScrollView.frame.size.height - 50,
                                                                      240,
                                                                      20)];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.currentPageIndicatorTintColor = Color_of_Purple;
        pageControl.currentPage = 0;
        pageControl.numberOfPages = 1;
        
        [self addSubview:secretaryScrollView];
        [self addSubview:pageControl];
        
        
        //创建广告栏（使用工程中的本地图片）。
//        [self loadingLocalSecretaries];

        //第一次加载新数据
        [self performSelector:@selector(getAdertisementBanners) withObject:nil afterDelay:0];
        //第二次醒来的时候下载新数据
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground_getIcon:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}



- (void)applicationWillEnterForeground_getIcon:(UIApplication *)application
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self getAdertisementBanners];
    });
}


/*
 * 加载数据库中的数据
 */
-(void)loadingLocalSecretaries
{
//    //加载视图
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setUpAdBannerViews];
//    });
//    return;
    
    [[ZMFMDBOperation sharedOperation] readAllAdBannersFromDatabaseSuccess:^(NSArray *adArray){
        
        //数据库无数据
        if (adArray == nil || [adArray count] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUpAdBannerViews];
            });
            
            return ;
        }
        
        //数据库有数据
        pageNumber = [adArray count];
        currentPage = 0;
        pageControl.currentPage = 0;
        
        staticAdsArray = nil;
        staticAdsArray = [NSMutableArray arrayWithArray:adArray];
        
        //加载视图
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpAdBannerViews];
        });
    }];
}


/**
 *  工程自带数据将视图创建起来
 */
-(void)setUpAdBannerViews
{
    //模拟数据 start
    NSMutableArray *secretaryArray = [NSMutableArray array];
    
    //重组网络数据
    if (staticAdsArray.count > 0) {
        for (int i = 0; i < staticAdsArray.count; i++) {
            NSDictionary *dic = [staticAdsArray objectAtIndex:i];
            [secretaryArray addObject:dic];
        }
    }
    else   //人工组装
    {
        for (int i = 0; i < 2; i++) {
            //人工组装图片
            NSMutableDictionary * dic  = [[NSMutableDictionary alloc] init];
            [dic setObject:[NSNumber numberWithInt:i] forKey:@"Id"];
            [dic setObject:[NSString stringWithFormat:@"banner%d@2x.png", i+1] forKey:@"bgimg"];
            [dic setObject:@"http://182.92.217.163:8081/home/about_plat.htm" forKey:@"url"];
            [dic setObject:[NSNumber numberWithInt:i] forKey:@"orderIndex"];
            [dic setObject:[NSNumber numberWithInt:-1] forKey:@"loanId"];
            [dic setObject:@"紫马财行" forKey:@"loanId"];
            [dic setObject:@"http://static.zimacaihang.com/" forKey:@"picUrl"];
            
            [secretaryArray addObject:dic];
        }
    }
    
    pageNumber = [secretaryArray count];
    currentPage = 0;
    pageControl.currentPage = 0;
    
    //模拟数据 end
    
    
//    CLog(@"最终数据 组装完成－secretaryArray = %@", secretaryArray);
    
    
    [secretaryScrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * pageNumber, K_Secretary_Height)];
    
    pageControl.numberOfPages = pageNumber;
    
    
    float width = [pageControl sizeForNumberOfPages:pageNumber].width;
    [pageControl setFrame:CGRectMake((secretaryScrollView.frame.size.width - width)/2,
                                     secretaryScrollView.frame.size.height *0.75,
                                     width,
                                     20)];
    
    //删除旧的小秘视图
    for(UIView *view in [secretaryScrollView subviews])
    {
        if ([view isKindOfClass:[SingleSecretaryView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < pageNumber; i++) {
        
        SingleSecretaryView * singleSecretaryView = [[SingleSecretaryView alloc] initWithFrame:CGRectMake(i * [[UIScreen mainScreen] bounds].size.width,
                                                                                                          0,
                                                                                                          [[UIScreen mainScreen] bounds].size.width,
                                                                                                          K_Secretary_Height)
                                                      withInfo:[secretaryArray objectAtIndex:i]];
        
        singleSecretaryView.delegate = self;
        
//      [secretaryScrollView addSubview:singleSecretaryView];
        
        [secretaryScrollView insertSubview:singleSecretaryView belowSubview:pageControl];
    }
    
    
    //自动
    [autoSlideTimer invalidate];
     autoSlideTimer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(changingSecretaryView:) userInfo:nil repeats:YES];
}




#pragma mark -------- banner 网络接口  --------
/**
 *  加载服务器上边新的广告
 */
- (void)getAdertisementBanners
{
    [[ZMServerAPIs shareZMServerAPIs] getAdBannersSuccess:^(id response) {
        
        NSMutableArray *secretaryArray = [[response objectForKey:@"data"] objectForKey:@"banners"];
        
        NSString * prefixPicUrl = [[response objectForKey:@"data"] objectForKey:@"picUrl"];
        
//        CLog(@"banner ---response = %@", secretaryArray);
        /*
         {
         bgimg = "bannerImg/20150506151850banner_1.png";
         createTime = "2015-04-15 16:59:22";
         enabled = 1;
         id = 11;
         loanId = "<null>";
         new = 0;
         orderIndex = 1;
         staffId = 1;
         type = MOBILE;
         updateTime = "2015-05-06 15:19:02";
         url = "active.htm";
         version = 1;
         },

         picUrl = "http://static.zimacaihang.com/";
         
         */
        
        if (secretaryArray == nil || [secretaryArray count] == 0) {
            return ;
        }
        
        pageNumber = [secretaryArray count];
        currentPage = 0;
        pageControl.currentPage = 0;
        pageControl.numberOfPages = pageNumber;
        
        //将数据更新到数据库
        [[ZMFMDBOperation sharedOperation] updateDatabaseWithAdBannerInfo:secretaryArray  prefix:(NSString *)prefixPicUrl with:k_AdBannerOperation_Update];
        
        //加载已经保存在数据库中的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadingLocalSecretaries];
        });
        
    } failure:^(id response) {
        //加载已经保存在数据库中的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadingLocalSecretaries];
        });
    }];
}






///切换视图
-(void)changingSecretaryView:(NSTimer *)Timer
{
//    CLog(@"changingSecretaryView tag = %d",        self.tag);
    if (self.tag == 100000) {
        return;
    }

    
    if (currentPage == 0)//第0个
    {
        CLog(@"0 第 %d 个", currentPage);
        [secretaryScrollView scrollRectToVisible:CGRectMake(0, 0, WIDTH_OF_IMAGE, K_Secretary_Height) animated:NO];
        currentPage ++;
    }
    else if (currentPage == pageNumber-1)//最后一个
    {
        CLog(@"最后一个 第 %d 个", currentPage);
        [secretaryScrollView scrollRectToVisible:CGRectMake(currentPage * WIDTH_OF_IMAGE, 0, WIDTH_OF_IMAGE, K_Secretary_Height) animated:YES];
        currentPage = 0;
    }
    else
    {
        CLog(@"X 第 %d 个", currentPage);
        [secretaryScrollView scrollRectToVisible:CGRectMake(currentPage * WIDTH_OF_IMAGE, 0, WIDTH_OF_IMAGE, K_Secretary_Height) animated:YES];
        currentPage ++;
    }
}

#pragma mark -------- UIScrollView delegate  --------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / [[UIScreen mainScreen] bounds].size.width;
    pageControl.currentPage = page;
    currentPage = page;
}



#pragma mark   ------------------SingleSecretaryViewDelegate------------------
-(void)singleSecretaryTapped:(NSString *)UrlString
{
    if([self.delegate respondsToSelector:@selector(openSecretaryDetailsWithUrl:)])
    {
        [self.delegate openSecretaryDetailsWithUrl:UrlString];
    }
    
}

@end
