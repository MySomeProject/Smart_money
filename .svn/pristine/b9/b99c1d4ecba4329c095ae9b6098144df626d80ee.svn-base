//
//  RechangeSuccessViewController.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/7/31.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "RechangeSuccessViewController.h"
#import "HHAlertView.h"

@interface RechangeSuccessViewController ()<HHAlertViewDelegate>

@end

@implementation RechangeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
     if([ZMAdminUserStatusModel shareAdminUserStatusModel].isFirstInAmount == YES)
     {
         MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [HUDjz hide:YES afterDelay:1.0];
                [[ZMServerAPIs shareZMServerAPIs] FirstRechargeSuccess:^(id response) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[response objectForKey:@"code"] integerValue] == 0){
                            
                        } else{
                            HHAlertView *alertview = [[HHAlertView alloc] initWithTitle:@"" detailText:[NSString stringWithFormat:@"%@",[response objectForKey:@"message"]] cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            [alertview setEnterMode:HHAlertEnterModeTop];
                            [alertview setLeaveMode:HHAlertLeaveModeBottom];
                            [alertview showWithBlock:^(NSInteger index) {
                                NSLog(@"%ld",index);
                            }];


                          
                        }
                        
                    });
                    

                } failure:^(id response) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        [HUDjz setLabelText:@"请检查网络"];
                        [HUDjz hide:YES afterDelay:1.0];
                    });
                    
                    CLog(@"是否首次充值 ＝ %@", response);
                }];
                

            }

    
    self.investMoney.text = [NSString stringWithFormat:@"￥%@",self.rechangeMoney];
}
- (IBAction)rechangeSuccessBtnClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
