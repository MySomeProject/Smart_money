//
//  ZMFMDBOperation.h
//  ZMSD
//
//  Created by zima on 14-12-19.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
/**
 *  FMDB数据库操作基类
 */
@interface ZMFMDBOperation : NSObject

@property(strong,nonatomic) FMDatabase *myDatabase;

@property(strong,nonatomic) FMDatabaseQueue *dbQueue;

/**
 *  单例方法
 *
 *  @return 单例对象
 */
+ (instancetype)sharedOperation;
@end
