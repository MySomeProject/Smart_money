//
//  InvestRecoderModel.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InvestRecoderModel.h"

@implementation InvestRecoderModel

- (InvestRecoderModel *)modelWithDict:(NSDictionary *)dict
{
    InvestRecoderModel *model = [[InvestRecoderModel alloc]init];
    [model setKeyValues:dict];
    return model;
}
- (id)initModelDictiony:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.productType =  dict[@"productType"];
        self.lendAmount  =  [dict[@"lendAmount"] doubleValue];
        self.interest   =  [dict[@"interest"] doubleValue];
        
        self.productCode = [NSString stringWithFormat:@"%@%@",dict[@"loanTitle"],dict [@"productCode"]];
        self.lendTime       =  [ZMTools formattingDateString:dict[@"lendTime"]]  ;
        self.dueDate        =  [ZMTools formattingDateString: dict[@"dueDate"]];
        self.backMoneyStyle =  @"一次性还本付息";
        self.revenue        =  fabs([dict[@"revenue"] doubleValue])  ;
        self.loanId =[NSString stringWithFormat:@"%@",dict[@"id"]];
    }
    return self;
}
@end
