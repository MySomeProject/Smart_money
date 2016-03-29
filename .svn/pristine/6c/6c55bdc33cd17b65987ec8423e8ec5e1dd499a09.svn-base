//
//  InvestSuccessViewController.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/7/31.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InvestSuccessViewController.h"
#import "InvestRecoderViewController.h"

@interface InvestSuccessViewController ()

@end

@implementation InvestSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addreturnBtn];
    self.title = @"投资成功";
    // Do any additional setup after loading the view from its nib.
}
-(void)addreturnBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 25);
    [btn setImage:[UIImage imageNamed:@"DetailBackButton"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = returnItem;
}
-(void)returnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finishedBtnClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.investTime.text = self.currentTime;
    self.getMoneyTime.text = self.getCurrentMoneyTime;
    self.investMoney.text = self.currentMoney;
}
@end
