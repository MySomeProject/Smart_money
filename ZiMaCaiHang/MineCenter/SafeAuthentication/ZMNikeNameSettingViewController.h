//
//  ZMNikeNameSettingViewController.h
//  ZMSD
//
//  Created by zima on 14-12-24.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>
//删除成功的回调
typedef void(^NikeNameAuthenticationBlock)(BOOL isAuthentication);

@interface ZMNikeNameSettingViewController : UIViewController
//@interface ZMNikeNameSettingViewController : UITableViewController

@property (strong, nonatomic) UITableView * tableView;

@property(copy,nonatomic) NikeNameAuthenticationBlock nikeNameAuthenticationBlock;
@end
