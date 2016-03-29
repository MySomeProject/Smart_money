//
//  AssetInfoTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetInfoTableViewCell.h"
#import "ZMAdminUserStatusModel.h"

@implementation AssetInfoTableViewCell

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

//创建页面
- (void)createView{
    //总资产
    Heiti15Label *assetTotalTitleLabel = [[Heiti15Label alloc] init];
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [assetTotalTitleLabel setText:@"总 资 产："];
    [assetTotalTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [assetTotalTitleLabel sizeToFit];
    [assetTotalTitleLabel setFrame:CGRectMake(28, 45, assetTotalTitleLabel.frame.size.width, assetTotalTitleLabel.frame.size.height)];
    //可用余额
    Heiti15Label *balanceTtileLabel = [[Heiti15Label alloc] init];
    [balanceTtileLabel setText:@"可用余额："];
    [balanceTtileLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [balanceTtileLabel sizeToFit];
    [balanceTtileLabel setFrame:CGRectMake(28, 75, balanceTtileLabel.frame.size.width, balanceTtileLabel.frame.size.height)];
    //冻结金额
    Heiti15Label *freMoneyTitleLabel = [[Heiti15Label alloc] init];
    [freMoneyTitleLabel setText:@"冻结金额："];
    [freMoneyTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [freMoneyTitleLabel sizeToFit];
    [freMoneyTitleLabel setFrame:CGRectMake(28, 105, freMoneyTitleLabel.frame.size.width, freMoneyTitleLabel.frame.size.height)];
    //待收本金
    Heiti15Label *principalTtileLabel = [[Heiti15Label alloc] init];
    [principalTtileLabel setText:@"待收本金："];
    [principalTtileLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [principalTtileLabel sizeToFit];
    [principalTtileLabel setFrame:CGRectMake(28, 135, principalTtileLabel.frame.size.width, principalTtileLabel.frame.size.height)];
    //总资产金额显示
    _assetTotalLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 45, 120, 60)];
    [_assetTotalLabel setText:@"￥0.00"];
    [_assetTotalLabel setTextColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:125/255.0 alpha:1.0]];
    //可用余额金额显示
    _balanceLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 75, 120, 60)];
    [_balanceLabel setText:@"￥0.00"];
    [_balanceLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    //冻结金额显示
    _freezingMoneyLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 105, 120, 60)];
    [_freezingMoneyLabel setText:@"￥0.00"];
    [_freezingMoneyLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    //待收本金金额显示
    _principalLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 135, 120, 60)];
    [_principalLabel setText:@"￥0.00"];
    [_principalLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    UIImageView *slideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [slideView setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
    //资产详情标题
    UIImage *titleImage = [UIImage imageNamed:@"assetInfo"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 17, titleImage.size.width/2, titleImage.size.height/2)];
    [titleView setImage:titleImage];
    //右侧箭头
    UIImage *arrowImage = [UIImage imageNamed:@"userCenter_cell_arrow"];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - arrowImage.size.width/2 - 10, _balanceLabel.frame.origin.y - 10, arrowImage.size.width/2, arrowImage.size.height/2)];
    [arrowImageView setImage:arrowImage];
    [self addSubview:arrowImageView];
    [self addSubview:titleView];
    [self addSubview:_assetTotalLabel];
    [self addSubview:_balanceLabel];
    [self addSubview:_freezingMoneyLabel];
    [self addSubview:_principalLabel];
    [self addSubview:assetTotalTitleLabel];
    [self addSubview:balanceTtileLabel];
    [self addSubview:freMoneyTitleLabel];
    [self addSubview:principalTtileLabel];
    [self addSubview:slideView];
    [self relayoutLabel];
}

//根据数据设置各控件显示内容
- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userPointVO)
    {
        _assetTotalLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"amount"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"amount"]];
        _balanceLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"availablePoints"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"availablePoints"]];
        _freezingMoneyLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"frozenPoints"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"frozenPoints"]];
        _principalLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"waittingPrincipal"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"waittingPrincipal"]];
        _assetTotalLabel.text = [ZMTools moneyStandardFormatByString:_assetTotalLabel.text withDollarSign:@"￥"];
        _balanceLabel.text = [ZMTools moneyStandardFormatByString:_balanceLabel.text withDollarSign:@"￥"];
        _freezingMoneyLabel.text = [ZMTools moneyStandardFormatByString:_freezingMoneyLabel.text  withDollarSign:@"￥"];
        _principalLabel.text = [ZMTools moneyStandardFormatByString:_principalLabel.text withDollarSign:@"￥"];
        [self relayoutLabel];
    }
}

//重新布局控件位置和大小
- (void)relayoutLabel
{
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [_assetTotalLabel sizeToFit];
    [_assetTotalLabel setFrame:CGRectMake(screeWidth - 70 - _assetTotalLabel.frame.size.width, 45, _assetTotalLabel.frame.size.width, _assetTotalLabel.frame.size.height)];
    [_balanceLabel sizeToFit];
    [_balanceLabel setFrame:CGRectMake(screeWidth - 70 - _balanceLabel.frame.size.width, 75, _balanceLabel.frame.size.width, _balanceLabel.frame.size.height)];
    [_freezingMoneyLabel sizeToFit];
    [_freezingMoneyLabel setFrame:CGRectMake(screeWidth - 70 - _freezingMoneyLabel.frame.size.width, 105, _freezingMoneyLabel.frame.size.width, _freezingMoneyLabel.frame.size.height)];
    [_principalLabel sizeToFit];
    [_principalLabel setFrame:CGRectMake(screeWidth - 70 - _principalLabel.frame.size.width, 135, _principalLabel.frame.size.width, _principalLabel.frame.size.height)];
}
@end
