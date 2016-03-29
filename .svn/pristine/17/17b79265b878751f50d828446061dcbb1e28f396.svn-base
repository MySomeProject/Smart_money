//
//  ZMFMDBOperation.m
//  ZMSD
//
//  Created by zima on 14-12-19.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMFMDBOperation.h"

#import "ZMFMDBOperation+USER.h"
#import "ZMFMDBOperation+AdBanner.h"

#define kDataBaseName @"data.sqlite"

@implementation ZMFMDBOperation

+(instancetype)sharedOperation{
    
    static ZMFMDBOperation *fmdbOperation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdbOperation = [[ZMFMDBOperation alloc] init];
    });
    return fmdbOperation;
}


-(id)init{
    if (self==[super init]) {
        _myDatabase=[FMDatabase databaseWithPath:[self readDb:kDataBaseName]];
        _dbQueue=[FMDatabaseQueue databaseQueueWithPath:[self readDb:kDataBaseName]];
        
        if ([_myDatabase open]) {
            //建立用户表
            [self createUserDBTable];
            //建立广告表
            [self createAdBannerDBTable];
        }
    }
    return self;
}

-(NSString *)readDb:(NSString *)name
{
    BOOL success;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Document=[paths objectAtIndex:0];
    NSString *writeDBPath=[Document stringByAppendingPathComponent:name];
    success = [manager fileExistsAtPath:writeDBPath];
    NSLog(@"%@",writeDBPath);
    if(!success)
    {
        NSString *defaultDBPath=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:name];
        success = [manager copyItemAtPath:defaultDBPath toPath:writeDBPath error:&error];
        //        success =[manager copyItemAtPath:defaultDBPath toPath:writeDBPath error:&error];
        if(!success)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    return writeDBPath;
}

@end
