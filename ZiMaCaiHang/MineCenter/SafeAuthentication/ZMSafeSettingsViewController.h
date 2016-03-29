//
//  ZMSafeSettingsViewController.h
//  ZMSD
//
//  Created by zima on 14-12-18.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ZMSafeSettingsViewController : UIViewController
@interface ZMSafeSettingsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *administratorUserInfo;

@end
