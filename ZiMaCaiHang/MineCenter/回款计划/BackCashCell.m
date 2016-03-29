//
//  BackCashCell.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BackCashCell.h"
#import "BackCashModel.h"
#import "AppDelegate.h"
@implementation BackCashCell

- (void)awakeFromNib {
    [AppDelegate storyBoradAutoLay:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BackCashModel *)model
{
    _model = model;
    self.loanTitle.text = model.loanTitle;
    self.repayPrincipalAndInterest.text = [NSString stringWithFormat:@"%.2f",model.repayInterest];
    self.repayDate.text = model.repayDate;
     self.BJAndLX.text = model.Moneystyle;
    if([model.Moneystyle isEqualToString:@"本金"])
    {
        self.totalLendAmount.textColor = [UIColor darkGrayColor];
    }
    else
    {
        self.totalLendAmount.textColor = [UIColor redColor];
    }
    self.totalLendAmount.text = [NSString stringWithFormat:@"%.2f",model.totalLendAmount]  ;
    self.realyRepayDate.text = model.realyRepayDate;
    self.phaseNumber.text = [NSString stringWithFormat:@"%d",model.phaseNumber];
   

}
@end
