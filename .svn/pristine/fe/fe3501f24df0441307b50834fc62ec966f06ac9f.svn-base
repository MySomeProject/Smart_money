//
//  AssetManagementViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetInfoTableViewCell.h"
#import "AssetDistributeTableViewCell.h"
#import "IncomeDistributeTableViewCell.h"
#import "AssetInfoViewController.h"
#import "IncomeViewController.h"
#import "AssetDisTableViewController.h"
@class ZMAdminUserStatusModel;
@interface AssetManagementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView *_assetManagementTabelView;
    AssetInfoTableViewCell *_assetInfoTableViewCell;
    AssetDistributeTableViewCell *_assetDistributeTableViewCell;
    IncomeDistributeTableViewCell *_incomeDistributeTableViewCell;
}
@property (nonatomic,strong) IncomeViewController *incomeViewController;
@property (nonatomic,strong) AssetInfoViewController *assetInfoViewController;
@property (nonatomic,strong) AssetDisTableViewController *assetDisTableViewController;
@property (nonatomic) NSArray *dataArray;
@end
