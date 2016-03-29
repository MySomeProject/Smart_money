//
//  ZMFMDBOperation+AdBanner.m
//  ZMSD
//
//  Created by zima on 15-1-14.
//  Copyright (c) 2015年 zima. All rights reserved.
//

#import "ZMFMDBOperation+AdBanner.h"

#define kAdBannerDBTable   @"AdBannerTable"

@implementation ZMFMDBOperation (AdBanner)

-(void)createAdBannerDBTable
{
    //必要数据
    
//    id = 12;
//    bgimg;
//    orderIndex = 2;
//    loanId = "<null>";
//    picUrl =>>>>>>> //前缀
//    url = "about_content.htm?id=20";
    
    
    
//    createTime = "2015-04-15 14:43:10";
//    enabled = 1;
//    new = 0;
//    staffId = 1;
//    type = MOBILE;
//    updateTime = "2015-04-15 16:47:35";
//    version = 1;
    
    NSString *table = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key, bgimg TEXT, url TEXT, loanId integer, orderIndex integer, picUrl TEXT, createTime TEXT, enabled integer, new integer, staffId integer, type TEXT, updateTime TEXT, version integer)", kAdBannerDBTable];
    
    [self.myDatabase executeUpdate:table];
}


-(BOOL)insertSingleAdBanner:(NSDictionary *)adBanner prefix:(NSString *)prefixUrl
{
    NSString *insert = [NSString stringWithFormat:@"insert into %@(id, bgimg, url, loanId, orderIndex, picUrl, createTime, enabled, new, staffId, type, updateTime, version) values('%ld','%@', '%@', '%ld', '%ld', '%@', '%@', '%ld' , '%ld', '%ld', '%@', '%@', '%ld')", kAdBannerDBTable,
                        
                        [[adBanner objectForKey:@"id"] integerValue],
                        
                        [ZMTools isNullObject:[adBanner objectForKey:@"bgimg"]] ? @"" : [adBanner objectForKey:@"bgimg"],
                        [ZMTools isNullObject:[adBanner objectForKey:@"url"]] ? @"" : [adBanner objectForKey:@"url"],
                        [ZMTools isNullObject:[adBanner objectForKey:@"loanId"]] ? -1 : [[adBanner objectForKey:@"loanId"] integerValue],
                        [ZMTools isNullObject:[adBanner objectForKey:@"orderIndex"]] ? -1 : [[adBanner objectForKey:@"orderIndex"] integerValue],
                        
//                        @"http://static.zimacaihang.com/", //picUrl
                        prefixUrl,
                        
                        [ZMTools isNullObject:[adBanner objectForKey:@"createTime"]] ? @"" : [adBanner objectForKey:@"createTime"],
                        [ZMTools isNullObject:[adBanner objectForKey:@"enabled"]] ? -1 : [[adBanner objectForKey:@"enabled"] integerValue],
                        [ZMTools isNullObject:[adBanner objectForKey:@"new"]] ? -1 : [[adBanner objectForKey:@"new"] integerValue],
                        [ZMTools isNullObject:[adBanner objectForKey:@"staffId"]] ? -1 : [[adBanner objectForKey:@"staffId"] integerValue],
                        [ZMTools isNullObject:[adBanner objectForKey:@"type"]] ? @"" : [adBanner objectForKey:@"type"],
                        [ZMTools isNullObject:[adBanner objectForKey:@"updateTime"]] ? @"" : [adBanner objectForKey:@"updateTime"],
                        [ZMTools isNullObject:[adBanner objectForKey:@"version"]] ? 0 : [[adBanner objectForKey:@"version"] integerValue]];
    
    [self.myDatabase executeUpdate:insert];
    
    return YES;
}



//更新数据(清除所有数据／更新所有数据)
-(void)updateDatabaseWithAdBannerInfo:(NSArray *)adBannerArray prefix:(NSString *)prefixUrl with:(AdBanner_InfoOperationType)operationType
{
//    k_AdBannerOperation_Delete = 0,    //移除或者删除了
//    k_AdBannerOperation_Update = 1     //更新数据
    
    
    NSString *update;
    
    //删除所有数据
    if (operationType == k_AdBannerOperation_Delete) {
        
        update = [NSString stringWithFormat:@"delete from %@", kAdBannerDBTable];
        
        [self.myDatabase executeUpdate:update];
    }
    
    
    //更新所有数据
    else if (operationType == k_AdBannerOperation_Update)
    {
        update = [NSString stringWithFormat:@"delete from %@", kAdBannerDBTable];
        
        [self.myDatabase executeUpdate:update];
        
        //先将原来的删除，在插入新的数据（因为必须保持最多一条记录）
        for (int i = 0; i < adBannerArray.count; i++) {
            [self insertSingleAdBanner:[adBannerArray objectAtIndex:i] prefix:prefixUrl];
        }
    }
}


//读取数据
-(void)readAllAdBannersFromDatabaseSuccess:(void(^)(NSArray *list))success
{
    NSString *selectAll;
    
    selectAll  =[NSString stringWithFormat:@"select  * from %@ ORDER BY orderIndex", kAdBannerDBTable];
    
    FMResultSet *selecYears = [self.myDatabase executeQuery:selectAll];
    
    NSMutableArray *list=[[NSMutableArray alloc] init];
    
    while ([selecYears next]) {
        
        //    id = 12;
        //    bgimg;
        //    orderIndex = 2;
        //    loanId = "<null>";
        //    picUrl =>>>>>>> //前缀
        //    url = "about_content.htm?id=20";
        
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        [info setObject:[NSNumber numberWithLong:[selecYears longForColumn:@"id"]] forKey:@"Id"];
        [info setObject:[selecYears stringForColumn:@"bgimg"] forKey:@"bgimg"];
        [info setObject:[selecYears stringForColumn:@"url"] forKey:@"url"];
        [info setObject:[selecYears stringForColumn:@"orderIndex"] forKey:@"orderIndex"];
        [info setObject:[selecYears stringForColumn:@"loanId"] forKey:@"loanId"];
        [info setObject:[selecYears stringForColumn:@"picUrl"] forKey:@"picUrl"];
        
        [list addObject:info];
        
        info=nil;
    }
    
    success(list);
}

@end
