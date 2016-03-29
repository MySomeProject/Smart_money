//
//  AssetInfoViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Heiti15Label.h"
#import "XYPieChart.h"

@interface AssetInfoViewController : UIViewController<XYPieChartDelegate, XYPieChartDataSource>
@property (strong, nonatomic) IBOutlet XYPieChart *assetChart;
@property (strong, nonatomic) IBOutlet Heiti15Label *allAssetTitleLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *balanceTitleLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *freMoneyTitleLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *principalTtileLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *allAssetLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *balanceLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *freMoneyLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *principalLabel;
@property (strong, nonatomic) IBOutlet Heiti15Label *allAssetTipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *tip6ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *tip45ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *tip6pImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *assetScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *slideLine1;
@property (strong, nonatomic) IBOutlet UIImageView *slideLine2;
@property (strong, nonatomic) IBOutlet UIImageView *slideLine3;
@property (strong, nonatomic) IBOutlet UIImageView *slideLine4;
@property (nonatomic) ZMAdminUserStatusModel *dataModel;

@property (nonatomic) NSArray *dataArray;
@end
