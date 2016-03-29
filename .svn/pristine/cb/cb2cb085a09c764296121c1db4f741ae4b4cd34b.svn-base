//
//  BackCashModel.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BackCashModel.h"

@implementation BackCashModel
- (id)initModelDictiony:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.repayDate =  dict[@"repayDate"];
        NSString *title ;
//        if([dict[@"productName"] isEqualToString:@"体验标"])
//        {
//           title = [NSString stringWithFormat:@"财行加%@",dict[@"code"]];
//        }
//        else if([dict[@"productName"] isEqualToString:@"专享标"])
//        {
//            title = [NSString stringWithFormat:@"财月盈%@",dict[@"code"]];
//        }
//        else if([dict[@"productName"] isEqualToString:@"活期标"])
//        {
//            title = @"财行宝";
//        }
//        else
//            title = @"";
        title  = [NSString stringWithFormat:@"%@%@",dict[@"loanTitle"],dict[@"code"]];
        self.loanTitle = title;
        if([ZMTools isNullObject:dict[@"repayPrincipal"]]==YES)
        {
            self.totalLendAmount =  [dict[@"repayInterest"] doubleValue];
            self.Moneystyle = @"收益";
        }
        else
        {
            self.totalLendAmount =  [dict[@"repayPrincipal"] doubleValue];
            self.Moneystyle = @"本金";
        }
    }
    return self;
}

@end
