//
//  ZMPasswordViewController.m
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMPasswordViewController.h"
#import "AllStatusManager.h"
#import "ZMTools.h"
#import "HUD.h"

//#import "BaiduMobStat.h"  //百度统计

@interface ZMPasswordViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,MBProgressHUDDelegate>
{
    UITextField *passwordTextField;
    UITextField *confirmTextField;
    UIButton *nextStepButton;
}
@end

@implementation ZMPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"输入密码";
    
    
    //背景
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /*
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setFrame:CGRectMake(0, 4, 44, 44)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    
    //注册按钮
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerButton setFrame:CGRectMake(0, 4, 44, 44)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton addTarget:self action:@selector(regsterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:registerButton];
    */
    
    float Y_Offset_Subview_In_VC = 0.0;
    if (____IOS7____) {
        Y_Offset_Subview_In_VC = 0.0;
    }
    
    //输入框tableView背板（可上下弹动）
    UITableView *backgroundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y_Offset_Subview_In_VC+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-Y_Offset_Subview_In_VC-2)
                                                                    style:UITableViewStyleGrouped];
    [self.view addSubview:backgroundTableView];
    backgroundTableView.allowsSelection = YES;
    backgroundTableView.delegate = self;
    backgroundTableView.dataSource = self;
    
    
    //完成注册按钮
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextStepButton setFrame:CGRectMake(20/2.0, 150, [UIScreen mainScreen].bounds.size.width-20, 40)];
    [nextStepButton.layer setCornerRadius:3.0];
    [nextStepButton setBackgroundColor:Color_of_Purple];
    [nextStepButton setTitle:@"完成注册" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    nextStepButton.enabled = NO;
    
    [backgroundTableView addSubview:nextStepButton];
    [backgroundTableView setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  输入密码，进行注册
 *
 *  @param button <#button description#>
 */
- (void)nextStepAction:(UIButton *)button
{
#warning 判断密码是否相同
    if(![passwordTextField.text isEqualToString:confirmTextField.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"两次输入不一致, 请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertView.tag = 1000;
        [alertView show];
        
        return;
    }
 #warning 判断密码位数正确
    
    if (passwordTextField.text.length < 6) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"密码不能少于6位哦"];
        return;
    }
    else if (passwordTextField.text.length > 16)
    {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"密码不能超过16位哦"];
        return;
    }
    
    
    
    
    
    
    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ProgressHUD.delegate = self;
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    ProgressHUD.animationType = MBProgressHUDAnimationFade;
    
    
    if (self.isForgetPassword) {
        
        [ProgressHUD setLabelText:@"修改中..."];
        
        [[ZMServerAPIs shareZMServerAPIs] findPWDForResetPassword:passwordTextField.text phoneNumber:self.telephoneNumber autograph:nil Success:^(id response) {
            
            CLog(@"密码修改成功 %@", response);
            
            //保存用户名和密码（base64编码）
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] saveUserId:self.telephoneNumber password:passwordTextField.text];
            //设置为登录状态
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:YES];
            //
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateAdminUserInfoFromServer];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = 2001;
                [ProgressHUD setLabelText:@"修改成功"];
                [ProgressHUD hide:YES afterDelay:2.0];
            });
            
        } failure:^(id response) {
            
            CLog(@"修改失败 %@", response);
            
            //        重新输入密码
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = 2002;
                [ProgressHUD setLabelText:@"修改失败"];
                [ProgressHUD hide:YES afterDelay:2.0];
            });
        }];
    }
    else
    {
        [ProgressHUD setLabelText:@"注册中..."];
        

        [[ZMServerAPIs shareZMServerAPIs] registerPassword:passwordTextField.text phoneNumber:self.telephoneNumber Success:^(id response) {
            CLog(@"注册成功 %@", response);
            
            
            
            //保存用户名和密码（base64编码）
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] saveUserId:self.telephoneNumber password:passwordTextField.text];
            //设置为登录状态
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:YES];
            //
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateAdminUserInfoFromServer];
            
            //百度统计
//            [[BaiduMobStat defaultStat] logEvent:@"register" eventLabel:@"注册成功"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = 2001;
                [ProgressHUD setLabelText:@"注册成功"];
                [ProgressHUD hide:YES afterDelay:1.5];
            });
            
        } failure:^(id response) {
            CLog(@"注册失败 %@", response);
            
            //        重复注册
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = 2002;
                [ProgressHUD setLabelText:@"注册失败"];
                [ProgressHUD hide:YES afterDelay:1.5];
            });
        }];
    }
}

/**
 *  检查是否有输入
 *
 *  @param notification
 */
- (void)checkButtonStatus:(NSNotification *)notification
{
    if((UITextField *)notification.object == passwordTextField)
    {
        CLog(@"passwordTextField = %@", passwordTextField.text);
    }
    else if ((UITextField *)notification.object == confirmTextField)
    {
        CLog(@"confirmTextField = %@", confirmTextField.text);
    }
    
    if(![passwordTextField.text isEqualToString:@""] && ![confirmTextField.text isEqualToString:@""])
    {
        nextStepButton.enabled = YES;
        [nextStepButton setBackgroundColor:Color_of_Purple];
    }
    else{
        nextStepButton.enabled = NO;
        [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)registerInFinished:(UIButton *)button
{
    CLog(@"registerInFinished");
    [[AllStatusManager sharedStatusManager] setLoggedIn:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark ------------------------ MBProgressHUD delegate ------------------------
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    //密码修改成功／新用户注册成功
    if (hud.tag == 2001) {
        [hud removeFromSuperview];
        
        if(_isFromAppDelegate)  //从App delegate过来的   返回到登录界面
        {
            //返回到登录界面
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            //完全退出登录注册页面
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
        
        //返回到上一级
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //删除失败
    if (hud.tag == 2002 || hud.tag == 2003 || hud.tag == 2004)
    {
        [hud removeFromSuperview];
    }
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        passwordTextField.text = @"";
        confirmTextField.text = @"";
    }
}


#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"tableViewInLoginView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        //背板
        UIView *tempBackgroundView = [[UIView alloc] init];
        tempBackgroundView.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 44);
        
        
        //图标
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"password"]];
        
        //标题
        CGSize textSize = [ZMTools calculateTheLabelSizeWithText:@"登录密码" font:[UIFont boldSystemFontOfSize:16]];
        
        UILabel *leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, textSize.width, 44)];
        leftTitleLabel.userInteractionEnabled = NO;
        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [leftTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [leftTitleLabel setTextColor:[UIColor grayColor]];
        [leftTitleLabel setText:@"登录密码"];
        
        //输入框
        passwordTextField = [[UITextField alloc] init];
        passwordTextField.frame = CGRectMake(leftTitleLabel.frame.origin.x + leftTitleLabel.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER + leftTitleLabel.frame.size.width), 44);
        passwordTextField.textAlignment = NSTextAlignmentLeft;
        [passwordTextField setPlaceholder:@"6-16位英文字母数字或符号"];
        passwordTextField.adjustsFontSizeToFitWidth = YES;
        
        passwordTextField.secureTextEntry = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkButtonStatus:) name:UITextFieldTextDidChangeNotification object:passwordTextField];
        
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:passwordTextField];
        [cell.contentView addSubview:tempBackgroundView];
        
        
//        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
//        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
//        [textField setBackgroundColor:[UIColor grayColor]];
    }
    
    if (indexPath.row == 1) {
        //背板
        UIView *tempBackgroundView = [[UIView alloc] init];
        tempBackgroundView.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 44);
        
        
        //图标
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"password"]];
        
        //标题
        CGSize textSize = [ZMTools calculateTheLabelSizeWithText:@"登录密码" font:[UIFont boldSystemFontOfSize:16]];
        
        UILabel *leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, textSize.width, 44)];
        leftTitleLabel.userInteractionEnabled = NO;
        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [leftTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [leftTitleLabel setTextColor:[UIColor grayColor]];
        [leftTitleLabel setText:@"确认密码"];
        
        //输入框
        confirmTextField = [[UITextField alloc] init];
        confirmTextField.frame = CGRectMake(leftTitleLabel.frame.origin.x + leftTitleLabel.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER + leftTitleLabel.frame.size.width), 44);
        confirmTextField.textAlignment = NSTextAlignmentLeft;
        
        [confirmTextField setPlaceholder:@"6-16位英文字母数字或符号"];
        confirmTextField.adjustsFontSizeToFitWidth = YES;
        confirmTextField.secureTextEntry = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkButtonStatus:) name:UITextFieldTextDidChangeNotification object:confirmTextField];
        
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:confirmTextField];
        [cell.contentView addSubview:tempBackgroundView];
        
        
        //        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
        //        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
        //        [textField setBackgroundColor:[UIColor grayColor]];
    }
    
    return cell;
}

@end
