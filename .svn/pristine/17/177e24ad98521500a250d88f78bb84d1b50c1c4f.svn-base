//
//  rizibaoTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "RizibaoTableViewCell.h"
#import "MacroDefine.h"
#import "ZMServerAPIs.h"

@implementation RizibaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_moneyTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _moneyTextField.delegate = self;
    //下一步
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_nextStepButton setFrame:CGRectMake(self.tipLabel.frame.size.width / 2, self.tipLabel.frame.origin.y + self.tipLabel.frame.size.height + 20, WIDTH_OF_SCREEN - self.tipLabel.frame.size.width, 44)];
    [_nextStepButton setTitle:@"赎回" forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_nextStepButton setBackgroundColor:Color_of_Red];
    [_nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    //默认情况下为非响应状态：
    //    _nextStepButton.enabled = NO;
    //    [_nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    _nextStepButton.layer.cornerRadius = 3.0;
    [_nextStepButton addTarget:self action:@selector(ransomRizibaoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextStepButton];
    [self getRizibaoInfo];
    [self.tipLabel setHidden:YES];
}

- (void)getRizibaoInfo
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"数据加载中..."];
    
    [[ZMServerAPIs shareZMServerAPIs] getRizibaoInfoSuccess:^(id response) {
        
        CLog(@"日紫宝信息：成功： %@", response);
        
        NSDictionary *rizibaoDic = [response objectForKey:@"data"];
        
        //add by Zhang Xiaohui ----2015-05-18
        //(data数据返回空,  防止程序crush)
        if([ZMTools isNullObject:rizibaoDic])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [progressHUD setLabelText:@"您还未投资过财行宝"];
                progressHUD.tag = 2001;
                [progressHUD hide:YES afterDelay:2.5];
            });
            return ;
        }
        //end add by Zhang Xiaohui ----2015-05-18

        
        
        //日紫宝余额
        double current_balance = 0.0;
        if (![ZMTools isNullObject:[rizibaoDic objectForKey:@"cup"]])
        {
            if (![ZMTools isNullObject:[[rizibaoDic objectForKey:@"cup"] objectForKey:@"current_balance"]])
            {
                current_balance = [[[rizibaoDic objectForKey:@"cup"] objectForKey:@"current_balance"] doubleValue];
            }
        }
        self.maxGetMoney = current_balance;
        //日紫宝累计收益
        double total_profit = 0.0;
        if (![ZMTools isNullObject:[rizibaoDic objectForKey:@"cup"]])
        {
            if (![ZMTools isNullObject:[[rizibaoDic objectForKey:@"cup"] objectForKey:@"total_profit"]])
            {
                total_profit = [[[rizibaoDic objectForKey:@"cup"] objectForKey:@"total_profit"] doubleValue];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.rizibaoSyLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",total_profit]];
            self.rizibaoAmountLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",current_balance]];
            
            
            //单日最高赎回金额
            totaldailyamount = [[rizibaoDic objectForKey:@"totaldailyamount"] floatValue];
            NSString * dailyAmountStr = [ZMTools moneyStandardMillionUnits:totaldailyamount];
            self.upperLimitLabel.text = [NSString stringWithFormat:@"单日赎回上限%@元", dailyAmountStr];
            
            
            progressHUD.tag = 2001;
            [progressHUD hide:YES afterDelay:1.5];
        });
    } failure:^(id response) {
        CLog(@"日子宝信息：失败： %@", response);
        dispatch_async(dispatch_get_main_queue(), ^(){
            [progressHUD setLabelText:@"数据加载失败，稍后再试"];
            progressHUD.tag = 2001;
            [progressHUD hide:YES afterDelay:1.5];
        });
    }];
}

- (void)getRizibaoInfoAfterRansom
{
//    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    progressHUD.delegate = self;
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    progressHUD.animationType = MBProgressHUDAnimationFade;
//    [progressHUD setLabelText:@"数据加载中..."];
    
    [[ZMServerAPIs shareZMServerAPIs] getRizibaoInfoSuccess:^(id response) {
        
        NSDictionary *rizibaoDic = [response objectForKey:@"data"];
        
        //add by Zhang Xiaohui ----2015-05-18
        //(data数据返回空,  防止程序crush)
        if([ZMTools isNullObject:rizibaoDic])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
//                progressHUD.tag = 2001;
//                [progressHUD hide:YES afterDelay:0];
            });
            return ;
        }
        //end add by Zhang Xiaohui ----2015-05-18
        
        
        
        //日紫宝余额
        double current_balance = [[[rizibaoDic objectForKey:@"cup"] objectForKey:@"current_balance"] doubleValue];
        self.maxGetMoney = current_balance;
        //日紫宝累计收益
        double total_profit = [[[rizibaoDic objectForKey:@"cup"] objectForKey:@"total_profit"] doubleValue];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.rizibaoSyLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",total_profit]];
            self.rizibaoAmountLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",current_balance]];
            
            
            //单日最高赎回金额
            totaldailyamount = [[rizibaoDic objectForKey:@"totaldailyamount"] floatValue];
            NSString * dailyAmountStr = [ZMTools moneyStandardMillionUnits:totaldailyamount];
            self.upperLimitLabel.text = [NSString stringWithFormat:@"单日赎回上限%@元", dailyAmountStr];
            
            
//            progressHUD.tag = 2001;
//            [progressHUD hide:YES afterDelay:0];
        });
    } failure:^(id response) {
        CLog(@"日子宝信息：失败： %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^(){
//            progressHUD.tag = 2001;
//            [progressHUD hide:YES afterDelay:0];
//        });
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)ransomRizibaoAction:(UIButton *)sender
{
    //单日赎回上限n元
    if(totaldailyamount > 0)
    {
        if([_moneyTextField.text floatValue] > totaldailyamount)
        {
            NSString * dailyAmountStr = [ZMTools moneyStandardMillionUnits:totaldailyamount];
            dailyAmountStr = [NSString stringWithFormat:@"单日赎回上限%@元", dailyAmountStr];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:dailyAmountStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [alter show];
            return;
        }
    }
    
    
    if (self.maxGetMoney < [_moneyTextField.text floatValue])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"余额不足" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
        return;
    }
    if ([_moneyTextField.text isEqualToString:@""]||[_moneyTextField.text floatValue] == 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入大于0的赎回金额" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
        return;
    }
    
    //单日赎回上限n元
    if(totaldailyamount > 0)
    {
        if([_moneyTextField.text floatValue] > totaldailyamount)
        {
            NSString * dailyAmountStr = [ZMTools moneyStandardMillionUnits:totaldailyamount];
            dailyAmountStr = [NSString stringWithFormat:@"单日赎回上限%@元", dailyAmountStr];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:dailyAmountStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [alter show];
            return;
        }
    }
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"正在赎回..."];
    
    double ransomAmount = [self.moneyTextField.text doubleValue];
    [[ZMServerAPIs shareZMServerAPIs] ransomRizibaoWithAmount:ransomAmount Success:^(id response)
    {
        CLog(@"赎回－success, %@", response);
        NSDictionary *rizibaoDic = [response objectForKey:@"data"];
        //日紫宝余额
        double current_balance = [[rizibaoDic objectForKey:@"current_balance"] doubleValue];
        self.maxGetMoney = current_balance;
        //日紫宝累计收益
//        double total_profit = [[rizibaoDic objectForKey:@"total_profit"] doubleValue];

        dispatch_async(dispatch_get_main_queue(), ^(){
            
//            self.rizibaoSyLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",total_profit]];
//            self.rizibaoAmountLabel.text = [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%.2f",current_balance]];
            [[ZMAdminUserStatusModel shareAdminUserStatusModel]updateUserAccount];
            [[ZMAdminUserStatusModel shareAdminUserStatusModel]updateUserAssert];
            [[ZMAdminUserStatusModel shareAdminUserStatusModel]updateUserBaseInfo];
            [self getRizibaoInfoAfterRansom];
            
            progressHUD.tag = 2001;
            [progressHUD setLabelText:@"赎回成功"];
            [progressHUD hide:YES afterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.5), dispatch_get_current_queue(), ^{
                if([self.delegate respondsToSelector:@selector(backToVC)])
                {
                    [self.delegate backToVC];
                }
            });
        });
    }
    failure:^(id response)
    {
        CLog(@"赎回－failed, %@", response);
        NSString *errorMessage = [response valueForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^(){
            progressHUD.tag = 2001;
            [progressHUD setLabelText:@""];
            [progressHUD hide:YES afterDelay:0];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alter.tag = 1000;
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
    NSMutableString *currentString = tempString;
    if ([currentString floatValue] > 500000)
    {
        _moneyTextField.text = @"500000";
        if (self.maxGetMoney < 500000)
        {
            [self.tipLabel setHidden:NO];
        }
        else
        {
            [self.tipLabel setHidden:YES];
        }
        return NO;
    }
    if (self.maxGetMoney < [currentString floatValue])
    {
        [self.tipLabel setHidden:NO];
    }
    else
    {
        [self.tipLabel setHidden:YES];
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
