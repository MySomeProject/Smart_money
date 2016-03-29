//
//  GetCashSuccessViewController.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/7/31.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "GetCashSuccessViewController.h"

@interface GetCashSuccessViewController ()

@end

@implementation GetCashSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)backViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd(今天)HH:mm"];
    NSString *destDate= [dateFormatter stringFromDate:[NSDate date]];
    self.getCashTime.text = destDate;
}


@end
