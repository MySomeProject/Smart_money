//
//  DES3Util.h
//  AoMeiProject
//
//  Created by 张圆圆 on 15/7/7.
//  Copyright (c) 2015年 张圆圆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
