//
//  PayPassWordController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/8.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "PayPassWordController.h"
#import "GTCommontHeader.h"
@interface PayPassWordController ()

@end

@implementation PayPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0f green:241/255.0f blue:242/255.0f alpha:1]];
    self.zanweiLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(15)];
    for (UIView* view in self.view.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
    // Do any additional setup after loading the view from its nib.
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
