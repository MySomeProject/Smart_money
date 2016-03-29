//
//  ZMNavigationController.m
//  WebView
//
//  Created by zima on 14-10-22.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMNavigationController.h"
#import "ClientHeaders.h"

@interface ZMNavigationController ()

@end

@implementation ZMNavigationController

//UIKIT_EXTERN NSString *const UITextAttributeFont NS_DEPRECATED_IOS(5_0, 7_0, "Use NSFontAttributeName");
//// Key to the text color in the text attributes dictionary. A UIColor instance is expected.
//UIKIT_EXTERN NSString *const UITextAttributeTextColor NS_DEPRECATED_IOS(5_0, 7_0, "Use NSForegroundColorAttributeName");
//// Key to the text shadow color in the text attributes dictionary.  A UIColor instance is expected.
//UIKIT_EXTERN NSString *const UITextAttributeTextShadowColor NS_DEPRECATED_IOS(5_0, 7_0, "Use NSShadowAttributeName with an NSShadow instance as the value");
//// Key to the offset used for the text shadow in the text attributes dictionary. An NSValue instance wrapping a UIOffset struct is expected.
//UIKIT_EXTERN NSString *const UITextAttributeTextShadowOffset NS_DEPRECATED_IOS(5_0, 7_0, "Use NSShadowAttributeName with an NSShadow instance as the value");

- (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLog(@"systemVersion = %f", [[[UIDevice currentDevice] systemVersion] floatValue]);
    
//    if (CURRENT_SYSTEM_VERSION >= 5.0)
//    {
//        UIImage *backgroundImage = [UIImage imageNamed:@"navbg.png"];
//        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//        self.navigationBar.tintColor = [UIColor redColor];
//    }
//    else
//    {
//        self.navigationBar.tintColor = [UIColor redColor];
//    }
    
    
    //Navigation bar background color／background image
    
    
    //方法一：
//    UIImage *backgroundImage = [UIImage imageNamed:@"navbg.png"];
//    backgroundImage = [self imageWithColor:[UIColor colorWithRed:65.0/255 green:57.0/255 blue:87.0/255 alpha:0.4]];
//    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];

    //背景
//    CGRect rect = self.navigationBar.bounds;
//    rect.origin.y = rect.origin.y-20;
//    rect.size.height = rect.size.height + 20;
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:rect];
//    imgV.image = [UIImage imageNamed:@"header_03.png"];
//    [self.navigationBar addSubview:imgV];
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"header_03.png"];
//    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//    
    
    //title
//    UIImage *img = [UIImage imageNamed:@"header01_03.png"];
//    UIImageView *img_title = [[UIImageView alloc] initWithImage:img];
//    img_title.frame = CGRectMake(0, 0, img.size.width, img.size.height);
//    img_title.center = self.center;
//    img_title.top += 8;
//    [self addSubview:img_title];
    
    
    
    //方法二：
    //导航栏背景颜色
    self.navigationBar.barTintColor = UIColorFromRGB(0xD73C35);
//    self.navigationBar.barTintColor = [UIColor colorWithRed:228/255.0f green:82/255.0f blue:67/255.0f alpha:1];
    //左右两侧按钮字体颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    //Navigation bar title font, font size, and title color
    
    NSDictionary * dict;
    
    UIColor * color = [UIColor whiteColor];
//    [UIFont fontWithName:kTabBarTextFontName size:18]
    if (CURRENT_SYSTEM_VERSION >= 7.0) {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:color, UITextAttributeTextColor, [UIFont boldSystemFontOfSize:18], UITextAttributeFont, nil];
    }
    
    self.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
