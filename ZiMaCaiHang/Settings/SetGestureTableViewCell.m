//
//  SetGestureTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "SetGestureTableViewCell.h"

@interface SetGestureTableViewCell()

@end

@implementation SetGestureTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self addSwitchButton];
}

////成功的回调
//- (void)setTarget:(id)target withAction:(SEL)action
//{
//    [switchButton addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
//}

- (void)addSwitchButton
{
    self.switchButton = [[SevenSwitch alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - 75, 21, 50, 30)];
    self.switchButton.center = CGPointMake(self.switchButton.frame.origin.x + 25, self.switchButton.frame.origin.y + 15);
    self.switchButton.onColor = [UIColor colorWithRed:114/225.0 green:98/255.0 blue:169/255.0 alpha:1.00f];
    [self addSubview:self.switchButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
