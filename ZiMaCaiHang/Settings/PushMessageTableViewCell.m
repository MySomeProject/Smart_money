//
//  PushMessageTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "PushMessageTableViewCell.h"
#import "SevenSwitch.h"

@implementation PushMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self addSwitchButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)addSwitchButton
{
    SevenSwitch *switchButton = [[SevenSwitch alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - 75, 21, 50, 30)];
    switchButton.center = CGPointMake(switchButton.frame.origin.x + 25, switchButton.frame.origin.y + 15);
    switchButton.onColor = [UIColor colorWithRed:114/225.0 green:98/255.0 blue:169/255.0 alpha:1.00f];
    [self addSubview:switchButton];
}
@end
