//
//  NextStepTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "NextStepTableViewCell.h"

@implementation NextStepTableViewCell
@synthesize nextStepButton = _nextStepButton;

- (void)awakeFromNib {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor clearColor]];
    [self createButton];
    [self setHidden:YES];
    return self;
}

- (void)isHiddenNextButton:(BOOL)isHidden
{
    [_nextStepButton setHidden:isHidden];
}

- (void)createButton
{
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStepButton setFrame:CGRectMake(35, 20, WIDTH_OF_SCREEN - 70, 43)];
//    [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStepButton setTitle:@"充值" forState:UIControlStateNormal];
    
    _nextStepButton.layer.masksToBounds = YES;
    _nextStepButton.layer.cornerRadius = 5.0; //圆角
    
    [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_nextStepButton setBackgroundColor:Color_of_Purple];
    [_nextStepButton addTarget:self action:@selector(showRechargeView:) forControlEvents:UIControlEventTouchUpInside];
    [_nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    [self addSubview:_nextStepButton];
}

- (void)showRechargeView:(UIButton *)sender
{
    if (self.showRechargeBlock)
    {
        self.showRechargeBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
