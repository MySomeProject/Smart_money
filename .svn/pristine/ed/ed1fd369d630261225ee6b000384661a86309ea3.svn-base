//
//  PieChartDataSource.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "PieChartDataSource.h"

@implementation PieChartDataSource
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
