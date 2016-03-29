//
//  SetotherTableViewCell.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "SetotherTableViewCell.h"
#import "GTCommontHeader.h"
@implementation SetotherTableViewCell

- (void)awakeFromNib {
    for (UIView* view in self.contentView.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
