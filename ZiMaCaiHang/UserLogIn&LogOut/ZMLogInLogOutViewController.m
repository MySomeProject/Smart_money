//
//  ZMLogInLogOutViewController.m
//  ZMSD
//
//  Created by zima on 14-10-28.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMLogInLogOutViewController.h"
#import "ZMLogInViewController.h"
#import "ZMRegisterInViewController.h"
#import "UIViewExt.h"
#import "FinancingTableViewController.h"

//#import "ZXHLoginTextField.h"

#import "ZMForgetPWDViewController.h"

#import "ZMTools.h"
#import "HUD.h"
#import "AppDelegate.h"
#import "PMCustomKeyboard.h"
//#import "BaiduMobStat.h"  //百度统计
#import "GTCommontHeader.h"
#import "CustomTabbarController.h"
#import "MineCenterViewController.h"

#define ALERTVIEW_TAG_LOGIN_Incomplete                       1001    //信息不完整
#define ALERTVIEW_TAG_LOGIN_UserIsNotExist_Failed            1002    //登录-用户不存在
#define ALERTVIEW_TAG_LOGIN_WrongUID_PWD_Failed              1003    //登录-用户名或密码错误
#define ALERTVIEW_TAG_LOGIN_User_Disable_Failed              1004    //登录-用户名或密码错误

#define ProgressHUD_TAG_FOR_SUCCESS        2000
#define ProgressHUD_TAG_FOR_FAILED         2001
#define ProgressHUD_TAG_FOR_NOT_USER       2002



@interface ZMLogInLogOutViewController ()<ZMLogInViewControllerDelegate, UIScrollViewDelegate,UITextFieldDelegate, UIAlertViewDelegate, MBProgressHUDDelegate>
{
//    UITableView *backgroundTableView;
//    
//    ZXHLoginTextField *userIdInput;
//    ZXHLoginTextField *passwordInput;
    AppDelegate *appdelegate;
    PMCustomKeyboard *customKeyBoard;
}
@end

@implementation ZMLogInLogOutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    customKeyBoard = [[PMCustomKeyboard alloc] init];
//    //    [customKeyboard setTextView:self.textView];
//    //    numberPadView.textField = ;
    
    self.title = @"用户登录";
    [self setUpNewLoginStyle];
    
    for (UIView* view in self.view.subviews){
        view.frame = GetFramByXib(view.frame);
        for (UIView* childview in view.subviews){
            childview.frame = GetFramByXib(childview.frame);
            
        }
    }
    _titleOneView.frame = CGRectMake(0, 0, WIDTH_OF_SCREEN, 64);
    _cancelButton.frame = CGRectMake(WIDTH_OF_SCREEN/320*10, 30, WIDTH_OF_SCREEN/320*46, 30);
    _titleLabel.frame = CGRectMake(WIDTH_OF_SCREEN/320*120, 30, WIDTH_OF_SCREEN/320*80, 30);
    
    if (WIDTH_OF_SCREEN == 320 && HEIGHT_OF_SCREEN == 480) {
        _backgroundView.frame = CGRectMake(0, 0, 320, 480);
        _titleView.frame = CGRectMake(100,139*HeightY ,126 , 60*HeightY);
        _upView.frame = CGRectMake(44, 253*HeightY, 230, 40*HeightY);
        _upLeftView.frame = CGRectMake(61, 262*HeightY, 12, 22*HeightY);
        _upTextField.frame = CGRectMake(84, 253*HeightY, 190, 40*HeightY);
        _downView.frame = CGRectMake(44, 303*HeightY, 230, 40*HeightY);
        _downLeftView.frame = CGRectMake(57, 312*HeightY, 18, 22*HeightY);
        _downloadTextField.frame = CGRectMake(84, 303*HeightY, 190, 40*HeightY);
        _LoginButton.frame = CGRectMake(67, 357*HeightY, 185, 40*HeightY);
        _forgetButton.frame = CGRectMake(120, 403*HeightY, 80, 30*HeightY);
        _registerButton.frame = CGRectMake(67, 436*HeightY, 185, 40*HeightY);
        _lineView.frame = CGRectMake(34, 513*HeightY, 251, 1*HeightY);
        _titleDownView.frame = CGRectMake(120, 534*HeightY, 80, 11*HeightY);
    }
    
}


//第三版
-(void)setUpNewLoginStyle
{
    if (!self.isFromAppDelegate) {
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        /*
         //返回按钮
         UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [cancelButton setFrame:CGRectMake(0, 4, 30, 20)];
         UIButton *cancelButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
         [cancelButton1 setFrame:CGRectMake(30, 4, 30, 20)];
         //        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
         /*
         [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
         
         [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
         [cancelButton setBackgroundColor:[UIColor clearColor]];*/
        //        [cancelButton setBackgroundImage:[UIImage imageNamed:@"denglu"] forState:UIControlStateNormal];
        //        [cancelButton1 setBackgroundImage:[UIImage imageNamed:@"denglu2"] forState:UIControlStateNormal];
        //        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //        [cancelButton1 addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    }else{
        self.cancelButton.hidden = YES;
    }
    

/*


    //输入框tableView背板（可上下弹动）
    //    UITableView *
    backgroundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-2)
                                                       style:UITableViewStylePlain];
    CLog(@"height = %f", [UIScreen mainScreen].bounds.size.height);
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired =1;
    [backgroundTableView addGestureRecognizer:tap1];
    [self.view addSubview:backgroundTableView];
    [backgroundTableView setBackgroundColor:[UIColor clearColor]];
    
    backgroundTableView.allowsSelection = YES;
    backgroundTableView.delegate = self;
    //    backgroundTableView.dataSource = self;
    
    //去掉空白的行
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [backgroundTableView setTableFooterView:view];
 
 
    
    //输入框和登录按钮，忘记密码按钮摆放区域
    UIView *middleContainerView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                          50,
                                                                          WIDTH_OF_SCREEN,
                                                                          240)];
    [middleContainerView setBackgroundColor:[UIColor clearColor]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired =1;
    [middleContainerView addGestureRecognizer:tap];
    [backgroundTableView addSubview:middleContainerView];
    
 
*/
    //账号和密码输入框
    
//    userIdInput = [[ZXHLoginTextField alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 44)
//                                               withTarget:self
//                                                    image:[UIImage imageNamed:@"userHeader"]
//                                              placeholder:@"手机号码"];
//    
//    UITextField *userIdTextField = (UITextField *)[userIdInput viewWithTag:100];
//    //    numberPadView.textField = userIdTextField;
//    //    userIdTextField
//    userIdTextField.keyboardType = UIKeyboardTypePhonePad;
//    [middleContainerView addSubview:userIdInput];
//    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(userIdInput.left + 5, userIdInput.bottom, userIdInput.width - 10, 1)];
//    [lineView1 setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1]];
//    [middleContainerView addSubview:lineView1];
//    
//    passwordInput = [[ZXHLoginTextField alloc]initWithFrame:CGRectMake(10.0, userIdInput.bottom + 20, [UIScreen mainScreen].bounds.size.width-20, 44)
//                                                 withTarget:self
//                                                      image:[UIImage imageNamed:@"password"]
//                                                placeholder:@"密码"];
    
    if (self.navigationController.viewControllers.count > 1) {
        [_cancelButton setTitle:@"返回" forState:UIControlStateNormal];
    } else {
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    
    [_upTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _upTextField.delegate = self;
    UITextField *textField = (UITextField *)[self.view viewWithTag:100];
        textField.delegate = self;
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [customKeyBoard setTextView:textField];
    
    //GO键登陆
    [customKeyBoard.returnButton addTarget:self action:@selector(LogIn:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    
//        [middleContainerView addSubview:passwordInput];
//    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(passwordInput.left + 5, passwordInput.bottom, passwordInput.width - 10, 1)];
//    [lineView2 setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1]];
//    [middleContainerView addSubview:lineView2];
//    
    
    
    //    [userIdInput setBackgroundColor:[UIColor greenColor]];
    //    [passwordInput setBackgroundColor:[UIColor greenColor]];
    
    
    //登录事件按钮
//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [loginButton setFrame:CGRectMake(10.0, 180, [UIScreen mainScreen].bounds.size.width-20, 44)];
//    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
//    
//    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    
//    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [_LoginButton addTarget:self action:@selector(LogIn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    loginButton.layer.cornerRadius = 3.0;
//    [loginButton setBackgroundColor:Color_For_InvestmentButton];
//    
//    [middleContainerView addSubview:loginButton];
//    
    
    
    //忘记密码：
//    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [forgetPasswordButton setFrame:CGRectMake(WIDTH_OF_SCREEN - 92,
//                                              loginButton.top - 44 - 15,
//                                              88,
//                                              44 * Ratio_OF_WIDTH_FOR_IPHONE6)];
//    [forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [forgetPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [forgetPasswordButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [forgetPasswordButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [_forgetButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
//    [forgetPasswordButton setBackgroundColor:[UIColor clearColor]];
//    [middleContainerView addSubview:forgetPasswordButton];
    [_registerButton addTarget:self action:@selector(regsterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
#if 0
    
    注册按钮
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [registerButton setFrame:CGRectMake((WIDTH_OF_SCREEN - 120)/2.0, middleContainerView.bottom + 42, 120, 42)];
        [registerButton setBackgroundImage:[UIImage imageNamed:@"registerButton.png"] forState:UIControlStateNormal];
        [registerButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
        [registerButton addTarget:self action:@selector(regsterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [registerButton setBackgroundColor:[UIColor clearColor]];
    
        [backgroundTableView addSubview:registerButton];
    
    UIButton *backToLoginLeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backToLoginLeftButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    UIButton *backToLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backToLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    CGSize buttonSize = [ZMTools calculateTheLabelSizeWithText:@"还没有账号？" font:backToLoginLeftButton.titleLabel.font];
    CGSize buttonSize2 = [ZMTools calculateTheLabelSizeWithText:@"立即注册" font:backToLoginButton.titleLabel.font];
    float x_offset = (WIDTH_OF_SCREEN - buttonSize.width - buttonSize2.width)/2;
    [backToLoginLeftButton setFrame:CGRectMake(x_offset,
                                               middleContainerView.bottom + 22,
                                               buttonSize.width,
                                               40 * Ratio_OF_WIDTH_FOR_IPHONE6)];
    
    [backToLoginLeftButton setTitle:@"还没有账号？" forState:UIControlStateNormal];
    [backToLoginLeftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backToLoginLeftButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [backToLoginLeftButton addTarget:self action:@selector(regsterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backToLoginButton setFrame:CGRectMake(backToLoginLeftButton.right,
                                           middleContainerView.bottom + 22,
                                           buttonSize2.width,
                                           40 * Ratio_OF_WIDTH_FOR_IPHONE6)];
    [backToLoginButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [backToLoginButton setTitleColor:Color_of_Red forState:UIControlStateNormal];
    [backToLoginButton setTitleColor:Color_of_Red forState:UIControlStateHighlighted];
    [backToLoginButton addTarget:self action:@selector(regsterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundTableView addSubview:backToLoginLeftButton];
    [backgroundTableView addSubview:backToLoginButton];
    
    #endif
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    //CGContextRef context = UIGraphicsGetCurrentContext();
//    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColor whiteColor] setFill];
//    
////    [[selfplaceholder] drawInRect:rectwithFont:[UIFontsystemFontOfSize:20]];
//}

- (void)textFieldChanged:(UITextField *)textField
{
    _password = textField.text;
    CLog(@"%@",_password);
}


//- (void)tapAction:(UITapGestureRecognizer *)tap
//{
//    NSLog(@"被点击了");
//    [self.view endEditing:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  --------------------------- 事件处理 ------------------------------

/**
 *  取消登录
 *
 *  @param sender
 */
- (void)cancelButtonAction:(UIButton *)sender
{
    if (sender) {
        if ([sender.titleLabel.text isEqualToString:@"取消"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
    
        [self dismissViewControllerAnimated:YES completion:nil];
        CustomTabbarController * ctc = ((CustomTabbarController *)appdelegate.window.rootViewController);
        [ctc finishedLoginOrRegister:[ctc.view viewWithTag:10003]];

    }
    
}

/**
 *  注册
 *
 *  @param sender
 */
- (void)regsterButtonAction:(id)sender
{
    
//    ZMLogInLogOutViewController* log = [[ZMLogInLogOutViewController alloc] initWithNibName:@"ZMLogInLogOutViewController" bundle:nil];
//
//    UINavigationController* nav  = [[UINavigationController alloc] initWithRootViewController:log];
//    UIStoryboard *mainStoryBoard = [UIStoryboard  storyboardWithName:@"logInOut" bundle:nil];
    
//    ZMRegisterInViewController *LILO = (ZMRegisterInViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ZMRegisterInViewController"];
    
    
//    [self presentViewController:LILO animated:YES completion:^{
//        
//    }];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        ZMRegisterInViewController *LILO = [[ZMRegisterInViewController alloc] init];
        LILO.isForgetPassword = NO;
        LILO.isFromAppDelegate = _isFromAppDelegate;  //从appDelegate启动的。
        [self.navigationController pushViewController:LILO animated:YES];
    }
}

/**
 *  忘记密码
 *
 *  @param sender
 */

- (void)forgetPasswordAction:(id)sender
{
//    UIStoryboard *mainStoryBoard = [UIStoryboard  storyboardWithName:@"logInOut" bundle:nil];
//    ZMRegisterInViewController *LILO = (ZMRegisterInViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ZMRegisterInViewController"];
//    [self.navigationController pushViewController:LILO animated:YES];
    ZMRegisterInViewController *LILO = [[ZMRegisterInViewController alloc] init];
    LILO.isForgetPassword = YES;
    
    LILO.isFromAppDelegate = _isFromAppDelegate;  //从appDelegate启动的。
    [self.navigationController pushViewController:LILO animated:YES];
}

/**
 *  用户登录
 *
 *  @param button
 */
- (IBAction)LogIn:(UIButton *)button
{
    
    if (_userIdentity == nil || [_userIdentity isEqualToString:@""] ||
        _password == nil || [_password isEqualToString:@""]) {
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"账号和密码不能为空哦" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alterView show];
        
        return;
    }
    
    if(_userIdentity == nil || [_userIdentity isEqualToString:@""])
    {
        CLog(@"手机号码不能为空哦");
        
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"手机号码不能为空哦"];
        return;
    }
    
    if(![ZMTools isPhoneNumber:_userIdentity])
    {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"手机号码有误!"];
        return;
    }
    
    if(_password == nil || [_password isEqualToString:@""])
    {
        CLog(@"密码不能为空哦");
        
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"密码不能为空哦"];
        return;
    }
    
    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ProgressHUD.delegate = self;
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    [ProgressHUD setLabelText:@"登录中..."];
    
    //登录接口
    [[ZMServerAPIs shareZMServerAPIs] loginWithUID:_userIdentity PWD:_password Success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[response objectForKey:@"code"] integerValue] == 1000)
            {
                CLog(@"登录%@", response);
                
                //保存loginKey
                NSString * loginKey = [[response objectForKey:@"data"] objectForKey:@"loginKey"];
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] saveLoginKey:loginKey];
                
                //保存用户名和密码
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] saveUserId:_userIdentity password:_password];
                
                //设置登录状态
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:YES];
                
                //获取用户资产信息
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAssert];
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
                [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAccount];
                
                
                //刷新设置界面列表登录状态
                [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_SETTING_VIEW_NOTIFICATION_NAME object:nil];
                
                
                
                
                //更新user状态信息 并且保存数据库
                //                [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateTheNewestUserInfo:[response objectForKey:@"data"]];
                
                //百度统计
                //                [[BaiduMobStat defaultStat] logEvent:@"login" eventLabel:@"登录成功"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = ProgressHUD_TAG_FOR_SUCCESS;
                [ProgressHUD setLabelText:@"登录成功"];
                
                [ProgressHUD hide:YES afterDelay:1.5];
            });
            
            //        if(self.isCustomTabbar == YES)
            //        {
            //            [[NSNotificationCenter defaultCenter]postNotificationName:@"homePageLog" object:nil];
            //        }
            //改变状态
            [[NSNotificationCenter defaultCenter]postNotificationName:LOGIN_SUCCESS_NOTIFICATION_NAME object:nil];
            
        });
    } failure:^(id response) {
        
        CLog(@"登录%@", response);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(nil == response)
            {
                ProgressHUD.tag = ProgressHUD_TAG_FOR_FAILED;
                [ProgressHUD setLabelText:@"登录失败"];
                [ProgressHUD hide:YES afterDelay:1.5];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alert show];
                
                return ;
            }
            
            else if ([[response objectForKey:@"code"] integerValue] == 1001)
            {
                ProgressHUD.tag = ProgressHUD_TAG_FOR_NOT_USER;
                [ProgressHUD setLabelText:@"登录失败"];
                [ProgressHUD hide:YES afterDelay:1.5];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                
                alert.tag = ALERTVIEW_TAG_LOGIN_UserIsNotExist_Failed;
                
                [alert show];
                
                return ;
            }
            
            //{"message":"用户不存在","code":"3002"}
            else if ([[response objectForKey:@"code"] integerValue] == 3002)
            {
                if ([[response objectForKey:@"message"] isEqualToString:@"用户不存在"]) {
                    
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户名或密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                    //
                    //                    alert.tag = ALERTVIEW_TAG_LOGIN_WrongUID_PWD_Failed;
                    //                    [alert show];
                    
                    ProgressHUD.tag = ProgressHUD_TAG_FOR_NOT_USER;
                    [ProgressHUD setLabelText:@"用户不存在"];
                    [ProgressHUD hide:YES afterDelay:1.5];
                    
                }
                else if ([[response objectForKey:@"message"] isEqualToString:@"用户名或密码错误"])
                {
                    ProgressHUD.tag = ProgressHUD_TAG_FOR_NOT_USER;
                    [ProgressHUD setLabelText:@"用户名或密码错误"];
                    [ProgressHUD hide:YES afterDelay:1.5];
                }
                
                return ;
            }
            
            else if([[response objectForKey:@"code"] integerValue] == 1001  &&
                    [[response objectForKey:@"message"] isEqualToString:@"该账户已经被停用，请联系客服"])
            {
                CLog(@"登录被禁止＝＝＝＝ %@", response);
                ProgressHUD.tag = ProgressHUD_TAG_FOR_NOT_USER;
                [ProgressHUD setLabelText:@"登录失败"];
                [ProgressHUD hide:YES afterDelay:1.5];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重要提示" message:@"该账户已经被停用，请联系客服" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                
                alert.tag = ALERTVIEW_TAG_LOGIN_User_Disable_Failed;
                
                [alert show];
                
                return ;
            }
            else
            {
                
                //              {"message":"用户不可用","code":"2000"}
                
                NSString *messageStr = [response objectForKey:@"message"];
                
                ProgressHUD.tag = ProgressHUD_TAG_FOR_NOT_USER;
                [ProgressHUD setLabelText:@"登录失败"];
                [ProgressHUD hide:YES afterDelay:1.5];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重要提示"
                                                                message:[NSString stringWithFormat:@"%@，请联系客服", messageStr]
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"好的", nil];
                
                alert.tag = ALERTVIEW_TAG_LOGIN_User_Disable_Failed;
                
                [alert show];
                
                return ;
            }
        });
    }];
}




#pragma mark  --------------------------- UITextField delegate ------------------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    if (HEIGHT_OF_SCREEN == 480) {
        if (textField == _downloadTextField) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = _upTextField.frame;
                frame.origin.y -= 20;
                _upTextField.frame = frame;
                CGRect frame1 = _downloadTextField.frame;
                frame1.origin.y -= 20;
                _downloadTextField.frame = frame1;
                CGRect frame2 = _upView.frame;
                frame2.origin.y -= 20;
                _upView.frame = frame2;
                CGRect frame3 = _upLeftView.frame;
                frame3.origin.y -= 20;
                _upLeftView.frame = frame3;
                CGRect frame4 = _downView.frame;
                frame4.origin.y -= 20;
                _downView.frame = frame4;
                CGRect frame5 = _downLeftView.frame;
                frame5.origin.y -= 20;
                _downLeftView.frame = frame5;
                
                
            }];
        }
    }
    
    
    
    CLog(@"ShouldBegin ===  %@", textField.text);
    
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    CLog(@"DidBegin ===  %@", textField.text);
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CLog(@"ShouldEnd ===  %@", textField.text);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (HEIGHT_OF_SCREEN == 480) {
        if (textField == _downloadTextField ) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = _upTextField.frame;
            frame.origin.y += 20;
            _upTextField.frame = frame;
            CGRect frame1 = _downloadTextField.frame;
            frame1.origin.y += 20;
            _downloadTextField.frame = frame1;
            CGRect frame2 = _upView.frame;
            frame2.origin.y += 20;
            _upView.frame = frame2;
            CGRect frame3 = _upLeftView.frame;
            frame3.origin.y += 20;
            _upLeftView.frame = frame3;
            CGRect frame4 = _downView.frame;
            frame4.origin.y += 20;
            _downView.frame = frame4;
            CGRect frame5 = _downLeftView.frame;
            frame5.origin.y += 20;
            _downLeftView.frame = frame5;
            
            
            }];
        }
    }

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self LogIn:nil];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *tempString = [NSMutableString stringWithString: textField.text];
    
    if([string isEqualToString:@""] && range.location != 0)
    {
        [tempString deleteCharactersInRange:NSMakeRange(range.location, 1)];
    }
    else if ([string isEqualToString:@""] && range.location == 0)
    {
        if ([textField.text length] > 0)
        {
            [tempString deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    else
    {
        [tempString insertString:string atIndex:range.location];
    }
    
    if (textField == _upTextField) {
        CLog(@"userIdInput tempString ==== %@", tempString);
        _userIdentity = tempString;
    }
    return YES;
}


#pragma mark  --------------------------- UIScrollView Delegate ------------------------------
//上下滑动scroll 用于隐藏输入法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_upTextField resignFirstResponder];
    [_downloadTextField resignFirstResponder];
    self.view.transform = CGAffineTransformIdentity;
}



#pragma mark ZMLogInViewControllerDelegate
-(void)finishedLogin:(id)sender
{
    [self.delegate finishedLoginOrRegister:sender];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"SegueLogin"])
    {
        ZMLogInViewController * loginVC = segue.destinationViewController;
        [loginVC setDelegate:self];
        
    }
    else if ([segue.identifier isEqualToString:@"SegueRegister"])
    {
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
        tempBackgroundView.frame = CGRectMake(SPACE20_WITH_BORDER, 0, [UIScreen mainScreen].bounds.size.width - 2*SPACE20_WITH_BORDER, 44);
        
        
        //人物图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"userHeader"]];
        
        //        //标题
        //        UILabel *leftTitleLabel = [[UILabel alloc] init];
        //        leftTitleLabel.userInteractionEnabled = NO;
        //        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        //        leftTitleLabel.frame = CGRectMake(0, 0, 60, 44);
        //        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
        //        [leftTitleLabel setText:@"用户名"];
        
        //输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
        textField.textAlignment = NSTextAlignmentLeft;
        [textField setPlaceholder:@"手机号码 / 邮箱"];
        
        //        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:textField];
        [cell.contentView addSubview:tempBackgroundView];
        
        
        
        //        [textField setBackgroundColor:[UIColor grayColor]];
        //        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
    }
    
    else if (indexPath.row == 1) {
        //背板
        UIView *tempBackgroundView = [[UIView alloc] init];
        tempBackgroundView.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 44);
        
        
        //手机图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"password"]];
        
        //标题
        //        UILabel *leftTitleLabel = [[UILabel alloc] init];
        //        leftTitleLabel.userInteractionEnabled = NO;
        //        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        //        leftTitleLabel.frame = CGRectMake(0, 0, 60, 44);
        //        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
        //        [leftTitleLabel setText:@"密码"];
        
        //输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
        textField.textAlignment = NSTextAlignmentLeft;
        [textField setPlaceholder:@"请输入密码"];
        
        //        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:textField];
        [cell.contentView addSubview:tempBackgroundView];
        
        
        //        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
        //        [textField setBackgroundColor:[UIColor grayColor]];
    }
    
    return cell;
}


#pragma mark ------------------------ UIAlertView delegate ------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERTVIEW_TAG_LOGIN_UserIsNotExist_Failed) {
#warning  跳转到注册页面。
        
        [self regsterButtonAction:nil];
        
    }
    
    
    if (alertView.tag == ALERTVIEW_TAG_LOGIN_WrongUID_PWD_Failed) {
#warning  跳转到找回密码页面。
        
        [self forgetPasswordAction:nil];
        
    }
    
    
    if (alertView.tag == ALERTVIEW_TAG_LOGIN_User_Disable_Failed) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}


#pragma mark ------------------------ MBProgressHUD delegate ------------------------
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    
    switch (hud.tag) {
        case ProgressHUD_TAG_FOR_SUCCESS:
            if (self.isFromAppDelegate) {
                [self finishedLogin:nil];
            }
            else if (self.isCustomTabbarAcount)
            {
                [self finishedLogin:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (self.isCustomTabbarMore)
            {
                [self finishedLogin:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                CustomTabbarController * ctc = [[CustomTabbarController alloc] init];
                UIViewController *next =  ctc.customizableViewControllers[1];
                next.title = @"我要投资";
//                [next.navigationItem setHidesBackButton:YES];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                
//                [self.navigationController popToViewController:next animated:NO];
//                [self dismissViewControllerAnimated:NO completion:nil];
                [self.navigationController pushViewController:next animated:NO];
//                [self cancelButtonAction:nil];
            }
            break;
        case ProgressHUD_TAG_FOR_FAILED:
        case ProgressHUD_TAG_FOR_NOT_USER:
        default:
            break;
    }
}



@end
