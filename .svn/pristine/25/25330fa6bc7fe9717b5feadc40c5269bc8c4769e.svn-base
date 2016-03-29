//
//  BankCardInfoCell.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftBankTypeLogo;  //银行卡logo
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;         //银行名称
@property (weak, nonatomic) IBOutlet UILabel *bankNumberLabel;       //银行卡号


@property (nonatomic, weak) IBOutlet UIImageView *topLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLongLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLongBottomSpace;


@property (nonatomic, assign) BOOL isForRechargeMoney;              //是否是充值页面用。
@property (strong, nonatomic) IBOutlet UIImageView *selectedImage;  //对勾

- (void)showSelectedImage;
@end
