//
//  MineCenterCell.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "MineCenterCell.h"
#import "AppDelegate.h"
@implementation MineCenterCell

- (void)awakeFromNib {
    [AppDelegate storyBoradAutoLay:self];
}

- (void)setTitleForCell:(NSString *)title
{
    if([UIScreen mainScreen].bounds.size.width==320)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    }
    else if([UIScreen mainScreen].bounds.size.width==375)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    else
    {
        self.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    self.titleLabel.text = title;
    
    if ([title isEqualToString:@"消息中心"])
    {
        [self.messageCountLabel setBackgroundColor:UIColorFromRGB(0xe35242)];
        self.messageCountLabel.layer.masksToBounds = YES;
        self.messageCountLabel.layer.cornerRadius = 10.0;
        [self.messageCountLabel setFont:[UIFont systemFontOfSize:9]];
        [self.messageCountLabel setTextColor:[UIColor whiteColor]];
        [self.messageCountLabel setTextAlignment:NSTextAlignmentCenter];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
