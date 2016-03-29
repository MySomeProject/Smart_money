//
//  AboutUsModel.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/28.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutUsModel : NSObject
@property(copy,nonatomic) NSString *mainTitle;
@property(copy,nonatomic) NSString *secondTitle;
@property(copy,nonatomic) NSString *contentBeforeExpand;
@property(copy,nonatomic) NSString *contentAfterExpand;
@property(assign,nonatomic) BOOL isSelect;
@property(assign,nonatomic) float contentBeforeHeight;
@property(assign,nonatomic) float contentAfterHeight;
@end
