//
//  AllStatusManager.m
//  ZMSD
//
//  Created by zima on 14-10-27.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "AllStatusManager.h"

static AllStatusManager *sharedObj = nil; //第一步：静态实例，并初始化。

@implementation AllStatusManager

+ (AllStatusManager*) sharedStatusManager  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (id)init
{
    @synchronized(self) {
        self = [super init];//往往放一些要初始化的变量.
        return self;
    }
}



- (void)setLeadingShowed:(BOOL)isShowed
{
    [[NSUserDefaults standardUserDefaults] setBool:isShowed forKey:@"isLeadingViewShowed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)getLeadingShowed
{
    CLog(@"getLeadingShowed ==== %@", [[NSUserDefaults standardUserDefaults] boolForKey:@"isLeadingViewShowed"] ? @"已经显示过了" : @"还没有显示过");
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLeadingViewShowed"];
}

- (void)setLoggedIn:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isLoggedIn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"];
}
- (void)setRegisteredIn:(BOOL)isRegistered
{
    [[NSUserDefaults standardUserDefaults] setBool:isRegistered forKey:@"isRegistered"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isRegisteredIn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isRegistered"];
}


@end
