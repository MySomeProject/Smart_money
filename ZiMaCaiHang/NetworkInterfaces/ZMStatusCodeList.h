//
//  ZMStatusCodeList.h
//  ZMSD
//
//  Created by zima on 14-12-19.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#ifndef ZMSD_ZMStatusCodeList_h
#define ZMSD_ZMStatusCodeList_h

enum {
    StatusCodeAPIConnectionOK  =  1000,   //网络链接正常
    StatusCodeAPIException     =  1001,   //异常
    
    StatusCodeLoginSuccess     =    2000,      //用户登录成功
    StatusCodeUserIsNotExist   =   2002,   //用户不存在
//    2001,//数据已经存在
};
typedef NSUInteger StatusCodeType;
#endif

//投资返回状态码
//2012   参数错误
//1001   系统错误 (code)
//2000   用户信息验证成功

//2007   账户昵称%s，账户不可用
//2008   账户昵称%s，身份信息未通过验证
//2009   账户昵称%s，手机信息未通过验证
//2010   账户昵称%s，账户信息不完整
//2006   账户昵称%s，不允许投资
//2013   项目不存在s

//2016   起投金额最少100元
//2017   金额必须为100的整数倍
//2018   账户余额不足
//2019   投资金额超过剩余可投金额
//2002   异常日志value/运行时异常/其他异常
