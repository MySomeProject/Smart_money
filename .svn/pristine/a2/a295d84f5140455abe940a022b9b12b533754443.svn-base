//
//  ZMFMDBOperation+AdBanner.h
//  ZMSD
//
//  Created by zima on 15-1-14.
//  Copyright (c) 2015年 zima. All rights reserved.
//

#import "ZMFMDBOperation.h"
typedef enum{
    k_AdBannerOperation_Delete = 0,    //移除或者删除了
    k_AdBannerOperation_Update = 1     //更新数据
}AdBanner_InfoOperationType;

@interface ZMFMDBOperation (AdBanner)

-(void)createAdBannerDBTable;

//插入记录
-(BOOL)insertSingleAdBanner:(NSDictionary *)adBanner prefix:(NSString *)prefixUrl;

//更新数据
-(void)updateDatabaseWithAdBannerInfo:(NSArray *)adBannerArray prefix:(NSString *)prefixUrl with:(AdBanner_InfoOperationType)operationType;

//读取数据
-(void)readAllAdBannersFromDatabaseSuccess:(void(^)(NSArray *list))success;
@end
