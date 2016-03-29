//
//  NewFeatureViewController.m
//  ESchool
//
//  Created by 吉祥光 on 14-8-8.
//  Copyright (c) 2014年 jxgg. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "ZMLogInLogOutViewController.h"
#define kCount 4
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

@interface NewFeatureViewController (){
    UIPageControl *_pageControl;
}

@end

@implementation NewFeatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSUserDefaults standardUserDefaults]setObject:@"friest" forKey:@"firstLauch"];
    }
    return self;
}
#pragma mark - 自定义控制器的View
-(void)loadView
{
    [super loadView];
/*
    // 注意: 这里的imageView没有设置宽高，只要时控制器的view就不需要设置宽高
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = [UIScreen mainScreen].bounds;
    [UIApplication sharedApplication].statusBarHidden = YES;
    imageView.image = [UIImage imageNamed:@"引导1-2209.png"];
    imageView.image = [UIImage imageNamed:@"new_feature_background.png"];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//  iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
     }
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
*/

}
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
//view已经加载完毕
- (void)viewDidLoad
{
//    MyLog(@"%@",NSStringFromCGRect(self.view.bounds));
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize viewSize = self.view.frame.size;
    //1.加载UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(kCount*viewSize.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    for (int i = 0; i< kCount; i++) {
        [self addImageViewAtIndex:i inView:scrollView];
    }
    [self.view addSubview:scrollView];
    //2. 加载UIPageView
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //viewSize.height*0.9为了保证屏幕适配
    if (iPhone5) {
        pageControl.center = CGPointMake(viewSize.width/2, viewSize.height*0.86);
    }else
    {
        pageControl.center = CGPointMake(viewSize.width/2, viewSize.height*0.88);
    }
    
    pageControl.bounds = CGRectMake(0, 0, 100, 0);
    pageControl.numberOfPages = kCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    [self.view addSubview:pageControl];
    _pageControl = pageControl;
}
#pragma mark - 滚动代理
#pragma mark - 减速完毕就会调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
-(void)addImageViewAtIndex:(int)index inView:(UIView *)view
{
    CGSize viewSize = self.view.frame.size;
    //1.创建imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(index*viewSize.width, 0, viewSize.width, viewSize.height);
    //2.设置图片
    NSString *name;
#define  ScreenHeight  [UIScreen mainScreen].bounds.size.height
    if (ScreenHeight>500) {
       name  = [NSString stringWithFormat:@"引导页%d.jpg",index+1];
    }else{
        name  = [NSString stringWithFormat:@"yindaoye4%d.jpg",index+1];
    }
    UIImage *image = [UIImage imageNamed:name];
    //    UIImage *image = [UIImage imageNamed:name];
    imageView.image = image;
    //3.添加图片
    [view addSubview:imageView];
    //4.如果是最后一张图片添加一个按钮
    if (index==kCount-1) {
        [self addBtnInView:imageView];
    }
}
#pragma mark - 添加按钮
-(void)addBtnInView:(UIView*)view
{
    view.userInteractionEnabled = YES;
    CGSize viewSize = self.view.frame.size;
    //开始按钮
    UIButton *starBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    starBtn.frame = CGRectMake(0, 0, WIDTH_OF_SCREEN, ScreenHeight/4);
    starBtn.frame = CGRectMake(WIDTH_OF_SCREEN/320*169, HEIGHT_OF_SCREEN/568*500, WIDTH_OF_SCREEN/320*133, HEIGHT_OF_SCREEN/568*37);
    [starBtn setBackgroundImage:[UIImage imageNamed:@"anniu2.png"] forState:UIControlStateNormal];
    [starBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [starBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    starBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:starBtn];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(WIDTH_OF_SCREEN/320*18, HEIGHT_OF_SCREEN/568*500, WIDTH_OF_SCREEN/320*133, HEIGHT_OF_SCREEN/568*37);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"anniu.png"] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录／注册" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:loginButton];
    

    
    
    [loginButton addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    starBtn.center = CGPointMake(viewSize.width*0.5, ScreenHeight/4*3);
//
//    if (iPhone5) {
//        starBtn.center = CGPointMake(viewSize.width*0.5, 964/2+18);
//    }
//    
//    if (ScreenHeight>600) {
//        starBtn.center = CGPointMake(viewSize.width*0.5, ScreenHeight/4*3);
//
//    }
    
    //    starBtn.bounds = (CGRect){CGPointZero,startNormal.size};
    //starBtn.bounds = CGRectMake(0, 0, startNormal.size.width, startNormal.size.height);
    [starBtn addTarget:self action:@selector(startBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)startBtnClick
{
    if (_starXJEducate) {
        _starXJEducate();
    }
}

-(void)loginBtnClick{
//    ZMLogInLogOutViewController *lilvc = [[ZMLogInLogOutViewController alloc] init];
//    [self presentViewController:lilvc animated:YES completion:nil];
    if (_starAddlogin) {
        _starAddlogin();
    }
 
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
