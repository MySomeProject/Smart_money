//
//  AllStatusManager.h
//  ZMSD
//
//  Created by zima on 14-10-27.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllStatusManager : NSObject
+ (AllStatusManager*) sharedStatusManager;


/**
 *  引导界面是否已经显示完毕
 *
 *  @param isShowed YES为已经显示，NO为没有显示过的，
 */
- (void)setLeadingShowed:(BOOL)isShowed;
- (BOOL)getLeadingShowed;

- (void)setLoggedIn:(BOOL)isLogin;
- (BOOL)isLoggedIn;
- (void)setRegisteredIn:(BOOL)isLogin;
- (BOOL)isRegisteredIn;
@end
