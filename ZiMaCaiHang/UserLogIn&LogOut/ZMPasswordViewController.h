//
//  ZMPasswordViewController.h
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPasswordViewController : UIViewController
@property (nonatomic, assign) BOOL isForgetPassword;
@property (nonatomic, strong) NSString *telephoneNumber;

@property (assign, nonatomic) BOOL isFromAppDelegate;   //只有从AppDelegate打开才为 YES

@end
