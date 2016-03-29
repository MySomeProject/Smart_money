//
//  MineCenterViewController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-17.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPManager.h"

@interface MineCenterViewController : UIViewController<FTPManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hightLayout;

@property(assign,nonatomic) BOOL isClipImage;
@property(strong,nonatomic) UIImage *clipImage;
@property (nonatomic) BOOL isGetFtpInfo;
@property (nonatomic) BOOL isGettingFtpInfo;
@property (nonatomic,strong) FTPManager *ftpManager;
- (IBAction)showRechargeView:(UIButton *)sender;
- (IBAction)showGetCashView:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroView;

@property (weak, nonatomic) IBOutlet UILabel *titleTotalAmount;

@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@property (weak, nonatomic) IBOutlet UILabel *totalAlreadyProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *leiJiLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headBackView;

@end
