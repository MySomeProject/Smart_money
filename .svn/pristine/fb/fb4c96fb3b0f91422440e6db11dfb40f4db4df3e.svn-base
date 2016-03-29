//
//  ZMTools.h
//  ZMSD
//
//  Created by zima on 14-11-14.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>

@interface ZMTools : NSObject

+ (NSString *)replaceContentHTMLFlag:(NSString *)content;

+ (NSString *)bankIdFromCardType:(NSString *)bankType;

+ (NSString *)monthValueFromMonthType:(NSString *)monthType;




//网络获取的对象是否是空
+(BOOL)isNullObject:(id)object;

//实名*星号隐藏
+ (NSString *)hideRealName:(NSString *)realName;
//字符*星号隐藏
+ (NSString *)hideString:(NSString *)string;
//银行卡号*星号隐藏
+ (NSString *)hideBankCardNumber:(NSString *)bankCardNum;

//是否是纯数字（电话号码）
+ (BOOL)isPureIntNumber:(NSString*)string;
//是否是邮箱
+ (BOOL)isValidateEmail:(NSString *)Email;


//倒计时时间
+ (NSString *)theCountdownTime:(long)timeInterval;
//0天00时00分00秒
+ (NSString *)theUnitCountdownTime:(long)timeInterval;


//根据字体计算字符串所占的宽高
+(CGSize)calculateTheLabelSizeWithText:(NSString *)text font:(UIFont *)font;

//转换时间成为“多少时间前”
+(NSString *)transformCurrentTime:(NSDate*)compareDate;
+(NSString *)transformCurrentDateString:(NSString*)compareDateString;

//返回自定义字符串时间
+(NSString *)transformToCustomStringWithDate:(NSDate*) compareDate;
+(NSDate *)transformToDateWithDateString:(NSString*)dateString;

//yyyy-MM-dd HH:mm:ss -> yyyy-MM-dd
+(NSString *)formattingDateString:(NSString*)fromServerDateString;

+(UIBarButtonItem *)item:(NSString *)imageName target:(id)taget select:(SEL)action;



+(UIColor *)ColorWith16Hexadecimal:(NSString*)hexColor;

//将万以上的数据变成万为单位的数据（万以上的数字, 不带万单位）
+ (NSString *) moneyTenThousandUnitsValue:(double)digitalData;

//将万以上的数据变成万为单位的数据
+ (NSString *) moneyStandardMillionUnits:(double)digitalData;

//货币标准格式转换工具
+ (NSString *) moneyStandardFormatByData:(double)digitalData;
+ (NSString *) moneyStandardFormatByString:(NSString *)digitalString;
+ (NSString *) moneyStandardFormatByString:(NSString *)digitalString withDollarSign:(NSString *)sign;

//座机
+(BOOL)isHomeNumber:(NSString *)number;
//手机
+(BOOL)isPhoneNumber:(NSString *)number;

//身份证
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

//银行卡正则表达式
+ (BOOL)validateBankCardNumber: (NSString *)bankCardNumber;

//信用卡
+(BOOL)validateCreditCardNumber:(NSString *)cardNo;

@end
