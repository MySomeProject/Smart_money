//
//  MacroDefinition.h
//  ZMSD
//
//  Created by zima on 14-10-24.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMTools.h"


#ifndef ZMSD_MacroDefinition_h
#define ZMSD_MacroDefinition_h

//Common Macro Definition ===============================================
#define CURRENT_SYSTEM_VERSION          [[[UIDevice currentDevice] systemVersion] floatValue]



//DANBAO，RONGZI，BAOLI，QICHE
//typedef enum ZMLoanType
//{
//    ZMLoanType_DANBAO = 0,    //担保贷 DANBAO
//    ZMLoanType_BAOLI =  1,    //消费贷 BAOLI
//    ZMLoanType_RONGZI = 2,    //紫贷宝 RONGZI（废弃）
//    ZMLoanType_QICHE =  3,    //汽车贷 QICHE
//
//    PEIZI, //"配资贷
//    
//    ZIDINGYING, //"紫定盈"（大类）
//    ZIDAIBAO,   //紫贷宝（大类）
//    RIZIBAO,    //日紫宝
//    YUEMANYING, //月满盈
//    JIJIFENG,   //季季丰
//    SHUANGJIXIN, //双季鑫
//    NIANNIANHONG,//年年红
//    
//    ALL, //所有产品
//}
//ZMLoanType;


typedef enum ZMLoanType
{
    ZMLoanType_RIZIBAO = 0,    //日紫宝
    
    ZMLoanType_ZIDINGYING = 10, //"紫定盈"（大类）
    ZMLoanType_YUEMANYING = 11, //月满盈
    ZMLoanType_JIJIFENG = 12,   //季季丰
    ZMLoanType_SHUANGJIXIN = 13, //双季鑫
    ZMLoanType_NIANNIANHONG = 14,//年年红
    
    ZMLoanType_ZIDAIBAO = 20,   //紫贷宝（大类）
    ZMLoanType_RONGZI = 21,    //紫贷宝 RONGZI（废弃）
    ZMLoanType_PEIZI = 22,     //"配资贷
    ZMLoanType_DANBAO = 23,    //担保贷 DANBAO
    ZMLoanType_BAOLI =  24,    //消费贷 BAOLI
    ZMLoanType_QICHE =  25,    //汽车贷 QICHE
    ZMLoanType_GONGYLJR =  26, //供应链金融 GONGYLJR
    ZMLoanType_YHPJ =  27,    //汽车贷 QICHE
    ZMLoanType_YSZK =  28, //供应链金融 GONGYLJR
    ALL = 30    //所有产品
}
ZMLoanType;

typedef enum ZMLoanState
{
    FULL_LOAN = 1,  //  满标
    LOAN_PROGRESS = 2 , //招标
    RECEIVING_PROGRESS  = 3 // 还款
    
}
ZMLoanState;




//雅痞 Yuppy SC.otf
//@"Yuppy SC"
//#define kTabBarTextFontName    @"Yuppy SC"
#define kTabBarTextFontName      @"Helvetica"



#define ____IOS8____      [[[UIDevice currentDevice] systemVersion]floatValue]>=7.8
#define ____IOS7____      ([[[UIDevice currentDevice] systemVersion]floatValue]>=7 && [[[UIDevice currentDevice] systemVersion]floatValue]<7.8)

//  宏定义一个alertView未来方便提醒用户
#define MyAlertView(msg) [[[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];

#define Color_For_NavigationBar_Purple     [UIColor colorWithRed:79.0/255 green:29.0/255 blue:90.0/255 alpha:0.1]

//#define Color_For_Main_Purple     [ZMTools ColorWith16Hexadecimal:@"72557a"]

//#define Color_For_Main_Purple     [UIColor colorWithRed:93.0/255 green:50.0/255 blue:102.0/255 alpha:1.0]


//#define Color_For_Main_Purple     [UIColor colorWithRed:108.0/255 green:89.0/255 blue:133.0/255 alpha:1.0]


//砖红色
#define Color_For_Main_Red         [UIColor colorWithRed:240.0/255 green:73.0/255 blue:132.0/255 alpha:1.0]
#define Color_For_InvestmentButton [UIColor colorWithRed:246.0/255 green:70.0/255 blue:132.0/255 alpha:1.0]


/**
 *  字体的颜色
 */

#define COLOR_BLACK_FOR_TEXT       [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]




//系统宽高
#define WIDTH_OF_SCREEN             [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_OF_SCREEN            [[UIScreen mainScreen] bounds].size.height
//宽度增长系数
#define Ratio_OF_WIDTH_FOR_IPHONE6   (WIDTH_OF_SCREEN/320.0)



//iphone5 iOS7.0        WIDTH_OF_SCREEN == 320.000000, HEIGHT_OF_SCREEN == 568.000000
//                      Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0

//iphone6 iOS8.0        WIDTH_OF_SCREEN == 375.000000, HEIGHT_OF_SCREEN == 667.000000
//                      Ratio_OF_WIDTH_FOR_IPHONE6 == 1.171875

//iphone6+ iOS8.0       WIDTH_OF_SCREEN == 414.000000, HEIGHT_OF_SCREEN == 736.000000
//                      Ratio_OF_WIDTH_FOR_IPHONE6 == 1.293750



//#if Ratio_OF_WIDTH_FOR_IPHONE6 >= 1.0
//
//#define Font_Size_For_Main_View 15.0
//
//#elif Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2
//
//#define Font_Size_For_Main_View 15.0
//
//#elif Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2
//
//#define Font_Size_For_Main_View 15.0
//
//#endif




#define HAS_NEW_MESSAGE_NOTIFICATION_NAME      @"HasNewMessageNotificationName"

#endif




#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
//#define CLog(format, ...)
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)





//首页波纹进度条的 start
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define iPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define  ViewHeight [[UIScreen mainScreen] bounds].size.height
#define  ViewWidth [[UIScreen mainScreen] bounds].size.width

#define iPhone5 ([[UIScreen mainScreen] bounds].size.height >=568)
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
//判断是否为iPhone5
#define IS_IPHONE_5_SCREEN [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f

//首页波纹进度条的 start


#endif