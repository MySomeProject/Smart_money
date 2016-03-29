//
//  AssetDistributeTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetDistributeTableViewCell.h"

@implementation AssetDistributeTableViewCell

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
    //累计投资总额标题
    Heiti15Label *investmentTitleLabel = [[Heiti15Label alloc] init];
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [investmentTitleLabel setText:@"累计投资总额："];
    [investmentTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [investmentTitleLabel sizeToFit];
    [investmentTitleLabel setFrame:CGRectMake(28, 45, investmentTitleLabel.frame.size.width, investmentTitleLabel.frame.size.height)];
    //日紫宝标题
    Heiti15Label *rizibaoTitleLabel = [[Heiti15Label alloc] init];
    [rizibaoTitleLabel setText:@"日紫宝："];
    [rizibaoTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [rizibaoTitleLabel sizeToFit];
    [rizibaoTitleLabel setFrame:CGRectMake(28, 75, rizibaoTitleLabel.frame.size.width, rizibaoTitleLabel.frame.size.height)];
    //紫定盈标题
    Heiti15Label *zidingyingTitleLabel = [[Heiti15Label alloc] init];
    [zidingyingTitleLabel setText:@"紫定盈："];
    [zidingyingTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [zidingyingTitleLabel sizeToFit];
    [zidingyingTitleLabel setFrame:CGRectMake(28, 105, zidingyingTitleLabel.frame.size.width, zidingyingTitleLabel.frame.size.height)];
    //紫贷宝标题
    Heiti15Label *zidaibaoTitleLabel = [[Heiti15Label alloc] init];
    [zidaibaoTitleLabel setText:@"紫贷宝："];
    [zidaibaoTitleLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    [zidaibaoTitleLabel sizeToFit];
    [zidaibaoTitleLabel setFrame:CGRectMake(28, 135, zidaibaoTitleLabel.frame.size.width, zidaibaoTitleLabel.frame.size.height)];
    //累计投资总额金额显示
    _investmentLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 45, 120, 60)];
    [_investmentLabel setText:@"￥0.00"];
    [_investmentLabel setTextColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:125/255.0 alpha:1.0]];
    //日紫宝金额显示
    _rizibaoLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 75, 120, 60)];
    [_rizibaoLabel setText:@"￥0.00"];
    [_rizibaoLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    //紫定盈金额显示
    _zidingyingLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 105, 120, 60)];
    [_zidingyingLabel setText:@"￥0.00"];
    [_zidingyingLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    //紫贷宝金额显示
    _zidaibaoLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(screeWidth - 70, 135, 120, 60)];
    [_zidaibaoLabel setText:@"￥0.00"];
    [_zidaibaoLabel setTextColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]];
    UIImageView *slideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [slideView setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
    //投资分布标题
    UIImage *titleImage = [UIImage imageNamed:@"assetDis"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 17, titleImage.size.width/2, titleImage.size.height/2)];
    [titleView setImage:titleImage];
    //右侧按钮
    UIImage *arrowImage = [UIImage imageNamed:@"userCenter_cell_arrow"];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - arrowImage.size.width/2 - 10, _rizibaoLabel.frame.origin.y - 10, arrowImage.size.width/2, arrowImage.size.height/2)];
    [arrowImageView setImage:arrowImage];
    [self addSubview:arrowImageView];
    [self addSubview:titleView];
    [self addSubview:_investmentLabel];
    [self addSubview:_rizibaoLabel];
    [self addSubview:_zidingyingLabel];
    [self addSubview:_zidaibaoLabel];
    [self addSubview:investmentTitleLabel];
    [self addSubview:rizibaoTitleLabel];
    [self addSubview:zidingyingTitleLabel];
    [self addSubview:zidaibaoTitleLabel];
    [self addSubview:slideView];
    [self relayoutLabel];
}

//根据数据设置控件显示内容
- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userInvestVO)
    {
        _investmentLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userInvestVO valueForKey:@"amount"]]?@"0.00":[_dataModel.adminUserAssert.userInvestVO valueForKey:@"amount"]];
        _investmentLabel.text = [ZMTools moneyStandardFormatByString:_investmentLabel.text withDollarSign:@"￥"];
        NSArray *productArray = [_dataModel.adminUserAssert.userInvestVO valueForKey:@"invsetAmouts"];
        for (int i = 0; i < [productArray count]; i++)
        {
            if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"RIZIBAO"])
            {
                //日紫宝
                _rizibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _rizibaoLabel.text = [ZMTools moneyStandardFormatByString:_rizibaoLabel.text withDollarSign:@"￥"];
            }
            else if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"INVEST_PRODUCT"])
            {
                //紫定盈
                _zidingyingLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _zidingyingLabel.text = [ZMTools moneyStandardFormatByString:_zidingyingLabel.text withDollarSign:@"￥"];
            }
            else
            {
                //紫贷宝
                _zidaibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _zidaibaoLabel.text = [ZMTools moneyStandardFormatByString:_zidaibaoLabel.text withDollarSign:@"￥"];
            }
        }
        [self relayoutLabel];
    }
}
//重新布局各控件大小和位置
- (void)relayoutLabel
{
    [_investmentLabel sizeToFit];
    CGFloat screeWidth = [UIScreen mainScreen].bounds.size.width;
    [_investmentLabel setFrame:CGRectMake(screeWidth - 70 - _investmentLabel.frame.size.width, 45, _investmentLabel.frame.size.width, _investmentLabel.frame.size.height)];
    [_rizibaoLabel sizeToFit];
    [_rizibaoLabel setFrame:CGRectMake(screeWidth - 70 - _rizibaoLabel.frame.size.width, 75, _rizibaoLabel.frame.size.width, _rizibaoLabel.frame.size.height)];
    [_zidingyingLabel sizeToFit];
    [_zidingyingLabel setFrame:CGRectMake(screeWidth - 70 - _zidingyingLabel.frame.size.width, 105, _zidingyingLabel.frame.size.width, _zidingyingLabel.frame.size.height)];
    [_zidaibaoLabel sizeToFit];
    [_zidaibaoLabel setFrame:CGRectMake(screeWidth - 70 - _zidaibaoLabel.frame.size.width, 135, _zidaibaoLabel.frame.size.width, _zidaibaoLabel.frame.size.height)];
}

@end
