//
//  CashHistoryModel.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "CashHistoryModel.h"

@implementation CashHistoryModel
- (id)initModelDictiony:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.create_time =  dict[@"create_time"];
        self.transAmout =  dict[@"transAmout"];
        self.rechargeType =  dict[@"rechargeType"];
        self.capitalStatus =  dict[@"capitalStatus"];
        self.colour = [dict[@"colour"] intValue];
        
    }
    return self;
}

@end
