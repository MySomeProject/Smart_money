//
//  InsuranceViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/6/4.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InsuranceViewController.h"

@interface InsuranceViewController ()

@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
    {
        if (HEIGHT_OF_SCREEN == 480)
        {
            [self.scrollView setFrame:CGRectMake(0, 0, 320, 480)];
        }
        [self.scrollView setContentSize:CGSizeMake(320, 3012)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
    {
        [self.scrollView setContentSize:CGSizeMake(320, 3080)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
    {
        [self.scrollView setContentSize:CGSizeMake(320, 3336)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
