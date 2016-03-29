//
//  AModifyUserInfoViewController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModifyUserInfoViewController;

@interface AModifyUserInfoViewController : UIViewController

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VSpaceBGView;

@property (weak, nonatomic) ModifyUserInfoViewController *embedUserInfoListVC;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VSpaceBGView;

@end
