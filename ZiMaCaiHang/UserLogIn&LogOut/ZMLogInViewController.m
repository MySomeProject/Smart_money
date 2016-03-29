//
//  ZMLogInViewController.m
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMLogInViewController.h"
#import "AllStatusManager.h"
#import "GTCommontHeader.h"
@interface ZMLogInViewController ()

@end

@implementation ZMLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLog(@"loginOrRegisterType ==== %d", self.loginOrRegisterType);
    for (UIView* view in self.view.subviews){
        view.frame = GetFramByXib(view.frame);
        for (UIView* childview in view.subviews){
            childview.frame = GetFramByXib(childview.frame);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logInFinished:(UIButton *)button
{
    CLog(@"logInFinished");
    [[AllStatusManager sharedStatusManager] setLoggedIn:YES];
    [self.delegate finishedLogin:@"ZMLogInViewController.h"];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
