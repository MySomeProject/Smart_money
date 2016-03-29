//
//  ZMLogInLogOutViewController.h
//  ZiMaCaiHang
//
//  Created by 财行家 on 15/9/17.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZMLogInLogOutViewControllerDelegate <NSObject>
-(void)finishedLoginOrRegister:(id)sender;
@end

@interface ZMLogInLogOutViewController : UIViewController
{
    NSString *_userIdentity;
    NSString *_password;
}
@property (assign, nonatomic) BOOL isFromAppDelegate;   //只有从AppDelegate打开才为 YES
@property (assign, nonatomic) id<ZMLogInLogOutViewControllerDelegate>   delegate;
@property (assign, nonatomic)BOOL isCustomTabbarAcount;
@property (assign , nonatomic)BOOL isCustomTabbarMore;

/**
 *  user login
 *
 *  @param button Action sender
 */
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *titleOneView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *upView;
@property (weak, nonatomic) IBOutlet UIImageView *upLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *downLeftView;

@property (weak, nonatomic) IBOutlet UITextField *upTextField;

@property (weak, nonatomic) IBOutlet UITextField *downloadTextField;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@property (weak, nonatomic) IBOutlet UIButton *forgetButton;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *titleDownView;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;


@end
