//
//  BackCashCell.h
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BackCashModel;
@interface BackCashCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *loanTitle;
@property (weak, nonatomic) IBOutlet UILabel *realyRepayDate;
@property (weak, nonatomic) IBOutlet UILabel *totalLendAmount;
@property (weak, nonatomic) IBOutlet UILabel *repayPrincipalAndInterest;
@property (weak, nonatomic) IBOutlet UILabel *repayDate;
@property (weak, nonatomic) IBOutlet UILabel *phaseNumber;
@property (weak, nonatomic) IBOutlet UIImageView *RadioImage;
@property (weak, nonatomic) IBOutlet UILabel *BJAndLX;
@property (nonatomic,strong)BackCashModel *model;
@end
