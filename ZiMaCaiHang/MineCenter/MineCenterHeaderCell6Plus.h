//
//  MineCenterHeaderCell6Plus.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ModifyHeaderOrUserInfoBlock)();


@protocol cellDelegate <NSObject>

- (void)refreshTableView;

@end


@interface MineCenterHeaderCell6Plus : UITableViewCell

@property(copy,nonatomic) ModifyHeaderOrUserInfoBlock modifyHeaderOrUserInfoBlock;
@property (nonatomic,assign) id<cellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *agentIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *idCardValidateBtn;
@property (weak, nonatomic) IBOutlet UIButton *mobileValidateBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailValidateBtn;
//  待收本金
@property (weak, nonatomic) IBOutlet UILabel *collectedMoney;


//  冻结余额
@property (weak, nonatomic) IBOutlet UILabel *freezeMoney;


@property (weak, nonatomic) IBOutlet UILabel *amountLabel;   //总额
@property (weak, nonatomic) IBOutlet UILabel *availablePointsLabel;//余额
@property (weak, nonatomic) IBOutlet UILabel *totalWaitingProfitLabel;//待收收益
@property (weak, nonatomic) IBOutlet UILabel *totalAlreadyProfitLabel;  //累计收益
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn; //  充值
@property (weak, nonatomic) IBOutlet UIButton *getCashBtn;  //  提现
@property (weak, nonatomic) IBOutlet UILabel *lastCash;
//改版的
@property (weak, nonatomic) IBOutlet UIImageView *headBcakView;

@property (weak, nonatomic) IBOutlet UIView *botomView;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChangeHiegh;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headbackViewHegih;


//amount = "251529.38";
//availablePoints = 0;
//frozenPoints = 99018;
//waittingPrincipal = "152511.38";


- (IBAction)modifyHeaderOrUserInfo;
@end
