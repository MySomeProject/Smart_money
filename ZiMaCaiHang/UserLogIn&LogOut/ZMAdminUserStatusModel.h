//
//  ZMAdminUserStatusModel.h
//  ZMSD
//  检测当前客户端是否已经登录
//  Created by zima on 14-12-16.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户资金数据
#import "ZMAdminUserBaseInfo.h"
#import "ZMAdminUserAssert.h"
#import "ZMAdminUserAccountInfo.h"


typedef void(^UserUpdatedBaseInfo)(id userInfo);


@interface ZMAdminUserStatusModel : NSObject

@property(nonatomic,copy) UserUpdatedBaseInfo userUpdatedBaseInfo;



//新接口数据
@property (nonatomic, copy)   NSString * loginKey; //登录成功的字段

@property (nonatomic, copy) ZMAdminUserBaseInfo *adminuserBaseInfo;
@property (nonatomic, copy) ZMAdminUserAssert *adminUserAssert;
@property (nonatomic, copy) ZMAdminUserAccountInfo *adminUserAccountInfo;

@property (nonatomic, assign) BOOL     idCardValidated;     //身份认证
@property (nonatomic, assign) BOOL     mobileValidated;     //手机号码认证
@property (nonatomic, assign) BOOL     emailValidated;      //邮箱认证
@property (nonatomic, assign) BOOL     isFirstInAmount;      //首次充值







@property (nonatomic, assign) long     userId;      //NA
@property (nonatomic, copy)   NSString * nickName;   //NA改成实名
@property (nonatomic, copy)   NSString * headImage;  //NA


@property (nonatomic, assign) BOOL     allowBorrow;  //NA
@property (nonatomic, assign) BOOL     userInfoFinished;   //NA



@property (nonatomic, assign) BOOL     allowLend;    //NA
@property (nonatomic, assign) BOOL     enable;       //NA


@property (nonatomic, assign) double   receivingPrincipal;  //代收本金
@property (nonatomic, assign) double   frozenPoints;
@property (nonatomic, assign) double   availablePoints;
@property (nonatomic, assign) double   receivedPoints;
@property (nonatomic, assign) double   receivingPoints;
@property (nonatomic, assign) double   totalPoints;

@property (nonatomic, assign) double   totalScores;


#pragma mark   ----------- 是否有新的消息 ------------
@property (nonatomic, assign) BOOL     hasNewMessage;   //获取到未读站内信

@property (nonatomic, assign) BOOL     hasMessageRead;  //获取到已读站内信

@property (nonatomic, assign) int      newMessageNumber;

@property (nonatomic, assign) NSInteger       currentPage;
@property (nonatomic, copy)   NSMutableArray *allLoadedMsgArray;


#pragma mark   ----------- 手势密码 ------------
@property (nonatomic, assign) BOOL     isPatternLock;   //是否设置手势密码

- (BOOL)getIfIsPatternLocked;


//(id integer primary key, nickName TEXT, allowBorrow INTEGER, userInfoFinished INTEGER, mobileValidated INTEGER, allowLend INTEGER, enable INTEGER, idCardValidated INTEGER,  receivingPrincipal REAL, frozenPoints REAL,  totalScores REAL, availablePoints REAL, receivedPoints REAL, receivingPoints REAL, totalPoints REAL)




//{"message":"登录成功",
//    "data":{
//        "result":2000,               登录返回结果代码2000表示成功

//        "allowBorrow":"false",       是否允许borrow
//        "userInfoFinished":"false",  用户信息是否完全
//        "mobileValidated":"true",    手机是否验证
//        "receivingPrincipal":0.0,    待收本金
//        "allowLend":"false",       用户是否允许lend
//        "enable":"true",           用户是否可用
//        "frozenPoints":"800.0",    冻结金额
//        "totalScores":12000,    累计总获取的积分
//        "id":"6",               用户id ?
//        "nickName":"奥巴马",     如果为空，表示没有认证，不为空表示已经认证
//        "availablePoints":"7054.0",    可用余额
//        "idCardValidated":"false",     实名认证
//        "receivedPoints":0.0,   已收收益
//        "receivingPoints":0.0,  待收收益
//        "totalPoints":"7854.0"  用户总金额=可用余额+冻结金额
//    },
//    "code":1000}


//已经使用的积分 －－－ 缺失
/*
 接收到的数据：{
 code = 1000;
 data =     {
     allowBorrow = false;
     allowLend = true;
     availablePoints = "0.0";
     enable = true;
     frozenPoints = "10000.0";
     id = 76;
     idCardValidated = true;
     mobileValidated = true;
     nickName = "frayya'";
     receivedPoints = 0;
     receivingPoints = 0;
     receivingPrincipal = 0;
     result = 2000;
     totalPoints = "10000.0";
     totalScores = 0;
     userInfoFinished = true;
 };
 message = "\U767b\U5f55\U6210\U529f";
 }
 */

+(ZMAdminUserStatusModel*)shareAdminUserStatusModel;


+(BOOL)isNullObject:(id)object;

/**
 *  刷新用户信息
 */
-(void)updateAdminUserInfoFromServer;



//保存和获取用户的loginKey
-(void)saveLoginKey:(NSString *)loginKey;
-(NSString *)getLoginKey;




/**
 *  保存用户名和登录密码
 *
 *
 *  @return
 */
-(void)saveUserId:(NSString *)userId password:(NSString *)password;

/**
 *  读取用户名和登录密码
 *
 *  @return uid, password
 */
-(NSDictionary *)getLocalUserIdAndPassword;

/**
 *  退出，或注销后，清除本地用户数据
 *
 *  @return YES清除成功， NO清除失败
 */
-(BOOL)deleteLocalUserInfo;


/**
 *  是否已经登录
 *
 *  @return YES表示已经登录、NO未登录
 */
-(BOOL)isLoggedIn;





//用户基本信息
-(BOOL)updateUserBaseInfoSuccess:(void(^)(id response))success failure:(void(^)(id response))failure;
-(BOOL)updateUserBaseInfo;

//用户资产信息
-(BOOL)updateUserAssert;

//用户账户信息
-(BOOL)updateUserAccount;


/**
 *  获取用户最新的数据
 *
 *  @param userInfo 用户最新数据
 *
 *  @return 是否更新正确
 */
- (BOOL)updateTheNewestUserInfo:(NSDictionary *)userInfo;


/**
 *  设置登录或者注销（未登录）状态
 *
 *  @param islogged Bool变量。YES设置为已登录、NO设置为未登录
 */
-(void)setLoggedStatus:(BOOL)islogged;


/**
 *  弹出 alter 提醒框
 *
 *  @param vc
 */
-(void)popLoginVCWithCurrentViewController:(UIViewController*)vc;

//直接弹注册
-(void)popRegisterVCWithCurrentViewController:(UIViewController*)vc;

#pragma mark ----------------- 站内消息 -------------------------------

/**
 *  将新的page的数据组合到总的数组中
 *
 *  @param newPageProducts 获取的新的page的数据
 *  @param pullUpward      YES上拉，NO下拉
 */
-(void)packagingAllLoadedProductArray:(NSMutableArray *) newPageProducts withPullPosition:(BOOL)pullUpward;
/**
 *  下拉刷新
 */
-(void)requestNewMessages;

@end
