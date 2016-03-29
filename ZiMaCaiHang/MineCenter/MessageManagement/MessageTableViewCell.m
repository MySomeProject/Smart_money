//
//  MessageTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //下一步
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_nextStepButton setFrame:CGRectMake((WIDTH_OF_SCREEN - 130)/2, self.bottomLine.frame.origin.y + 40, 130, 43)];
    [_nextStepButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_nextStepButton setBackgroundColor:Color_of_Red];
    [_nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    //默认情况下为非响应状态：
    _nextStepButton.layer.cornerRadius = 3.0;
    [_nextStepButton addTarget:self action:@selector(sureChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextStepButton];
}

//确定修改设置
- (void)sureChanged:(UIButton *)sender
{
    sender.enabled = NO;
    NSMutableArray *openEmail = [NSMutableArray array];
    NSMutableArray *openInstationSms = [NSMutableArray array];
    NSMutableArray *openSms = [NSMutableArray array];
    //短信
    if (self.topupIsOpenSmsButton.selected)
    {
        [openSms addObject:@"TOPUP"];
    }
    if (self.drawdIsOpenSmsButton.selected)
    {
        [openSms addObject:@"WITHDRAWDEPOSIT"];
    }
    if (self.investIsOpenSmsButton.selected)
    {
        [openSms addObject:@"INVESTSUCCESS"];
    }
    if (self.refundIsOpenSmsButton.selected)
    {
        [openSms addObject:@"REFUND"];
    }
    //站内信
    if (self.topupIsOpenInSmsButton.selected)
    {
        [openInstationSms addObject:@"TOPUP"];
    }
    if (self.drawdIsOpenInSmsButton.selected)
    {
        [openInstationSms addObject:@"WITHDRAWDEPOSIT"];
    }
    if (self.investIsOpenInSmsButton.selected)
    {
        [openInstationSms addObject:@"INVESTSUCCESS"];
    }
    if (self.refundIsOpenInSmsButton.selected)
    {
        [openInstationSms addObject:@"REFUND"];
    }
    //邮件
    if (self.topupIsOpenEmailButton.selected)
    {
        [openEmail addObject:@"TOPUP"];
    }
    if (self.drawIsOpenEmailButton.selected)
    {
        [openEmail addObject:@"WITHDRAWDEPOSIT"];
    }
    if (self.investIsOpenEmailButton.selected)
    {
        [openEmail addObject:@"INVESTSUCCESS"];
    }
    if (self.refundIsOpenEmailButton.selected)
    {
        [openEmail addObject:@"REFUND"];
    }
    //确认修改
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"数据提交中..."];
    [[ZMServerAPIs shareZMServerAPIs] setMsgSettingsWithOpenSms:openSms andOpenInstaion:openInstationSms andOpenEmail:openEmail Success:^(id response)
     {
         CLog(@"%@",response);
         self.dataDic = [response valueForKey:@"data"];
         dispatch_async(dispatch_get_main_queue(), ^(){
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
             _nextStepButton.enabled = true;
             UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
             [alter show];
         });
     }
     failure:^(id response)
     {
         CLog(@"%@",response);
         NSString *errorMessage = [response valueForKey:@"message"];
         dispatch_async(dispatch_get_main_queue(), ^(){
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
             _nextStepButton.enabled = true;
             UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
             [alter show];
         });
     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//根据数据设置界面选择框状态
- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    NSArray *dataArray = [dataDic valueForKey:@"informconfigs"];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dic,NSUInteger idx, BOOL *stop) {
        if ([[dic valueForKey:@"informOperate"] isEqualToString:@"TOPUP"])
        {
            //充值
            if ([[dic valueForKey:@"isOpenSms"] boolValue])
            {
                self.topupIsOpenSmsButton.selected = YES;
                [self.topupIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                
                self.topupIsOpenSmsButton.selected = NO;
                [self.topupIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenInstationSms"] boolValue])
            {
                self.topupIsOpenInSmsButton.selected = YES;
                [self.topupIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.topupIsOpenInSmsButton.selected = NO;
                [self.topupIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenEmail"] boolValue])
            {
                self.topupIsOpenEmailButton.selected = YES;
                [self.topupIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.topupIsOpenEmailButton.selected = NO;
                [self.topupIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
        }
        else if ([[dic valueForKey:@"informOperate"] isEqualToString:@"WITHDRAWDEPOSIT"])
        {
            //提现
            if ([[dic valueForKey:@"isOpenSms"] boolValue])
            {
                self.drawdIsOpenSmsButton.selected = YES;
                [self.drawdIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.drawdIsOpenSmsButton.selected = NO;
                [self.drawdIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenInstationSms"] boolValue])
            {
                self.drawdIsOpenInSmsButton.selected = YES;
                [self.drawdIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.drawdIsOpenInSmsButton.selected = NO;
                [self.drawdIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenEmail"] boolValue])
            {
                self.drawIsOpenEmailButton.selected = YES;
                [self.drawIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.drawIsOpenEmailButton.selected = NO;
                [self.drawIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
        }
        else if ([[dic valueForKey:@"informOperate"] isEqualToString:@"INVESTSUCCESS"])
        {
            //投资成功
            if ([[dic valueForKey:@"isOpenSms"] boolValue])
            {
                self.investIsOpenSmsButton.selected = YES;
                [self.investIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.investIsOpenSmsButton.selected = NO;
                [self.investIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenInstationSms"] boolValue])
            {
                self.investIsOpenInSmsButton.selected = YES;
                [self.investIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.investIsOpenInSmsButton.selected = NO;
                [self.investIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenEmail"] boolValue])
            {
                self.investIsOpenEmailButton.selected = YES;
                [self.investIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.investIsOpenEmailButton.selected = NO;
                [self.investIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
        }
        else
        {
            //还款
            if ([[dic valueForKey:@"isOpenSms"] boolValue])
            {
                self.refundIsOpenSmsButton.selected = YES;
                [self.refundIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.refundIsOpenSmsButton.selected = NO;
                [self.refundIsOpenSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenInstationSms"] boolValue])
            {
                self.refundIsOpenInSmsButton.selected = YES;
                [self.refundIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.refundIsOpenInSmsButton.selected = NO;
                [self.refundIsOpenInSmsButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
            if ([[dic valueForKey:@"isOpenEmail"] boolValue])
            {
                self.refundIsOpenEmailButton.selected = YES;
                [self.refundIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
            }
            else
            {
                self.refundIsOpenEmailButton.selected = NO;
                [self.refundIsOpenEmailButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
            }
        }
    }];
}

//修改按钮状态
- (void)buttonClicked:(id)sender
{
    UIButton *clickButton = (UIButton *)sender;
    clickButton.selected = !clickButton.selected;
    if (clickButton.isSelected)
    {
        [clickButton setImage:[UIImage imageNamed:@"checkbox_pressed"] forState:UIControlStateSelected];
    }
    else
    {
        [clickButton setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
    }
}
@end
