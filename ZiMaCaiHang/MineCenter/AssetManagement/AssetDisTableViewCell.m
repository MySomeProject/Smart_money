//
//  AssetDisTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetDisTableViewCell.h"

@implementation AssetDisTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self createChart];
    [self setValueByModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createChart
{
    self.dataArray = [NSArray arrayWithObjects:@13,@37,@50,nil];
    [self.assetDisChart setDataSource:self];
    [self.assetDisChart setDelegate:self];
    [self.assetDisChart setStartPieAngle:M_PI_2];
    [self.assetDisChart setAnimationSpeed:1.0];
    [self.assetDisChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.assetDisChart setLabelRadius:self.assetDisChart.frame.size.width];
    [self.assetDisChart setShowPercentage:NO];
    [self.assetDisChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.assetDisChart setPieCenter:CGPointMake(self.assetDisChart.frame.size.width/2.0, self.assetDisChart.frame.size.width/2)];
    [self.assetDisChart setUserInteractionEnabled:NO];
    [self.chartLabel.layer setCornerRadius:self.assetDisChart.frame.size.width/3.0];
    [self.assetDisChart reloadData];
}

- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userInvestVO)
    {
        _investmentLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userInvestVO valueForKey:@"amount"]]?@"0.00":[_dataModel.adminUserAssert.userInvestVO valueForKey:@"amount"]];
        _investmentLabel.text = [ZMTools moneyStandardFormatByString:_investmentLabel.text withDollarSign:@"￥"];
        NSArray *productArray = [_dataModel.adminUserAssert.userInvestVO valueForKey:@"invsetAmouts"];
        NSNumber *rizibaoNumber;
        NSNumber *zidingyingNumber;
        NSNumber *zidaibaoNumber;
        for (int i = 0; i < [productArray count]; i++)
        {
            if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"RIZIBAO"])
            {
                //日紫宝
                _rizibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _rizibaoLabel.text = [ZMTools moneyStandardFormatByString:_rizibaoLabel.text withDollarSign:@"￥"];
                rizibaoNumber = [productArray[i] valueForKey:@"amount"];
            }
            else if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"INVEST_PRODUCT"])
            {
                //紫定盈
                _zidingyingLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _zidingyingLabel.text = [ZMTools moneyStandardFormatByString:_zidingyingLabel.text withDollarSign:@"￥"];
                zidingyingNumber = [productArray[i] valueForKey:@"amount"];
            }
            else
            {
                //紫贷宝
                _zidaibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
                _zidaibaoLabel.text = [ZMTools moneyStandardFormatByString:_zidaibaoLabel.text withDollarSign:@"￥"];
                zidaibaoNumber = [productArray[i] valueForKey:@"amount"];
            }
        }
        if (![ZMAdminUserStatusModel isNullObject:rizibaoNumber]&&![ZMAdminUserStatusModel isNullObject:zidingyingNumber]&&![ZMAdminUserStatusModel isNullObject:zidaibaoNumber])
        {
            self.dataArray = [NSArray arrayWithObjects:rizibaoNumber,zidingyingNumber,zidaibaoNumber,nil];
            [self.assetDisChart reloadData];
            self.chartLabel.text = self.investmentLabel.text;
        }

    }
}

#pragma mark - AssetChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [self.dataArray count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [self.dataArray[index] doubleValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if (index == 0)
    {
        return [UIColor colorWithRed:107/255.0 green:205/255.0 blue:224/255.0 alpha:1.0];
    }
    else if (index == 1)
    {
        return [UIColor colorWithRed:248/255.0 green:189/255.0 blue:106/255.0 alpha:1.0];
    }
    else
    {
        return [UIColor colorWithRed:245/255.0 green:90/255.0 blue:94/255.0 alpha:1.0];
    }
}

#pragma mark - AssetChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    CLog(@"click chart");
}

@end
