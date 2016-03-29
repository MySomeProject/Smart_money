//
//  ZMPhoneNumVerifyTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/5/14.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ZMPhoneNumVerifyTableViewCell.h"
#import "ZMSafeSettingsViewController.h"
#import "GTCommontHeader.h"

//验证码计时
#define COUNT_DOWN_NUMBER      60
static int countdownNumber = COUNT_DOWN_NUMBER;
@implementation ZMPhoneNumVerifyTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.mobileTextField.delegate = self;
    self.mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.mobileTextField.tag = 1000;
    self.identifyCodeTextField.delegate = self;
    self.identifyCodeTextField.tag = 1001;
    self.identifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.getIdentifyButton.enabled = NO;
    self.nextSetupButton.enabled = NO;
    [self.mobileTextField becomeFirstResponder];
    [self createIdentifyButton];
    
    for (UIView* view in self.subviews){
        view.frame = GetFramByXib(view.frame);
        for (UIView* childview in view.subviews){
            childview.frame = GetFramByXib(childview.frame);
        }
    }
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureToHideInputBoard)];
    [self addGestureRecognizer:gesture];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)tapGestureToHideInputBoard
{
    [self.mobileTextField resignFirstResponder];
    [self.identifyCodeTextField resignFirstResponder];
}

- (void)createIdentifyButton
{
    self.getIdentifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getIdentifyButton setFrame:CGRectMake(209 ,84 , 91, 32)];
    [self.getIdentifyButton setTitleEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
    [self.getIdentifyButton.layer setCornerRadius:3.0];
    [self.getIdentifyButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.getIdentifyButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.getIdentifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getIdentifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getIdentifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [self.getIdentifyButton setEnabled:NO]; //disable in normal
    [self.getIdentifyButton setBackgroundColor:Color_of_Purple];
    
    
    [self.getIdentifyButton addTarget:self action:@selector(getIdentifyCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.getIdentifyButton];
}

-(void)waitTimeGetRandom:(NSTimer *)Timer
{
    if (countdownNumber >= 1) {
        self.getIdentifyButton.titleLabel.text = [NSString stringWithFormat:@"%d秒", countdownNumber];
//        [self.getIdentifyButton setBackgroundColor:Color_of_Purple];
        
        countdownNumber = countdownNumber-1;
        
        [self.getIdentifyButton setNeedsDisplay];
        
        self.getIdentifyButton.enabled = NO;
    }
    else if(countdownNumber == 0)
    {
        //恢复计数数值
        countdownNumber = COUNT_DOWN_NUMBER;
        if (![self.mobileTextField.text isEqualToString:@""])
        {
            self.getIdentifyButton.enabled = YES;
        }
        [self.getIdentifyButton setBackgroundColor:Color_of_Purple];
        self.getIdentifyButton.titleLabel.text = @"获取验证码";
        [self.getIdentifyButton setNeedsDisplay];
        //计时器失效
        [self.countdownTimer invalidate];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)bindMobileClicked:(id)sender
{
    if (![ZMTools isPhoneNumber:[self.mobileTextField text]])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
        return;
    }
    if ([self.identifyCodeTextField.text length] != 6)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入6位验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
        return;
    }
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"正在绑定手机..."];
    [[ZMServerAPIs shareZMServerAPIs] rebindMobileWithNewMobile:self.mobileTextField.text andIdentifyCode:self.identifyCodeTextField.text Success:^(id response)
     {
         CLog(@"success");
         dispatch_async(dispatch_get_main_queue(), ^(){
             progressHUD.tag = 2001;
             progressHUD.labelText = @"";
             [progressHUD hide:YES afterDelay:0];
             UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"绑定成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
             alter.tag = 1000;
             alter.delegate = self;
             [alter show];
             [ZMAdminUserStatusModel shareAdminUserStatusModel].mobileValidated = YES;
             ZMAdminUserStatusModel * adminUserInfoModel =[ZMAdminUserStatusModel shareAdminUserStatusModel];
             [adminUserInfoModel updateUserBaseInfo];

         });
     }
    failure:^(id response)
     {
         CLog(@"failed");
         NSString *errorMessage = [response valueForKey:@"message"];
         dispatch_async(dispatch_get_main_queue(), ^(){
             UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
             [alter show];
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
         });
     }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        NSArray *array = [self.parentController.navigationController viewControllers];
        [array enumerateObjectsUsingBlock:^(UIViewController *obj,NSUInteger idx,BOOL *stop)
        {
            if ([obj isKindOfClass:[ZMSafeSettingsViewController class]])
            {
                [self.parentController.navigationController popToViewController:obj animated:YES];
                return;
            }
        }];
    }
}

- (void)getIdentifyCodeClicked:(id)sender
{
    if (![ZMTools isPhoneNumber:[self.mobileTextField text]])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
        return;
    }
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"正在获取验证码..."];
    [[ZMServerAPIs shareZMServerAPIs] getIdentifyCodeByNewMobile:self.mobileTextField.text Success:^(id response)
     {
         CLog(@"seccess");
         dispatch_async(dispatch_get_main_queue(), ^(){
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
             self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitTimeGetRandom:) userInfo:self.getIdentifyButton repeats:YES];
             [self.countdownTimer fire];
             [self.getIdentifyButton setBackgroundColor:[UIColor lightGrayColor]];
         });
     }
     failure:^(id response)
     {
         CLog(@"failed");
         dispatch_async(dispatch_get_main_queue(), ^(){
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
             UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"获取验证码失败,请稍后重试。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
             [alter show];
         });
     }];

}

#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![self validateNumber:string])
    {
        return NO;
    }
    NSMutableString *tempString = [NSMutableString stringWithString: textField.text];
    BOOL isEnable = self.getIdentifyButton.enabled;
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
    NSString *textString = @"";
    NSMutableString *currentString = tempString;
    if (textField.tag == 1000)
    {
        textString = self.identifyCodeTextField.text;
    }
    else
    {
        textString = self.mobileTextField.text;
    }
    if (![currentString isEqualToString:@""]&&textField.tag == 1000)
    {
        isEnable = YES;
        if ([textString isEqualToString:@""])
        {
            self.nextSetupButton.enabled = NO;
        }
        else
        {
            self.nextSetupButton.enabled = YES;
        }
    }
    else if (textField.tag == 1000)
    {
        isEnable = NO;
        self.nextSetupButton.enabled = NO;
    }
    
    if (![currentString isEqualToString:@""]&&textField.tag == 1001)
    {
        if ([textString isEqualToString:@""])
        {
            isEnable = NO;
            self.nextSetupButton.enabled = NO;
        }
        else
        {
            isEnable = YES;
            self.nextSetupButton.enabled = YES;
        }
    }
    else if(textField.tag == 1001)
    {
        self.nextSetupButton.enabled = NO;
    }
    if (!self.countdownTimer.isValid)
    {
        self.getIdentifyButton.enabled = isEnable;
        if (self.getIdentifyButton.enabled)
        {
            [self.getIdentifyButton setBackgroundColor:Color_of_Purple];
        }
        else
        {
            [self.getIdentifyButton setBackgroundColor:Color_of_Purple];
        }
    }
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end