//
//  ZMRegisterInViewController.m
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMForgetPWDViewController.h"

#import "AllStatusManager.h"

#import "ZMVerifyCodeViewController.h"

#import "ZMNavigationController.h"
#import "ZMPresentWebViewController.h"


#import "ZMTools.h"
#import "HUD.h"


//天蓝色
#define COLOR_FOR_AGREEMENT_BUTTON              [UIColor colorWithRed:102.0/255 green:202.0/255 blue:248.0/255 alpha:1.0]
#define COLOR_FOR_AGREEMENT_BUTTON_HIGHLIGHT    [UIColor colorWithRed:65.0/255 green:178.0/255 blue:251.0/255 alpha:1.0]

@interface ZMForgetPWDViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    //手机号码输入框
    UITextField *phoneNumberTextField;
    UIButton *checkAgreeButton;
    //The next step action button
    UIButton *nextStepButton;
}
@end

@implementation ZMForgetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户注册";
    
    
    //背景
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    //输入框tableView背板（可上下弹动）
    UITableView *backgroundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-2)
                                                                    style:UITableViewStyleGrouped];
    [self.view addSubview:backgroundTableView];
    [backgroundTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [backgroundTableView setBackgroundColor:[UIColor clearColor]];
    backgroundTableView.allowsSelection = YES;
    backgroundTableView.delegate = self;
    backgroundTableView.dataSource = self;
    
    
    //协议栏

    //协议栏背板
    UIView *tempBackgroundView = [[UIView alloc] init];
    tempBackgroundView.frame = CGRectMake(10, 40+40, [UIScreen mainScreen].bounds.size.width - 20, 44);
    
    
    //勾选按钮
    CGSize textSize = [ZMTools calculateTheLabelSizeWithText:@"同意财行家易贷" font:[UIFont systemFontOfSize:14]];
    
    float buttonWidth = SPACE10_WITH_BORDER + 30 + SPACE10_WITH_BORDER + textSize.width;
    
    checkAgreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkAgreeButton setFrame:CGRectMake(0, 0, buttonWidth, 44)];
    [checkAgreeButton setImage:[UIImage imageNamed:@"tongyiduigou4.png"] forState:UIControlStateNormal];
    [checkAgreeButton setImage:[UIImage imageNamed:@"tongyiduigou.png"] forState:UIControlStateSelected];
    [checkAgreeButton setImageEdgeInsets:UIEdgeInsetsMake(7, SPACE10_WITH_BORDER, 7, buttonWidth-30-SPACE10_WITH_BORDER)];
    
    [checkAgreeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [checkAgreeButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [checkAgreeButton setTitleEdgeInsets:UIEdgeInsetsMake(12, 5, 12, -10)];
    [checkAgreeButton setTitle:@"同意财行家易贷" forState:UIControlStateNormal];
    [checkAgreeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [checkAgreeButton addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempBackgroundView addSubview:checkAgreeButton];
    
    
    
    
    //协议1按钮
    CGRect frame = CGRectMake(checkAgreeButton.frame.size.width-5, 0, 80, 44);
    
    UIButton *usingAgreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [usingAgreementButton setFrame:frame];
    [usingAgreementButton setTitleEdgeInsets:UIEdgeInsetsMake(12, -5, 12, -5)];
    [usingAgreementButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [usingAgreementButton setTitleColor:COLOR_FOR_AGREEMENT_BUTTON forState:UIControlStateNormal];
    [usingAgreementButton setTitleColor:COLOR_FOR_AGREEMENT_BUTTON_HIGHLIGHT forState:UIControlStateHighlighted];
    [usingAgreementButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [usingAgreementButton setTitle:@"《使用协议》" forState:UIControlStateNormal];
    [usingAgreementButton addTarget:self action:@selector(usingAgreementShow:) forControlEvents:UIControlEventTouchUpInside];
    [tempBackgroundView addSubview:usingAgreementButton];
    
    //“及”   Label
    frame = CGRectMake(usingAgreementButton.frame.origin.x + usingAgreementButton.frame.size.width, 0, 14, 44);
    
    UILabel *andLabel = [[UILabel alloc] init];
    andLabel.userInteractionEnabled = NO;
    andLabel.textAlignment = NSTextAlignmentLeft;
    [andLabel setFont:[UIFont systemFontOfSize:14]];
    [andLabel setFrame:frame];
    [andLabel setText:@"和"];
    [andLabel setTextColor:[UIColor lightGrayColor]];
    [tempBackgroundView addSubview:andLabel];
    
    //协议2按钮
    frame = CGRectMake(andLabel.frame.origin.x + andLabel.frame.size.width, 0, 80, 44);
    
    UIButton *privacyAgreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privacyAgreementButton setBackgroundColor:[UIColor clearColor]];
    [privacyAgreementButton setFrame:frame];
    [privacyAgreementButton setTitleEdgeInsets:UIEdgeInsetsMake(12, -5, 12, -5)];
    [privacyAgreementButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [privacyAgreementButton setTitleColor:COLOR_FOR_AGREEMENT_BUTTON forState:UIControlStateNormal];
    [privacyAgreementButton setTitleColor:COLOR_FOR_AGREEMENT_BUTTON_HIGHLIGHT forState:UIControlStateHighlighted];
    [privacyAgreementButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [privacyAgreementButton setTitle:@"《隐私协议》" forState:UIControlStateNormal];
    [privacyAgreementButton addTarget:self action:@selector(privacyAgreementShow:) forControlEvents:UIControlEventTouchUpInside];
    [tempBackgroundView addSubview:privacyAgreementButton];
    
    [backgroundTableView addSubview:tempBackgroundView];
    
    
    
    

//    [tempBackgroundView setBackgroundColor:[UIColor whiteColor]];
    
//    [checkButton setBackgroundColor:[UIColor redColor]];
//    [checkButton.titleLabel setBackgroundColor:[UIColor whiteColor]];
    
//    [usingAgreementButton setBackgroundColor:[UIColor purpleColor]];
//    [andLabel setBackgroundColor:[UIColor yellowColor]];
//    [privacyAgreementButton setBackgroundColor:[UIColor redColor]];
    
    
    
    
    
    
    //下一步按钮：获取验证码  Verify Phone Number
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    [nextStepButton setFrame:CGRectMake(20/2.0, 150, [UIScreen mainScreen].bounds.size.width-20, 40)];
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];

    //默认情况下为非响应状态：
    nextStepButton.enabled = NO;
    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    nextStepButton.layer.cornerRadius = 3.0;
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundTableView addSubview:nextStepButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  是否同意两个用户协议
 *
 *  @param button
 */
- (void)checkButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    NSLog(@"是否同意协议 = %@", button.selected ? @"同意" : @"不同意");
    
    if (button.selected && ![phoneNumberTextField.text isEqualToString:@""]) {
        nextStepButton.enabled = YES;
        [nextStepButton setBackgroundColor:Color_of_Purple];
    }
    else
    {
        nextStepButton.enabled = NO;
        [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}

/**
 *  检查是否有输入
 *
 *  @param notification
 */
- (void)checkButtonStatus:(NSNotification *)notification
{
    if((UITextField *)notification.object == phoneNumberTextField)
    {
        CLog(@"nameTextField = %@", phoneNumberTextField.text);
    }
    
    if(![phoneNumberTextField.text isEqualToString:@""] && checkAgreeButton.selected)
    {
        nextStepButton.enabled = YES;
        [nextStepButton setBackgroundColor:Color_of_Purple];
    }
    else{
        nextStepButton.enabled = NO;
        [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}

/**
 *  使用协议
 *
 *  @param button
 */
-(void)usingAgreementShow:(UIButton *)button
{
    //Using present style
    ZMPresentWebViewController *webViewNext = [[ZMPresentWebViewController alloc]init];
    [webViewNext setValue:@"http://www.baidu.com" forKey:@"vkey"];
    ZMNavigationController *navigationVC = [[ZMNavigationController alloc]initWithRootViewController:webViewNext];
    
    [self.navigationController presentViewController:navigationVC animated:YES completion:^{
        
    }];
}

/**
 *  隐私保护协议
 *
 *  @param button
 */
-(void)privacyAgreementShow:(UIButton *)button
{
    //Using present style
    ZMPresentWebViewController *webViewNext = [[ZMPresentWebViewController alloc]init];
    [webViewNext setValue:@"http://www.baidu.com" forKey:@"vkey"];
    
    ZMNavigationController *navigationVC = [[ZMNavigationController alloc]initWithRootViewController:webViewNext];
    
    [self.navigationController presentViewController:navigationVC animated:YES completion:^{
        
    }];
}



/**
 *  下一步进入输入验证码页面
 *
 *  @param button <#button description#>
 */
- (void)nextStepAction:(UIButton *)button
{
    
    if(![ZMTools isPhoneNumber:phoneNumberTextField.text])
    {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"手机号有误!"];
        return;
    }
    
    
    
#warning -- TO DO -----验证手机号码的正确性------
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认注册" message:@"我们将发送验证码到您的手机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


- (IBAction)registerInFinished:(UIButton *)button
{
    NSLog(@"registerInFinished");
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
    if (buttonIndex == 0) {
        return;
    }
    else if(buttonIndex == 1)
    {
        ZMVerifyCodeViewController *verifyCodeVC = [[ZMVerifyCodeViewController alloc]init];
        
        [verifyCodeVC setValue:[NSString stringWithFormat:@"%@", phoneNumberTextField.text] forKey:@"telephoneNumber"];
        
        [self.navigationController pushViewController:verifyCodeVC animated:YES];
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
//        leftTitleLabel.frame = CGRectMake(0, 0, 80, 44);
//        [leftTitleLabel setBackgroundColor:[UIColor redColor]];
//        [leftTitleLabel setText:@"手机号码"];

        //手机图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"cellphone"]];
        
        
        //输入框
        phoneNumberTextField = [[UITextField alloc] init];
        phoneNumberTextField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
        [phoneNumberTextField setKeyboardType:UIKeyboardTypePhonePad];
        phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
        [phoneNumberTextField setPlaceholder:@"请输入您的手机号码"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkButtonStatus:) name:UITextFieldTextDidChangeNotification object:phoneNumberTextField];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, tempBackgroundView.frame.size.height-1, tempBackgroundView.frame.size.width+10, 0.5)];
        [lineLabel setBackgroundColor:[UIColor lightGrayColor]];
        
        
//        [tempBackgroundView addSubview:leftTitleLabel];
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:phoneNumberTextField];
        [tempBackgroundView addSubview:lineLabel];
        [cell.contentView addSubview:tempBackgroundView];
        
        [tempBackgroundView setBackgroundColor:[UIColor clearColor]];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [phoneNumberTextField setBackgroundColor:[UIColor clearColor]];
    }
    
    return cell;
}

@end
