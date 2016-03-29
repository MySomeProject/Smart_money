//
//  ZMTabBarRootsController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-3.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ZMTabBarRootsController.h"
#import <Accelerate/Accelerate.h>
#import "LeftMenuViewController.h"


#import "ZMNavigationController.h"


#import "HomePageViewController.h"
#import "FinancingViewController.h"

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

@interface ZMTabBarRootsController ()
{
    UIImageView *imgV_blur;
    UIView *view_shadow;
    
    NSArray * subRootControllers;
    
    LeftMenuViewController *leftMenuVC;
}
@end

@implementation ZMTabBarRootsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //菜单
    [self setupFunctionMenu];
    
    //各个视图控制器
    [self initialTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialTabbar
{
    UIStoryboard * homePage = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    HomePageViewController *vc0 = [homePage instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    
    UIStoryboard * financing = [UIStoryboard storyboardWithName:@"Financing" bundle:nil];
    FinancingViewController *vc1 = [financing instantiateViewControllerWithIdentifier:@"FinancingViewController"];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    [vc2.view setBackgroundColor:[UIColor greenColor]];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    [vc3.view setBackgroundColor:[UIColor blueColor]];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    [vc4.view setBackgroundColor:[UIColor blueColor]];
    
    UIViewController *vc5 = [[UIViewController alloc]init];
    [vc5.view setBackgroundColor:[UIColor blueColor]];
    
    
    ZMNavigationController *nav0 = [[ZMNavigationController alloc] initWithRootViewController:vc0];
    ZMNavigationController *nav1 = [[ZMNavigationController alloc] initWithRootViewController:vc1];
    ZMNavigationController *nav2 = [[ZMNavigationController alloc] initWithRootViewController:vc2];
    ZMNavigationController *nav3 = [[ZMNavigationController alloc] initWithRootViewController:vc3];
    ZMNavigationController *nav4 = [[ZMNavigationController alloc] initWithRootViewController:vc4];
    ZMNavigationController *nav5 = [[ZMNavigationController alloc] initWithRootViewController:vc5];
    
    
    subRootControllers = @[nav0, nav1, nav2, nav3, nav4, nav5];
    
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
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    self.viewControllers = subRootControllers;
    self.selectedViewController = subRootControllers[0];
}

/*
- (void) hideTabBar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, iphone5?568:480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, iphone5?568-49:480-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, iphone5?568:480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,  iphone5?568-49:480-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}
 */


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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



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
    
    __weak ZMTabBarRootsController *baseVC = self;
    
    leftMenuVC.showMenuBlock = ^(){
        [baseVC showMenuAndBlur];
    };
    
    leftMenuVC.selectMenuBlock = ^(NSInteger index){
        dispatch_async(dispatch_get_main_queue(), ^{
            [baseVC setupFunctionVCWithIndex:index];
        });
    };
    
    
    
    [imgV_blur addSubview:leftMenuVC.view];
}


//菜单选择
- (void)setupFunctionVCWithIndex:(NSInteger)index
{
    NSLog(@"index === %ld", index);
    [self showMenuAndBlur];
    self.tabBar.tintColor = [UIColor colorWithRed:252.0/255 green:73.0/255 blue:31.0/255 alpha:1];
    
    switch (index) {
        case 0:
            //首页
            self.selectedViewController = subRootControllers[0];
//            self.selectedIndex = index;
            break;
            
        case 1:
            //首页
            self.selectedViewController = subRootControllers[1];
//            self.selectedIndex = index;
            break;
        case 2:
            //首页
            self.selectedViewController = subRootControllers[2];
//            self.selectedIndex = index;
            break;
        case 3:
            //首页
            self.selectedViewController = subRootControllers[3];
//            self.selectedIndex = index;
            break;
        case 4:
            //首页
            self.selectedViewController = subRootControllers[4];
//            self.selectedIndex = index;
            break;
        case 5:
            //首页
            self.selectedViewController = subRootControllers[5];
//            self.selectedIndex = index;
            break;
        default:
            break;
    }
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
