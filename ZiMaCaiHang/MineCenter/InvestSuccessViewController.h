//
//  InvestSuccessViewController.h
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/7/31.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestSuccessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *investMoney;
@property (weak, nonatomic) IBOutlet UILabel *investTime;
@property (weak, nonatomic) IBOutlet UILabel *getMoneyTime;
@property (strong,nonatomic)NSString *currentMoney;
@property (strong,nonatomic)NSString *currentTime;
@property (strong,nonatomic)NSString *getCurrentMoneyTime;

@property (strong,nonatomic)NSString *productType;
@end
