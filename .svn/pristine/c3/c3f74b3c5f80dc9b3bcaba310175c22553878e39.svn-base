//
//  ZMSafeInputCell.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ZMSafeInputCell.h"
#import "GTCommontHeader.h"
@implementation ZMSafeInputCell

- (void)awakeFromNib {
    for (UIView* view in self.contentView.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
    self.topLine.height = 0.5;
    self.bottomLine.height =0.5;
    self.bottomLongLine.height = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
