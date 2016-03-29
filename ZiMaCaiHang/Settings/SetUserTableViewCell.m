//
//  SetUserTableViewCell.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "SetUserTableViewCell.h"
#import "GTCommontHeader.h"

@implementation SetUserTableViewCell

- (void)awakeFromNib {
    for (UIView* view in self.contentView.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
    self.userImg.layer.cornerRadius = GTFixHeightFlaot(20);
    self.userImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
