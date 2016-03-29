//
//  RechargeViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "LLPaySdk.h"

@interface RechargeViewController : UIViewController
{
    UIButton *_nextStepButton;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyRightAlign;
@property (weak, nonatomic) IBOutlet UILabel *moneyRMBFlag;            //人民币¥符号
@property (weak, nonatomic) IBOutlet UITextField *rechargeTextField;   //输入金额

@property (weak, nonatomic) IBOutlet UITextField *cardTextField;

@property (nonatomic, retain) LLPaySdk *sdk;

@property (strong, nonatomic) NSDictionary *selectedBankInfo;   //选中的用户银行卡

@property (nonatomic, assign) BOOL  bVerifyPayState;
@property (nonatomic, assign) BOOL  bPreCardPay;
@property (nonatomic, assign) BOOL  bPayNewCard;
@end
