//
//  ZMPhoneSettingViewController.m
//  ZMSD
//
//  Created by zima on 14-12-24.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMPhoneNumberSettingViewController.h"

#import "ZMPhoneNumVerifyCodeViewController.h"

#import "ZMTools.h"
#import "HUD.h"
#import "MBProgressHUD.h"
#import "ZMPhoneNumberTableViewCell.h"
#import "ZMPhoneNumVerifyCodeViewController.h"

@interface ZMPhoneNumberSettingViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, MBProgressHUDDelegate>
{
    //昵称输入框
    UITextField *textField;
    
    NSMutableString *currentString;
    NSString *reuseCellIndentifier;
    //The confirm action button
    UIButton *nextStepButton;
}
@end

@implementation ZMPhoneNumberSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手机认证";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //输入框tableView背板（可上下弹动）
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-2)
                                                  style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0]];
//    
//    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 0)];
//    [tableHeader setBackgroundColor:[UIColor whiteColor]];
//    self.tableView.tableHeaderView = tableHeader;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //确认设置
//    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [nextStepButton setFrame:CGRectMake(20/2.0, 110, [UIScreen mainScreen].bounds.size.width-20, 44)];
//    [nextStepButton setTitle:@"下 一 步" forState:UIControlStateNormal];
//    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    //默认情况下为非响应状态：
//    nextStepButton.enabled = NO;
//    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
//    nextStepButton.layer.cornerRadius = 3.0;
//    [nextStepButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.tableView addSubview:nextStepButton];
    
    reuseCellIndentifier = @"ZMPhoneNumberTableViewCell";
    UINib *nib = [UINib nibWithNibName:@"ZMPhoneNumberTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    ZMPhoneNumberTableViewCell* cell =(ZMPhoneNumberTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.countdownTimer invalidate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)mobileBlock:(MobileAuthenticationBlock)block
{
    self.mobileAuthenticationBlock = block;
}

/**
 *  请求验证码
 *
 *  @param button
 */

#define ProgressHUD_TAG_FOR_SUCCESS        2000
#define ProgressHUD_TAG_FOR_FAILED         2001
#define ProgressHUD_TAG_FOR_HAD_USED       2002

//-(void)confirmAction:(UIButton *)button
//{
//    if(![ZMTools isPhoneNumber:textField.text])
//    {
//        [[HUD sharedHUDText] showForTime:1.5 WithText:@"手机号有误!"];
//        return;
//    }
//    
//    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    ProgressHUD.delegate = self;
//    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
//    [ProgressHUD setLabelText:@"请稍等..."];
//    
//    
//    [[ZMServerAPIs shareZMServerAPIs] bindMobile:textField.text success:^(id response) {
//        CLog(@"手机认证：获取手机验证码成功 %@", response);
//        
//        //验证码验证接口
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            ProgressHUD.tag = ProgressHUD_TAG_FOR_SUCCESS;
//            [ProgressHUD hide:YES afterDelay:0.5];
//            
//            [self confirmVerifyCode];
//        });
//        
//    } failure:^(id response) {
//        CLog(@"手机认证：获取手机验证码失败 %@", response);
//        if(response == nil)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [ProgressHUD hide:YES afterDelay:0.5];
//                
//                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
//                [alter show];
//            });
//        }
//        
//        else  //用户手机已经被他人使用的失败
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                ProgressHUD.tag = ProgressHUD_TAG_FOR_FAILED;
//                [ProgressHUD setLabelText:@"验证码请求失败"];
//                [ProgressHUD hide:YES afterDelay:2.5];
//                
//                if([[response objectForKey:@"code"] integerValue] == 1000 &&
//                   [[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2001)
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                                        message:@"该手机号已被他人认证，请更换号码"
//                                                                       delegate:self
//                                                              cancelButtonTitle:@"确定"
//                                                              otherButtonTitles:nil];
//                    [alertView show];
//                }
//                else   //其他失败
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                                        message:[response objectForKey:@"message"]
//                                                                       delegate:nil
//                                                              cancelButtonTitle:@"确定"
//                                                              otherButtonTitles:nil];
//                    [alertView show];
//                }
//            });
//        }
//        
////        else  //普通的失败
////        {
////            dispatch_async(dispatch_get_main_queue(), ^{
////                ProgressHUD.tag = ProgressHUD_TAG_FOR_FAILED;
////                [ProgressHUD setLabelText:@"验证码请求失败"];
////                [ProgressHUD hide:YES afterDelay:2.5];
////            });
////        }
//        
//    }];
//}

//-(void)confirmVerifyCode
//{
//    ZMPhoneNumVerifyCodeViewController * next = [[ZMPhoneNumVerifyCodeViewController alloc] init];
//    
//    [next setValue:textField.text forKey:@"telephoneNumber"];
//    
//    next.mobileAuthenticationBlock = self.mobileAuthenticationBlock;
//    
//    [self.navigationController pushViewController:next animated:YES];
//}


#pragma mark ------------------------ MBProgressHUD delegate ------------------------
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    
    switch (hud.tag) {
        case ProgressHUD_TAG_FOR_SUCCESS:
        case ProgressHUD_TAG_FOR_FAILED:
        case ProgressHUD_TAG_FOR_HAD_USED:
        default:
            break;
    }
}







//检查是否有输入
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMPhoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier];
    
    if (!cell) {
        cell=[[ZMPhoneNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nextSetupBlock = ^(){
        if (!self.phoneNumVCController)
        {
            self.phoneNumVCController = [[ZMPhoneNumVerifyCodeViewController alloc] init];
        }
        [self.navigationController pushViewController:self.phoneNumVCController animated:YES];
    };
//    if (indexPath.row == 0) {
//        
//        //背板
//        UIView *tempBackgroundView = [[UIView alloc] init];
//        tempBackgroundView.frame = CGRectMake(SPACE20_WITH_BORDER, 0, [UIScreen mainScreen].bounds.size.width - 2*SPACE20_WITH_BORDER, 44);
//        
//        
//        //标题
//        //        UILabel *leftTitleLabel = [[UILabel alloc] init];
//        //        leftTitleLabel.userInteractionEnabled = NO;
//        //        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
//        //        leftTitleLabel.frame = CGRectMake(0, 0, 80, 44);
//        //        [leftTitleLabel setBackgroundColor:[UIColor redColor]];
//        //        [leftTitleLabel setText:@"手机号码"];
//        
//        //手机图片
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 0, 20)];//w=20
//        [imageView setImage:[UIImage imageNamed:@"nikeName.png"]];
//        
//        
//        //输入框
//        textField = [[UITextField alloc] init];
//        textField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);
//        
//        [textField setKeyboardType:UIKeyboardTypePhonePad];
//        textField.textAlignment = NSTextAlignmentLeft;
//        [textField setPlaceholder:@"请输入并确认您的手机号码"];
//        [textField setBackgroundColor:[UIColor whiteColor]];
//        textField.delegate = self;
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(checkButtonStatus:)
//                                                     name:UITextFieldTextDidChangeNotification
//                                                   object:nil];
//        
//        
//        
//        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, tempBackgroundView.frame.size.height-1, tempBackgroundView.frame.size.width+10, 0.5)];
//        [lineLabel setBackgroundColor:[UIColor lightGrayColor]];
//        
//        
//        [tempBackgroundView addSubview:imageView];
//        [tempBackgroundView addSubview:textField];
//        [tempBackgroundView addSubview:lineLabel];
//        [cell.contentView addSubview:tempBackgroundView];
//        
//        
//        [tempBackgroundView setBackgroundColor:[UIColor clearColor]];
//        [imageView setBackgroundColor:[UIColor clearColor]];
//        [textField setBackgroundColor:[UIColor clearColor]];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark UITextField delegate ------------------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
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
    CLog(@"DidEnd ===  %@", textField.text);
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
    
    currentString = tempString;
    
    return YES;
}
@end
