//
//  ZMPhoneNumVerifyTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/5/14.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMPhoneNumVerifyCodeViewController.h"

@interface ZMPhoneNumVerifyTableViewCell : UITableViewCell<MBProgressHUDDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextSetupButton;
@property (nonatomic) UIButton *getIdentifyButton;
@property (nonatomic) ZMPhoneNumVerifyCodeViewController *parentController;
- (IBAction)bindMobileClicked:(id)sender;
- (void)getIdentifyCodeClicked:(id)sender;
@property (nonatomic) NSTimer *countdownTimer;
@end
