//
//  IncomeDistributeTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "IncomeDistributeTableViewCell.h"

@implementation IncomeDistributeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setValueByModel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//创建界面
- (void)createView{
    //累计收益总额标题
    Heiti15Label *accumulatedEarnTitleLabel = [[Heiti15Label alloc] init];
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [accumulatedEarnTitleLabel setText:@"累计收益总额："];
    [accumulatedEarnTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [accumulatedEarnTitleLabel sizeToFit];
    [accumulatedEarnTitleLabel setFrame:CGRectMake(28, 45, accumulatedEarnTitleLabel.frame.size.width, accumulatedEarnTitleLabel.frame.size.height)];
    //等待收益总额标题
    Heiti15Label *waitCollectedTitleLabel = [[Heiti15Label alloc] init];
    [waitCollectedTitleLabel setText:@"待收收益总额："];
    [waitCollectedTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [waitCollectedTitleLabel sizeToFit];
    [waitCollectedTitleLabel setFrame:CGRectMake(28, 75, waitCollectedTitleLabel.frame.size.width, waitCollectedTitleLabel.frame.size.height)];
    //累计收益总额显示
    _accumulatedEarningsLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 45, 120, 60)];
    [_accumulatedEarningsLabel setText:@"￥0.00"];
    [_accumulatedEarningsLabel setTextColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:125/255.0 alpha:1.0]];
    //等待收益金额显示
    _waitCollectedLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 75, 120, 60)];
    [_waitCollectedLabel setText:@"￥0.00"];
    [_waitCollectedLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    UIImageView *slideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [slideView setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
    //收益分布标题
    UIImage *titleImage = [UIImage imageNamed:@"incomeDis"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 17, titleImage.size.width/2, titleImage.size.height/2)];
    [titleView setImage:titleImage];
    //右侧箭头
    UIImage *arrowImage = [UIImage imageNamed:@"userCenter_cell_arrow"];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - arrowImage.size.width/2 - 10, _accumulatedEarningsLabel.frame.origin.y - 10, arrowImage.size.width/2, arrowImage.size.height/2)];
    [arrowImageView setImage:arrowImage];
    [self addSubview:arrowImageView];
    [self addSubview:titleView];
    [self addSubview:_accumulatedEarningsLabel];
    [self addSubview:_waitCollectedLabel];
    [self addSubview:accumulatedEarnTitleLabel];
    [self addSubview:waitCollectedTitleLabel];
    [self addSubview:slideView];
    [self relayoutLabel];
}

//根据数据设置控件显示内容
- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userProfitVo)
    {
        _accumulatedEarningsLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalAlreadyProfit"]]?@"0.00":[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalAlreadyProfit"]];
        _accumulatedEarningsLabel.text = [ZMTools moneyStandardFormatByString:_accumulatedEarningsLabel.text withDollarSign:@"￥"];
        _waitCollectedLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalWaitingProfit"]]?@"0.00":[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalWaitingProfit"]];
        _waitCollectedLabel.text = [ZMTools moneyStandardFormatByString:_waitCollectedLabel.text withDollarSign:@"￥"];
        [self relayoutLabel];
    }
}

//重新设置控件大小和位置
- (void)relayoutLabel
{
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [_accumulatedEarningsLabel sizeToFit];
    [_accumulatedEarningsLabel setFrame:CGRectMake(screeWidth - 70 - _accumulatedEarningsLabel.frame.size.width, 45, _accumulatedEarningsLabel.frame.size.width, _accumulatedEarningsLabel.frame.size.height)];
    [_waitCollectedLabel sizeToFit];
    [_waitCollectedLabel setFrame:CGRectMake(screeWidth - 70 - _waitCollectedLabel.frame.size.width, 75, _waitCollectedLabel.frame.size.width, _waitCollectedLabel.frame.size.height)];
}

@end
