//
//  CashHistoryCell.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "CashHistoryCell.h"
#import "AppDelegate.h"
#import "CashHistoryModel.h"
@implementation CashHistoryCell

- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CashHistoryModel *)model
{
    _model = model;
    self.rechargeType.text = model.rechargeType;
    self.transAmout.textColor = [UIColor redColor];
    self.transAmout.text = model.transAmout;
    self.capitalStatus.text = model.capitalStatus;
    self.transAmout.textColor = UIColorFromRGB(model.colour);
    self.create_time.text = model.create_time;
}

@end
