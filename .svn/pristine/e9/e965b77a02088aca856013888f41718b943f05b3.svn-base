//
//  ZMPhoneSettingViewController.h
//  ZMSD
//
//  Created by zima on 14-12-24.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMPhoneNumVerifyCodeViewController.h"
#import "BaseViewController.h"
typedef void(^MobileAuthenticationBlock)(BOOL isAuthentication);

@interface ZMPhoneNumberSettingViewController : BaseViewController //UITableViewController
@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic) ZMPhoneNumVerifyCodeViewController *phoneNumVCController;
@property(copy,nonatomic) MobileAuthenticationBlock mobileAuthenticationBlock;

-(void)mobileBlock:(MobileAuthenticationBlock)block;
@end
