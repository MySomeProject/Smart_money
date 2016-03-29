//
//  GTCommontHeader.h
//  iphone6 Fix Demo
//
//  Created by GuanTian Li on 14-11-5.
//  Copyright (c) 2014年 GCI. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef iphone6_Fix_Demo_GTCommontHeader_h
#define iphone6_Fix_Demo_GTCommontHeader_h
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
//#define     ([UIScreen mainScreen].bounds.size.height)
CG_INLINE CGFloat GTFixHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*mainFrme.size.height/1096*2;
    return height;
   
}

CG_INLINE CGFloat GTReHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*1096/(mainFrme.size.height*2);
    return height;
}

CG_INLINE CGFloat GTFixWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*mainFrme.size.width/640*2;
    return width;
}

CG_INLINE CGFloat GTReWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*640/mainFrme.size.width/2;
    return width;
}

// 经过测试了, 以iphone5屏幕为适配基础
CG_INLINE CGRect
GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y;
    rect.size.width = GTFixWidthFlaot(width); rect.size.height = GTFixWidthFlaot(height);
    return rect;
}
CG_INLINE float
GetHeight(CGRect frame){
    return frame.size.height;
}
CG_INLINE float
GetWidth(CGRect frame){
    return frame.size.width;
}CG_INLINE float
GetOriginX(CGRect frame){
    return frame.origin.x;
}CG_INLINE float
GetOriginY(CGRect frame){
    return frame.origin.y;
}
CG_INLINE CGRect
GetFramByXib (CGRect frame){
    return CGRectMake(GTFixWidthFlaot(GetOriginX(frame)), GTFixHeightFlaot(GetOriginY(frame)), GTFixWidthFlaot(GetWidth(frame)), GTFixHeightFlaot(GetHeight(frame)));
}
#endif
