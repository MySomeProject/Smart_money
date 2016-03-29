//
//  ZMAdminUserAssert.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ZMAdminUserAssert.h"

@implementation ZMAdminUserAssert
- (id)copyWithZone:(NSZone *)zone {
    ZMAdminUserAssert *copy = [[[self class] allocWithZone:zone] init];
    
    // 拷贝名字给副本对象
    copy.userInvestVO = self.userInvestVO;
    copy.userPointVO = self.userPointVO;
    copy.userProfitVo = self.userProfitVo;
    
    return copy;
}
@end
