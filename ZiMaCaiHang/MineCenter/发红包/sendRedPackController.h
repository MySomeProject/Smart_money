//
//  sendRedPackController.h
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/10/14.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface sendRedPackController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *allRedEnvelopeLabel;

@property (weak, nonatomic) IBOutlet UILabel *receiveRedEnvelopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIView *smallView;

@end
