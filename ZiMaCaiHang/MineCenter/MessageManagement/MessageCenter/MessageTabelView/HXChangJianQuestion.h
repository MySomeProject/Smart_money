//
//  HXChangJianQuestion.h
//  miXin
//
//  Created by HAIXUN on 14-5-22.
//  Copyright (c) 2014年 HAIXUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXChangJianQuestion : UITableViewController<MBProgressHUDDelegate>
{
    UIButton *_settingButton;
}
@property (nonatomic) BOOL isNeedLoad;
@property (nonatomic) BOOL noDataCanLoad;
@property (nonatomic) BOOL isLoading;
@end

@interface questions : NSObject

@property(copy,nonatomic) NSString *messageTitle;
@property(copy,nonatomic) NSString *messageTime;
@property(copy,nonatomic) NSString *messageDescription;
@property(copy,nonatomic) NSString *isReaded;
@property(copy,nonatomic) NSString *messageContent;
@property(assign,nonatomic) BOOL isSelect;
@property(assign,nonatomic) float messageContentHeight;
@property (nonatomic) NSMutableArray *isSelectedArray;

@end