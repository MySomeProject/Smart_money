//
//  InvestRecoserCell.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InvestRecoserCell.h"
#import "InvestRecoderModel.h"
#import "AppDelegate.h"
@implementation InvestRecoserCell

- (void)awakeFromNib {
    [AppDelegate storyBoradAutoLay:self];
}
- (void)setModel:(InvestRecoderModel *)model
{
    _model = model;
    self.productCode.text  = model.productCode;
    self.lendAmount.text   = [NSString stringWithFormat:@"%.2f",model.lendAmount];
    self.YJSYLable.text    = [NSString stringWithFormat:@"%.2f",model.revenue];
    self.SYLLable.text     = [NSString stringWithFormat:@"%.1f%%",model.interest];
    self.dueTimeLable.text = model.dueDate;
    self.lendTime.text     = model.lendTime;
    self.imgView.image     = [UIImage imageNamed:model.imgName];
    self.backMoneyStyle.text = model.backMoneyStyle;
}
@end
