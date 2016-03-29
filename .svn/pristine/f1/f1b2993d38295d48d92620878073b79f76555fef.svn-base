//
//  ZMVerifyCodeViewController.m
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMVerifyCodeViewController.h"
#import "AllStatusManager.h"

#import "ZMPasswordViewController.h"

#import "ZMServerAPIs.h"

#define COUNT_DOWN_NUMBER      60

static int countdownNumber = 60;

//注册，手机号码已经存在，不能重复进行注册的验证码获取
#define   ALERTVIEW_TAG_CODE_UserAlreadyExisted_Failed       1000

//找回密码，手机号码不存在数据库中
#define   ALERTVIEW_TAG_CODE_UserNotExisted_Failed           1001



@interface ZMVerifyCodeViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    UIButton *verificationCodeButton; //获取验证码
    UILabel *countdownLabel;   //显示倒计时
    NSTimer *countdownTimer;
    
    UITextField *verifyCodeTextField;
    UIButton *nextStepButton;
}
@end

@implementation ZMVerifyCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //[期望]返回到输入验证码界面，系统不应发送验证码短信，倒计时为0，【重新获取验证码】按钮可点击。
    verifyCodeTextField.text = @"";
    [countdownLabel setText:[NSString stringWithFormat:@" (%d秒)", 0]];
    
    //恢复计数数值
    countdownNumber = COUNT_DOWN_NUMBER;
    verificationCodeButton.enabled = YES;
    [verificationCodeButton setBackgroundColor:[UIColor colorWithRed:65.0/255 green:178.0/255 blue:251.0/255 alpha:1.0]];
    
    //计时器失效
    [countdownTimer invalidate];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"输入验证码";
    
    
    self.telephoneNumber  = [self valueForKey:@"telephoneNumber"];
    
    
    
    //背景
    [self.view setBackgroundColor:[UIColor whiteColor]];

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
    
    
    
    
    //提示语句Label
    UILabel *topNotiLabel = [[UILabel alloc] init];
    topNotiLabel.textAlignment = NSTextAlignmentLeft;
    [topNotiLabel setFont:[UIFont systemFontOfSize:14]];
    [topNotiLabel setTextColor:[UIColor grayColor]];
    topNotiLabel.frame = CGRectMake(SPACE20_WITH_BORDER, SPACE10_WITH_BORDER, WIDTH_OF_SCREEN - 2*SPACE20_WITH_BORDER, 24);
    [topNotiLabel setText:[NSString stringWithFormat:@"我们已将验证码发送到：%@", self.telephoneNumber]];
    [backgroundTableView addSubview:topNotiLabel];
    
    
    
    //获取验证码

    //背板
    UIView *tempBackgroundView = [[UIView alloc] init];
    tempBackgroundView.frame = CGRectMake(10, 40+44+10, [UIScreen mainScreen].bounds.size.width - 20, 44);
    
    //获取验证码 按钮
    verificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificationCodeButton setFrame:CGRectMake(0, 0, 140, 30)];
    [verificationCodeButton setTitleEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
    [verificationCodeButton.layer setCornerRadius:3.0];
    [verificationCodeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [verificationCodeButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [verificationCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    [verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [verificationCodeButton setEnabled:YES]; //disable in normal
    [verificationCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [verificationCodeButton addTarget:self action:@selector(requestVerificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBackgroundView addSubview:verificationCodeButton];
    
    
    //倒计时码表   Label
    CGRect frame = CGRectMake(verificationCodeButton.frame.origin.x + verificationCodeButton.frame.size.width, 0, 60, 44);
    countdownLabel = [[UILabel alloc] init];
    countdownLabel.userInteractionEnabled = NO;
    countdownLabel.textAlignment = NSTextAlignmentLeft;
    [countdownLabel setFont:[UIFont systemFontOfSize:14]];
    [countdownLabel setFrame:frame];
    [countdownLabel setText:[NSString stringWithFormat:@" (%d秒)", 60]];
    [tempBackgroundView addSubview:countdownLabel];
    
    
    
    [backgroundTableView addSubview:tempBackgroundView];
    
    

    
    //下一步按钮：获取验证码  Verify Phone Number
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextStepButton.enabled = NO;
    [nextStepButton setFrame:CGRectMake(20/2.0, 150, [UIScreen mainScreen].bounds.size.width-20, 40)];
    [nextStepButton.layer setCornerRadius:3.0];
    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundTableView addSubview:nextStepButton];
    
    
    //第一次启动计时器
    dispatch_async(dispatch_get_main_queue(), ^{
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:verificationCodeButton repeats:YES];
        [countdownTimer fire];
        
        [verificationCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  重新获取手机验证码
 *
 *  @param button
 */
- (void)requestVerificationCodeAction:(UIButton *)button
{
    //防止从输入密码的界面回到该界面，又重启新的timer;
    if(countdownTimer.valid)
    {
        return;
    }
    if (self.isForgetPassword) {  //找回密码
        
        [[ZMServerAPIs shareZMServerAPIs] findPWDForRequestVerifyCodeWithMobile:self.telephoneNumber Success:^(id response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:button repeats:YES];
                [countdownTimer fire];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
            });
            CLog(@"找回密码 请求验证码成功，response == %@", response);
            
        } failure:^(id response) {
            
            CLog(@"response == %@", response);
            
            //网络异常
            if(nil == response)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                
                //                alter.tag = ALERTVIEW_TAG_LOGIN_UserIsNotExist_Failed;
                
                [alter show];
                
                return ;
            }
            
            if ([[response objectForKey:@"code"] integerValue] == 1000 &&
                [[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2010)
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该号码不存在，请确认手机号码是否正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                
                alter.tag = ALERTVIEW_TAG_CODE_UserNotExisted_Failed;
                
                [alter show];
            }
            else
            {
            }
        }];
    }
    else
    {
        //注册
        [[ZMServerAPIs shareZMServerAPIs] requestVerifyCodeWithUID:self.telephoneNumber Success:^(id response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:button repeats:YES];
                [countdownTimer fire];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
            });
        } failure:^(id response) {
            
            //网络异常
            if(nil == response)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                    [alter show];
                });
                return ;
            }
            
            //已经是注册手机了{"message":"发送失败","data":{"result":2002},"code":1000}
            if ([[response objectForKey:@"code"] integerValue] == 1000 &&
                [[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2002) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已经是注册用户，请直接登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                    alter.tag = ALERTVIEW_TAG_CODE_UserAlreadyExisted_Failed;
                    [alter show];
                    return;
                });
            }
            
            
            //{"message":"发送失败","data":{"result":2000},"code":1001}
            //发送失败
            if ([[response objectForKey:@"code"] integerValue] == 1001)
            {
                CLog(@"response == %@", response);
            }
            else
            {
            }
        }];
    }
}


-(void)waitTimeGetRandom:(NSTimer *)Timer
{
    if (countdownNumber >= 1) {
        countdownNumber = countdownNumber-1;
        [countdownLabel setText:[NSString stringWithFormat:@" (%d秒)", countdownNumber]];
        [countdownLabel setNeedsDisplay];
        
        
        verificationCodeButton.enabled = NO;
        [verificationCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    else if(countdownNumber == 0)
    {
        [countdownLabel setText:[NSString stringWithFormat:@" (%d秒)", countdownNumber]];
        [countdownLabel setNeedsDisplay];
        
        //恢复计数数值
        countdownNumber = COUNT_DOWN_NUMBER;
        
        verificationCodeButton.enabled = YES;
        [verificationCodeButton setBackgroundColor:Color_of_Purple];
        
        //计时器失效
        [countdownTimer invalidate];
    }
}


/**
 *  下一步,验证验证码是否正确
 *
 *  @param button
 */
- (void)nextStepAction:(UIButton *)button
{
    if ([verifyCodeTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alertView show];
    }
    else
    {
        
#warning 验证验证码 成功后自动跳转到密码输入栏目
        
        if(self.isForgetPassword)
        {
            [[ZMServerAPIs shareZMServerAPIs] findPWDForCheckingRegisterCode:verifyCodeTextField.text phoneNumber:self.telephoneNumber Success:^(id response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZMPasswordViewController *passwordVC = [[ZMPasswordViewController alloc]init];
                    
                    passwordVC.isFromAppDelegate = _isFromAppDelegate;   //从App delegate过来的
                    
                    if (self.isForgetPassword) {
                        passwordVC.isForgetPassword = self.isForgetPassword;
                    }
                    
                    [passwordVC setValue:self.telephoneNumber forKey:@"telephoneNumber"];
                    [self.navigationController pushViewController:passwordVC animated:YES];
                });
                
            } failure:^(id response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(nil == response)
                    {
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                        
                        [alter show];
                        return ;
                    }
                    else
                    {
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码错误，请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                        [alter show];
                        return ;
                    }
                });
            }];
        }
        else
        {
            [[ZMServerAPIs shareZMServerAPIs] checkingRegisterCode:verifyCodeTextField.text phoneNumber:self.telephoneNumber Success:^(id response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZMPasswordViewController *passwordVC = [[ZMPasswordViewController alloc]init];
                    
                    passwordVC.isFromAppDelegate = _isFromAppDelegate;   //从App delegate过来的
                    
                    [passwordVC setValue:self.telephoneNumber forKey:@"telephoneNumber"];
                    [self.navigationController pushViewController:passwordVC animated:YES];
                });
                
            } failure:^(id response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(nil == response)
                    {
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                        
                        [alter show];
                        return ;
                    }
                    else
                    {
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码错误，请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                        [alter show];
                        return ;
                    }
                });
            }];
        }
    }
}

/**
 *  检查是否输入验证码
 *
 *  @param notification
 */
- (void)checkButtonStatus:(NSNotification *)notification
{
    if((UITextField *)notification.object == verifyCodeTextField)
    {
        CLog(@"nameTextField = %@", verifyCodeTextField.text);
    }
    
    if(![verifyCodeTextField.text isEqualToString:@""])
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
    [[AllStatusManager sharedStatusManager] setLoggedIn:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case ALERTVIEW_TAG_CODE_UserAlreadyExisted_Failed:
            if (buttonIndex == 0) {
                [self.navigationController popToRootViewControllerAnimated:YES];    //返回登录界面
            }
            break;
            
        case ALERTVIEW_TAG_CODE_UserNotExisted_Failed:
            if (buttonIndex == 0) {
                [self.navigationController popViewControllerAnimated:YES];    //返回手机号码输入界面
            }
            break;
            
        default:
            break;
    }
}


#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
        
        
        //标题
//        UILabel *leftTitleLabel = [[UILabel alloc] init];
//        leftTitleLabel.userInteractionEnabled = NO;
//        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
//        leftTitleLabel.frame = CGRectMake(0, 0, 60, 44);
//        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
//        [leftTitleLabel setText:@"验证码"];
        
        //手机图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"verifyCode"]];
        
        //输入框
        verifyCodeTextField = [[UITextField alloc] init];
        verifyCodeTextField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
        verifyCodeTextField.textAlignment = NSTextAlignmentLeft;
        [verifyCodeTextField setKeyboardType:UIKeyboardTypePhonePad];
        [verifyCodeTextField setPlaceholder:@"请填写验证码"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkButtonStatus:) name:UITextFieldTextDidChangeNotification object:verifyCodeTextField];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, tempBackgroundView.frame.size.height-1, tempBackgroundView.frame.size.width+10, 0.5)];
        [lineLabel setBackgroundColor:[UIColor clearColor]];
        
//        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:verifyCodeTextField];
        [tempBackgroundView addSubview:lineLabel];
        [cell.contentView addSubview:tempBackgroundView];
        
        
        
        
//        [textField setBackgroundColor:[UIColor grayColor]];
//        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
    }
    
    return cell;
}

@end
