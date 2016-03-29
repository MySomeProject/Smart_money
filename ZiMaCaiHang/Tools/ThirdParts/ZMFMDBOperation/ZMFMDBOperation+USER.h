//
//  ZMFMDBOperation+USER.h
//  ZMSD
//
//  Created by zima on 14-12-19.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMFMDBOperation.h"
typedef enum{
    k_InfoOperation_Delete = 0,    //移除或者删除了
    k_InfoOperation_Update = 1     //更新数据
}USER_InfoOperationType;


@interface ZMFMDBOperation (USER)

/**
 *  建立USER DB
 */

-(void)createUserDBTable;

//插入记录
-(BOOL)insertSingleSecret:(ZMAdminUserStatusModel *)object;

//更新数据
-(void)updateDatabaseWithUserModel:(ZMAdminUserStatusModel *)object with:(USER_InfoOperationType)operationType;

//读取数据
-(void)readAllDataFromDatabaseSuccess:(void(^)(NSArray *list))success;
@end
