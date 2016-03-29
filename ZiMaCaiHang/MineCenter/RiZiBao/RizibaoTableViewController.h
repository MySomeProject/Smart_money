//
//  rizibaoTableViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RizibaoTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
- (IBAction)textFiledReturnEditing:(id)sender;
@end
