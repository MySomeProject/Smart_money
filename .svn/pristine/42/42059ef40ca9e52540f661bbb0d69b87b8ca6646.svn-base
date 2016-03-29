//
//  MacroDefine.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#ifndef ZiMaCaiHang_MacroDefine_h
#define ZiMaCaiHang_MacroDefine_h




/*
 
 if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
 {
 }
 else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
 {
 }
 else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
 {
 }
 
 */
//  tabber北京颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define Color_of_Tabbar  [UIColor colorWithRed:245/255 green:246/255 blue:247/255 alpha:1.0]
//----------- 颜色
#define Color_of_Purple  [UIColor colorWithRed:220.0/255 green:58.0/255 blue:46.0/255 alpha:1.0]
//砖红色
#define Color_of_Red     [UIColor colorWithRed:220.0/255 green:58.0/255 blue:46.0/255 alpha:1.0]



//#define Color_of_Red  [UIColor colorWithRed:254.0/255 green:72.0/255 blue:3.0/255 alpha:1.0]

//投资按钮
#define Color_For_InvestmentButton [UIColor colorWithRed:220.0/255 green:58.0/255 blue:46.0/255 alpha:1.0]
#define Color_of_GrayInvestButton  [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1.0]

//背景灰色
#define Color_of_Light_Gray        [UIColor colorWithRed:239.0/255 green:239.0/255 blue:243.0/255 alpha:1.0]

//最浅灰色
#define Color_For_Main_LightGray   [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]


//字体黑色
#define Color_of_Main_Purple       [ZMTools ColorWith16Hexadecimal:@"DC3A2E"]
#define Color_of_Text_Black        [ZMTools ColorWith16Hexadecimal:@"333333"]

//----------- 系统宽高
#define WIDTH_OF_SCREEN            [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_OF_SCREEN           [[UIScreen mainScreen] bounds].size.height


//----------- 宽度增长系数
#define Ratio_OF_WIDTH_FOR_IPHONE6   (WIDTH_OF_SCREEN/320.0)

//----------- 高度增长系数
#define Ratio_OF_HEIGHT_FOR_IPHONE   (HEIGHT_OF_SCREEN/480.0)

//高度增长系数
#define  HeightY             HEIGHT_OF_SCREEN/568
#define  WidthH              WIDTH_OF_SCREEN/320


//间隔线
#define SPACE5_WITH_BORDER    5
#define SPACE10_WITH_BORDER   10
#define SPACE15_WITH_BORDER   15
#define SPACE20_WITH_BORDER   20



#define ____IOS8____      [[[UIDevice currentDevice] systemVersion]floatValue]>=7.8
#define ____IOS7____      ([[[UIDevice currentDevice] systemVersion]floatValue]>=7 && [[[UIDevice currentDevice] systemVersion]floatValue]<7.8)


//通知名称
#define LOGIN_SUCCESS_NOTIFICATION_NAME              @"loginSuccess"
#define LOGIN_ON_OTHER_DEVICE_NOTIFICATION_NAME      @"loginOnOtherDevice"


//刷新用户信息(登录／用户再次启动)
#define UPDATE_BSAE_USER_INFO_SUCCESS_NOTIFICATION_NAME   @"updateBaseUserInfoSuccessNotificationName"
#define UPDATE_USER_ASSERT_SUCCESS_NOTIFICATION_NAME   @"updateUserAssertSuccessNotificationName"

#define RELOAD_SETTING_VIEW_NOTIFICATION_NAME        @"reloadSettingViewNotificationName"
#define HAS_NEW_MESSAGE_NOTIFICATION_NAME            @"HasNewMessageNotificationName"


//紫马财行App下载地址
#define APPSTORE_URL  [NSURL URLWithString:@"https://itunes.apple.com/us/app/zi-ma-dai/id949748182?l=zh&ls=1&mt=8"]
//版本检测地址
//#define APPVERSION_URL     [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=949748182"]

#endif
