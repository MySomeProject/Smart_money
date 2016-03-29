//
//  ZMAdminUserAssert.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMAdminUserAssert : NSObject

//userPointVO  用户资产
@property (nonatomic, copy) NSDictionary * userPointVO;

//userProfitVo 收益分布
@property (nonatomic, copy) NSDictionary * userProfitVo;

//userInvestVO 投资分布
@property (nonatomic, copy) NSDictionary * userInvestVO;



/*
 {
 "userPointVO":{"amount":10514.89,"availablePoints":8092.65,"waittingPrincipal":2422.24,"frozenPoints":0.0},
 
 "userProfitVo":{"totalAlreadyProfit":16.41,
                 "totalWaitingProfit":560.27,
                 "alreadyProfits":[{"amount":352.5,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
                                   {"amount":207.77,"productName":"PRODUCT","displayProductName":"紫贷宝"}],
 
                 "waittingProfits":[{"amount":352.5,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
                                    {"amount":207.77,"productName":"PRODUCT","displayProductName":"紫贷宝"}]
 },
 
 "userInvestVO":{"amount":6600.0,
                 "invsetAmouts":[{"amount":100.0,"productName":"RIZIBAO","displayProductName":"日紫宝"},
                                 {"amount":4000.0,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
                                 {"amount":2500.0,"productName":"PRODUCT","displayProductName":"紫贷宝"}]
 }
 },
 */

@end
