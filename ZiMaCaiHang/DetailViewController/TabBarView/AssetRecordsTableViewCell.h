//
//  AssetRecordsTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/5/12.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetRecordsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetTimeLabel;

@property (nonatomic) NSDictionary *dataDic;  //紫定盈的记录

@property (nonatomic) NSDictionary *riZiBaoDataDic;  //紫定盈的记录
@end
