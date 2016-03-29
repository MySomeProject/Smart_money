//
//  IncomeDistributeTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Heiti15Label.h"
#import "ZMAdminUserStatusModel.h"

@interface IncomeDistributeTableViewCell : UITableViewCell{
    Heiti15Label *_accumulatedEarningsLabel;
    Heiti15Label *_waitCollectedLabel;
}
@property (nonatomic) ZMAdminUserStatusModel *dataModel;
- (void)setValueByModel;
@end
