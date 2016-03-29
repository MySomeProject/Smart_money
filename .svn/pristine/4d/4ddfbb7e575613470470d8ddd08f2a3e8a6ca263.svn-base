//
//  BaseViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-3.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BaseViewController.h"
#import <Accelerate/Accelerate.h>

#import "LeftMenuViewController.h"


#import "HomePageViewController.h"
#import "FinancingViewController.h"

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]


@interface BaseViewController ()<UIScrollViewDelegate>
{
    UIImageView *imgV_blur;
    UIView *view_shadow;
    
    NSArray * subRootControllers;
    
    LeftMenuViewController *leftMenuVC;
}

@end

@implementation BaseViewController

- (void)awakeFromNib
{
//    首页
    UIStoryboard * homePage = [UIStoryboard storyboardWithName:@"HomePage4" bundle:nil];
//    HomePageViewController *vc0 = [homePage instantiateViewControllerWithIdentifier:@"HomePageViewController"];

    
    HomePageViewController *vc0 = [[HomePageViewController alloc]init];
    
    
    
    UIStoryboard * financing = [UIStoryboard storyboardWithName:@"Financing" bundle:nil];
    FinancingViewController *vc1 = [financing instantiateViewControllerWithIdentifier:@"FinancingViewController"];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    [vc2.view setBackgroundColor:[UIColor purpleColor]];
    UIViewController *vc3 = [[UIViewController alloc]init];
    [vc3.view setBackgroundColor:[UIColor blueColor]];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    [vc4.view setBackgroundColor:[UIColor yellowColor]];
    UIViewController *vc5 = [[UIViewController alloc]init];
    [vc5.view setBackgroundColor:[UIColor greenColor]];
    
//    ZMNavigationController *nav0 = [[ZMNavigationController alloc]initWithRootViewController:vc0];
//    ZMNavigationController *nav1 = [[ZMNavigationController alloc]initWithRootViewController:vc1];
//    ZMNavigationController *nav2 = [[ZMNavigationController alloc]initWithRootViewController:vc2];
//    ZMNavigationController *nav3 = [[ZMNavigationController alloc]initWithRootViewController:vc3];
//    ZMNavigationController *nav4 = [[ZMNavigationController alloc]initWithRootViewController:vc4];
//    ZMNavigationController *nav5 = [[ZMNavigationController alloc]initWithRootViewController:vc5];
    
    vc0.title = @"首页";
    vc1.title = @"我要理财";
    vc2.title = @"安全保障";
    vc3.title = @"关于我们";
    vc4.title = @"服务网点";
    vc5.title = @"设置";
    
    //导航栏左侧按钮
    vc0.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    vc1.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    vc2.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    vc3.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    vc4.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    vc5.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self setupMenuButton]];
    
    
    subRootControllers = @[vc0, vc1, vc2, vc3, vc4, vc5];
//    subRootControllers = @[nav0, nav1, nav2, nav3, nav4, nav5];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFunctionMenu];
    
    [self addChildViewController:subRootControllers[0]];
    
    /*
    //底部
    NSInteger scrollViewHeight = HEIGHT_OF_SCREEN - 64;
    self.tablesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           64,
                                                                           WIDTH_OF_SCREEN,
                                                                           scrollViewHeight)];
    self.tablesScrollView.pagingEnabled = YES;
    self.tablesScrollView.showsVerticalScrollIndicator = NO;
    self.tablesScrollView.showsHorizontalScrollIndicator = NO;
    self.tablesScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * subRootControllers.count, scrollViewHeight);
    self.tablesScrollView.delegate = self;
    [self.view addSubview:self.tablesScrollView];
    [self.tablesScrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    
    //添加子列表视图
    [self setUpAllTableViews];
     */
}

-(void)setUpAllTableViews
{
    for (int i = 0; i < subRootControllers.count; i++) {
        CGRect tableViewRect = CGRectMake(0 + WIDTH_OF_SCREEN * i, 0, self.tablesScrollView.frame.size.width, self.tablesScrollView.frame.size.height);
        
        UIViewController *subViewController = subRootControllers[i];
        
        subViewController.view.frame = tableViewRect;
        
        [self.tablesScrollView addSubview:subViewController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//[self.dynamicsDrawerViewController setPaneViewController:paneNavigationViewController animated:animateTransition completion:nil];

/*
- (void)setPaneViewController:(UIViewController *)paneViewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    NSParameterAssert(paneViewController);
    if (!animated) {
        self.paneViewController = paneViewController;
        if (completion) completion();
        return;
    }
    if (self.paneViewController != paneViewController) {
        [self.paneViewController willMoveToParentViewController:nil];
        [self.paneViewController beginAppearanceTransition:NO animated:animated];
        void(^transitionToNewPaneViewController)() = ^{
            [paneViewController willMoveToParentViewController:self];
            [self.paneViewController.view removeFromSuperview];
            [self.paneViewController removeFromParentViewController];
            [self.paneViewController didMoveToParentViewController:nil];
            [self.paneViewController endAppearanceTransition];
            [self addChildViewController:paneViewController];
            paneViewController.view.frame = (CGRect){CGPointZero, self.paneView.frame.size};
            [paneViewController beginAppearanceTransition:YES animated:animated];
            [self.paneView addSubview:paneViewController.view];
            _paneViewController = paneViewController;
            // Force redraw of the new pane view (drastically smoothes animation)
            [self.paneView setNeedsDisplay];
            [CATransaction flush];
            [self setNeedsStatusBarAppearanceUpdate];
            // After drawing has finished, add new pane view controller view and close
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak typeof(self) weakSelf = self;
                _paneViewController = paneViewController;
                [self setPaneState:MSDynamicsDrawerPaneStateClosed animated:animated allowUserInterruption:YES completion:^{
                    [paneViewController didMoveToParentViewController:weakSelf];
                    [paneViewController endAppearanceTransition];
                    if (completion) completion();
                }];
            });
        };
        if (self.paneViewSlideOffAnimationEnabled) {
            [self setPaneState:MSDynamicsDrawerPaneStateOpenWide animated:animated allowUserInterruption:NO completion:transitionToNewPaneViewController];
        } else {
            transitionToNewPaneViewController();
        }
    }
    // If trying to set to the currently visible pane view controller, just close
    else {
        [self setPaneState:MSDynamicsDrawerPaneStateClosed animated:animated allowUserInterruption:NO completion:^{
            if (completion) completion();
        }];
    }
}
*/


//-(void)setupFunctionVCWithIndex:(NSInteger)index
//{
//    NSLog(@"hhhhh %ld", index);
//    
//    UIViewController *childController = subRootControllers[index];
//    
//    [childController willMoveToParentViewController:self];
//    
//    childController.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
//    
//    // add new Controller as a child to the container view controller (self)
//    [self addChildViewController:childController];
//    
//    // notify old controller that it will be removed from child viewControllers
//    [self.paneViewController willMoveToParentViewController:nil];
//    
//    // remove old controller from child viewControllers
//    [self.paneViewController removeFromParentViewController];
//    
//    // notify the new controller that it was added to child viewControllers
//    [childController didMoveToParentViewController:self];
//    
//    self.paneViewController = childController;
//}


/*
 *添加右侧菜单按钮
 */
- (UIButton *)setupMenuButton{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setBackgroundColor:[UIColor clearColor]];
    menuButton.frame = CGRectMake(0, 0, 44, 44);
    [menuButton setImageEdgeInsets:UIEdgeInsetsMake(14, 10, 15, 11)];
    [menuButton setImage:[UIImage imageNamed:@"rightMenuBtn_default.png"] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:@"rightMenuBtn_highlight.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return menuButton;
}

-(void)menuButtonPressed:(UIButton *)button
{
    [self showMenuAndBlur];
}

/*
 * 创建侧滑功能菜单
 */
-(void)setupFunctionMenu
{
    imgV_blur = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgV_blur.alpha = 0;
    //    imgV_blur.image = [self blurryImage:[self imageFromView:self.view] withBlurLevel:0.2];
    imgV_blur.userInteractionEnabled = YES;
    [self.view addSubview:imgV_blur];
    
    view_shadow = [[UIView alloc] initWithFrame:self.view.bounds];
    view_shadow.backgroundColor = [UIColor blackColor];
    view_shadow.alpha = 0;
    [imgV_blur addSubview:view_shadow];
    
    UIStoryboard *leftMenu = [UIStoryboard storyboardWithName:@"LeftMenu" bundle:nil];
    leftMenuVC = [leftMenu instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    leftMenuVC.view.left = SCREEN_BOUNDS.size.width; //隐藏抽屉菜单
    
    __weak BaseViewController *baseVC = self;
    
//        leftMenuVC.selectButtonsBlock = ^(NSInteger index){
//            [mainTabbar selectMenuWithIndex:index];
//        };
    
    leftMenuVC.showMenuBlock = ^(){
        [baseVC showMenuAndBlur];
    };
    
    leftMenuVC.selectMenuBlock = ^(NSInteger index){
        dispatch_async(dispatch_get_main_queue(), ^{
//            [baseVC setupFunctionVCWithIndex:index];
        });
    };
    
    
    
    [imgV_blur addSubview:leftMenuVC.view];
}


//显示或隐藏菜单界面
- (void)showMenuAndBlur{
    
    [self.view bringSubviewToFront:imgV_blur];
    //隐藏状态进入
    if (leftMenuVC.view.left == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            
            imgV_blur.alpha = 0;
            view_shadow.alpha = 0;
            leftMenuVC.view.left = SCREEN_BOUNDS.size.width;
            
        }];
    }else{//显示状态进入
        imgV_blur.image = [self blurryImage:[self imageFromView:self.view] withBlurLevel:0.2];
        [UIView animateWithDuration:0.5 animations:^{
            
            leftMenuVC.view.left = 0;
            imgV_blur.alpha = 1;
            view_shadow.alpha = 0.4;
        }];
    }
}

#pragma mark - Blur
- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//调整模糊度函数
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果  后来添加
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    void *pixelBuffer3 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer3;
    outBuffer3.data = pixelBuffer3;
    outBuffer3.width = CGImageGetWidth(img);
    outBuffer3.height = CGImageGetHeight(img);
    outBuffer3.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &outBuffer3, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer3, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
