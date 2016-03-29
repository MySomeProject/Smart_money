//
//  ZMPhoneNumVerifyCodeViewController.m
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMPhoneNumVerifyCodeViewController.h"
#import "AllStatusManager.h"

#import "ZMServerAPIs.h"

#import "ZMSafeSettingsViewController.h"

#import "ZMTools.h"
#import "HUD.h"
#import "MBProgressHUD.h"
#import "ZMPhoneNumVerifyTableViewCell.h"


#define COUNT_DOWN_NUMBER      60

/**
 *  请求验证码
 *
 *  @param button
 */

#define ProgressHUD_TAG_FOR_SUCCESS        2000
#define ProgressHUD_TAG_FOR_FAILED         2001
#define ProgressHUD_TAG_FOR_HAD_USED       2002

static int countdownNumber = 60;

@interface ZMPhoneNumVerifyCodeViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, MBProgressHUDDelegate>
{
    UITextField *textField;
    UIButton *nextStepButton;
    NSString *reuseCellIndentifier;
    
    UIButton *verificationCodeButton; //获取验证码
    UILabel *countdownLabel;   //显示倒计时
    NSTimer *countdownTimer;
}
@end

@implementation ZMPhoneNumVerifyCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //第一次进入自动获取手机验证码
//    [self requestVerificationCodeAction:verificationCodeButton];
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:verificationCodeButton repeats:YES];
    [countdownTimer fire];
    [verificationCodeButton setBackgroundColor:[UIColor lightGrayColor]];
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y_Offset_Subview_In_VC, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-Y_Offset_Subview_In_VC-2)
                                                                    style:UITableViewStyleGrouped];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
//    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    reuseCellIndentifier = @"ZMPhoneNumVerifyTableViewCell";
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]];
    UINib *nib = [UINib nibWithNibName:reuseCellIndentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
//    //提示语句Label
//    UILabel *topNotiLabel = [[UILabel alloc] init];
//    topNotiLabel.textAlignment = NSTextAlignmentLeft;
//    [topNotiLabel setFont:[UIFont systemFontOfSize:14]];
//    [topNotiLabel setTextColor:[UIColor grayColor]];
//    topNotiLabel.frame = CGRectMake(SPACE20_WITH_BORDER, SPACE10_WITH_BORDER, WIDTH_OF_SCREEN - 2*SPACE20_WITH_BORDER, 24);
//    [topNotiLabel setText:[NSString stringWithFormat:@"我们已将验证码发送到：%@", self.telephoneNumber]];
//    [backgroundTableView addSubview:topNotiLabel];
//    
//    
//    
//    //获取验证码
//
//    //背板
//    UIView *tempBackgroundView = [[UIView alloc] init];
//    tempBackgroundView.frame = CGRectMake(10, 40+44+10, [UIScreen mainScreen].bounds.size.width - 20, 44);
//    
//    //获取验证码 按钮
//    verificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [verificationCodeButton setFrame:CGRectMake(0, 0, 140, 30)];
//    [verificationCodeButton setTitleEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
//    [verificationCodeButton.layer setCornerRadius:3.0];
//    [verificationCodeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [verificationCodeButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    
//    [verificationCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
//    [verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//    
//    [verificationCodeButton setEnabled:YES]; //disable in normal
//    [verificationCodeButton setBackgroundColor:[UIColor lightGrayColor]];
//    
//    [verificationCodeButton addTarget:self action:@selector(requestVerificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
//    [tempBackgroundView addSubview:verificationCodeButton];
//    
//    
//    //倒计时码表   Label
//    CGRect frame = CGRectMake(verificationCodeButton.frame.origin.x + verificationCodeButton.frame.size.width, 0, 60, 44);
//    
//    countdownLabel = [[UILabel alloc] init];
//    countdownLabel.userInteractionEnabled = NO;
//    countdownLabel.textAlignment = NSTextAlignmentLeft;
//    [countdownLabel setFont:[UIFont systemFontOfSize:14]];
//    [countdownLabel setFrame:frame];
//    [countdownLabel setText:[NSString stringWithFormat:@" (%d秒)", 60]];
//    [tempBackgroundView addSubview:countdownLabel];
//    
//    
//    
//    [backgroundTableView addSubview:tempBackgroundView];
//    
//    
//
//    
//    //Verify Code
//    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [nextStepButton setFrame:CGRectMake(20/2.0, 150, [UIScreen mainScreen].bounds.size.width-20, 40)];
//    [nextStepButton.layer setCornerRadius:3.0];
//    [nextStepButton setTitle:@"确 认" forState:UIControlStateNormal];
//    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
//    nextStepButton.enabled = NO;
//    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
//    [nextStepButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [backgroundTableView addSubview:nextStepButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

/**
 *  重新获取手机验证码
 *
 *  @param button
 */
- (void)requestVerificationCodeAction:(UIButton *)button
{
    dispatch_async(dispatch_get_main_queue(), ^{
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:button repeats:YES];
        [countdownTimer fire];
        [button setBackgroundColor:[UIColor lightGrayColor]];
    });
    
    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ProgressHUD.delegate = self;
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    [ProgressHUD setLabelText:@"请稍等..."];
    
    
    [[ZMServerAPIs shareZMServerAPIs] bindMobile:self.telephoneNumber success:^(id response) {
        CLog(@"手机认证：获取手机验证码成功 %@", response);
        
        //验证码验证接口
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ProgressHUD.tag = ProgressHUD_TAG_FOR_SUCCESS;
            [ProgressHUD hide:YES afterDelay:0.5];
        });
        
    } failure:^(id response) {
        CLog(@"手机认证：获取手机验证码失败 %@", response);
        if(response == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ProgressHUD hide:YES afterDelay:0.5];
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alter show];
            });
        }
        
        else  //用户手机已经被他人使用的失败
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.tag = ProgressHUD_TAG_FOR_FAILED;
                [ProgressHUD setLabelText:@"验证码请求失败"];
                [ProgressHUD hide:YES afterDelay:2.5];
                
                if([[response objectForKey:@"code"] integerValue] == 1000 &&
                   [[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2001)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                        message:@"该手机号已被他人认证，请更换号码"
                                                                       delegate:self
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                else   //其他失败
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                        message:[response objectForKey:@"message"]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            });
        }
    }];
    
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
        [verificationCodeButton setBackgroundColor:[UIColor colorWithRed:65.0/255 green:178.0/255 blue:251.0/255 alpha:1.0]];
        
        //计时器失效
        [countdownTimer invalidate];
    }
}


/**
 *  本机对收到的验证码进行验证
 *
 *  @param button
 */
//- (void)confirmAction:(UIButton *)button
//{
//    if ([ZMAdminUserStatusModel isNullObject:self.telephoneNumber]||[self.telephoneNumber isEqualToString:@""])
//    {
//        ZMPhoneNumVerifyTableViewCell *cell = (ZMPhoneNumVerifyTableViewCell *)[self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        self.telephoneNumber = cell.mobileTextField.text;
//    }
//    [[ZMServerAPIs shareZMServerAPIs] confirmBindMobile:self.telephoneNumber verifyCode:textField.text success:^(id response)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.mobileAuthenticationBlock(YES);
//            
//            [self verifyCodeFinished:YES];
//        });
//    } failure:^(id response) {
//
//        //        {"data":{"result":2001},"code":1001}
//        
//        CLog(@"手机认证 验证码验证 response %@", response);
//        
//        //号码已经被认证过了
//        if ([[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2001 &&
//            [[response objectForKey:@"code"] integerValue] == 1001)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self verifyCodeFinished:NO];
//            });
//        }
//    }];
//}

/**
 *  检查是否有输入：短信验证码
 *
 */
- (void)checkButtonStatus:(BOOL)hasInput
{
    CLog(@"是否有输入 = %@", textField.text);
    if(![textField.text isEqualToString:@""])
    {
        hasInput = YES;
    }
    else{
        hasInput = NO;
    }
    
    if (hasInput) {
        nextStepButton.enabled = YES;
        [nextStepButton setBackgroundColor:Color_of_Red];
    }
    else
    {
        nextStepButton.enabled = NO;
        [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}



- (void)verifyCodeFinished:(BOOL)success
{
    if (success) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"手机认证成功!"];
        self.changePhoneNum(self.telephoneNumber);
        
        for(id vc in self.navigationController.viewControllers)
        {
            if([vc isKindOfClass:[ZMSafeSettingsViewController class]])
            {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
    else
    {
//        [[HUD sharedHUDText] showForTime:2.5 WithText:@"该手机号已用，请更换号码"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                            message:@"验证码错误，请重新输入"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
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
    [self.navigationController popViewControllerAnimated:YES];
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
    ZMPhoneNumVerifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier];
    
    if (!cell) {
        cell=[[ZMPhoneNumVerifyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIndentifier];
    }
    cell.parentController = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row == 0) {
//        
//        //背板
//        UIView *tempBackgroundView = [[UIView alloc] init];
//        tempBackgroundView.frame = CGRectMake(SPACE20_WITH_BORDER, 0, [UIScreen mainScreen].bounds.size.width - 2*SPACE20_WITH_BORDER, 44);
//        
//        
//        //标题
////        UILabel *leftTitleLabel = [[UILabel alloc] init];
////        leftTitleLabel.userInteractionEnabled = NO;
////        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
////        leftTitleLabel.frame = CGRectMake(0, 0, 60, 44);
////        [leftTitleLabel setBackgroundColor:[UIColor yellowColor]];
////        [leftTitleLabel setText:@"验证码"];
//        
//        //手机图片
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 0, 20)];//w==20
//        [imageView setImage:[UIImage imageNamed:@"verifyCode"]];
//        
//        //输入框
//        textField = [[UITextField alloc] init];
//        textField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
//        textField.textAlignment = NSTextAlignmentLeft;
//        [textField setKeyboardType:UIKeyboardTypePhonePad];
//        [textField setPlaceholder:@"请填写验证码"];
//        textField.delegate = self;
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(checkButtonStatus:)
//                                                     name:UITextFieldTextDidChangeNotification
//                                                   object:textField];
//        
//        
//        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, tempBackgroundView.frame.size.height-1, tempBackgroundView.frame.size.width+10, 0.5)];
//        [lineLabel setBackgroundColor:[UIColor lightGrayColor]];
//        
////        [tempBackgroundView addSubview:leftTitleLabel];
//        [tempBackgroundView addSubview:imageView];
//        [tempBackgroundView addSubview:textField];
//        [tempBackgroundView addSubview:lineLabel];
//        [cell.contentView addSubview:tempBackgroundView];
//        
//        
//        
//        
////        [textField setBackgroundColor:[UIColor grayColor]];
////        [tempBackgroundView setBackgroundColor:[UIColor yellowColor]];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}
     
@end
