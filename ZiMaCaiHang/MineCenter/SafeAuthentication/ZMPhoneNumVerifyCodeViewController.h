//
//  ZMPhoneNumVerifyCodeViewController.h
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void(^MobileAuthenticationBlock)(BOOL isAuthentication);
typedef void(^phoneNumChange)(NSString* phoneNum);

@interface ZMPhoneNumVerifyCodeViewController : BaseViewController
@property (nonatomic, strong) NSString *telephoneNumber;
@property (strong, nonatomic) UITableView * tableView;
@property(copy,nonatomic) MobileAuthenticationBlock mobileAuthenticationBlock;
@property(copy,nonatomic) phoneNumChange changePhoneNum;

@end
