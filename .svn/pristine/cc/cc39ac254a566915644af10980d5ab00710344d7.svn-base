//
//  ZMPhoneNumberTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/5/14.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InviteFriendsBlock)();
@interface ZMEmailTableViewCell : UITableViewCell<MBProgressHUDDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextSetupButton;
@property (strong,nonatomic) InviteFriendsBlock nextSetupBlock;
- (IBAction)nextSetupButtonClicked:(id)sender;
- (void)getIdentifyCodeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyCodeTextField;
@property (nonatomic) UIButton *getIdentifyButton;
@property (nonatomic) NSTimer *countdownTimer;
@end
