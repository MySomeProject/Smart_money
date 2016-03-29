//
//  MessageViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UITableView *messageTabelView;
@property (strong, nonatomic) IBOutlet UIImageView *messageHeaderView;
@property (nonatomic) NSDictionary *dataDic;
@end
