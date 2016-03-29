//
//  AddBankCardViewController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AddBankCardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL isRealName;
@property (nonatomic, strong) NSDictionary * selectedCityInfo;
@property (nonatomic,assign)BOOL isRechange;
@property(nonatomic, strong)UITableView* tableView;
@end
