//
//  ZMFMDBOperation+USER.m
//  ZMSD
//
//  Created by zima on 14-12-19.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMFMDBOperation+USER.h"


#define kUserDBTable @"UserTable"

@implementation ZMFMDBOperation (USER)


-(void)createUserDBTable
{
    NSString *table = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key, nickName TEXT, headImage TEXT, allowBorrow INTEGER, userInfoFinished INTEGER, mobileValidated INTEGER, allowLend INTEGER, enable INTEGER, idCardValidated INTEGER,  receivingPrincipal REAL, frozenPoints REAL,  totalScores REAL, availablePoints REAL, receivedPoints REAL, receivingPoints REAL, totalPoints REAL)", kUserDBTable];
    
    [self.myDatabase executeUpdate:table];
}


-(BOOL)insertSingleSecret:(ZMAdminUserStatusModel *)object
{
    NSString *insert = [NSString stringWithFormat:@"insert into %@(id, nickName, headImage, allowBorrow, userInfoFinished, mobileValidated, allowLend, enable, idCardValidated, receivingPrincipal, frozenPoints, totalScores, availablePoints REAL, receivedPoints REAL, receivingPoints REAL, totalPoints) values('%ld','%@', '%@','%d','%d','%d','%d','%d','%d', '%f', '%f','%f','%f', '%f','%f','%f')", kUserDBTable,
                        object.userId, object.nickName, object.headImage, object.allowBorrow, object.userInfoFinished, object.mobileValidated, object.allowLend, object.enable, object.idCardValidated,
                        object.receivingPrincipal, object.frozenPoints, object.availablePoints,
                        object.receivedPoints, object.receivingPoints, object.totalPoints, object.totalScores];
    
    [self.myDatabase executeUpdate:insert];
    
    return YES;
}



//更新数据
-(void)updateDatabaseWithUserModel:(ZMAdminUserStatusModel *)object with:(USER_InfoOperationType)operationType
{
    //k_InfoOperation_Delete = 0,    //移除或者删除了
    //k_InfoOperation_Update = 1     //更新数据
    
    NSString *update;
    
    //删除
    if (operationType == k_InfoOperation_Delete) {
        
        update = [NSString stringWithFormat:@"delete from %@ where id ='%ld'",kUserDBTable, object.userId];
        
        [self.myDatabase executeUpdate:update];
    }
    
    
    //更新
    else if (operationType == k_InfoOperation_Update)
    {
        update = [NSString stringWithFormat:@"delete from %@ where id ='%ld'",kUserDBTable, object.userId];
        
        [self.myDatabase executeUpdate:update];
        
        //先将原来的删除，在插入新的数据（因为必须保持最多一条记录）
        [self insertSingleSecret:object];
    }
}


//读取数据
-(void)readAllDataFromDatabaseSuccess:(void(^)(NSArray *list))success
{
    NSString *selectAll;
    
    selectAll  =[NSString stringWithFormat:@"select  * from %@ ORDER BY CreateDate DESC", kUserDBTable];
    
    FMResultSet *selecYears = [self.myDatabase executeQuery:selectAll];
    
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([selecYears next]) {
        
        CLog(@" 读取 用户数据   =====   %@", selecYears);
        
        ZMAdminUserStatusModel *info = [[ZMAdminUserStatusModel alloc] init];
        /*
         id, nickName, headImage,
         allowBorrow, userInfoFinished, mobileValidated, allowLend, enable, idCardValidated,
         receivingPrincipal, frozenPoints, totalScores, availablePoints REAL, receivedPoints REAL, receivingPoints REAL, totalPoints
         */
        
        info.userId = [selecYears longForColumn:@"id"];
        info.nickName = [selecYears stringForColumn:@"nickName"];
        info.headImage = [selecYears stringForColumn:@"headImage"];
        
        info.allowBorrow = [selecYears boolForColumn:@"allowBorrow"];
        info.userInfoFinished = [selecYears boolForColumn:@"userInfoFinished"];
        info.mobileValidated = [selecYears boolForColumn:@"mobileValidated"];
        info.allowLend = [selecYears boolForColumn:@"allowLend"];
        info.enable = [selecYears boolForColumn:@"enable"];
        info.idCardValidated = [selecYears boolForColumn:@"idCardValidated"];
        
        
        info.receivingPrincipal = [selecYears doubleForColumn:@"receivingPrincipal"];
        info.frozenPoints = [selecYears doubleForColumn:@"frozenPoints"];
        info.availablePoints = [selecYears doubleForColumn:@"availablePoints"];
        info.receivedPoints = [selecYears doubleForColumn:@"receivedPoints"];
        info.receivingPoints = [selecYears doubleForColumn:@"receivingPoints"];
        info.totalPoints = [selecYears doubleForColumn:@"totalPoints"];
        info.totalScores = [selecYears doubleForColumn:@"totalScores"];
        
        [list addObject:info];
        
        info=nil;
    }
    
    success(list);
}


@end
