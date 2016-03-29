//
//  ModifyPasswordController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPasswordController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>
@property(nonatomic, strong)UITableView* tableView;
@end
