//
//  MineRewardViewController.h
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/8/25.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MineRewardViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *allRedMoney;
@property (weak, nonatomic) IBOutlet UILabel *redNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *handGood;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *handLabel;



@end
