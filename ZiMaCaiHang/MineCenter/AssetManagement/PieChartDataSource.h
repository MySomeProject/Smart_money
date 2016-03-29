//
//  PieChartDataSource.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYPieChart.h"

@interface PieChartDataSource : NSObject<XYPieChartDataSource,XYPieChartDelegate>
@property (nonatomic) NSArray *dataArray;
@end
