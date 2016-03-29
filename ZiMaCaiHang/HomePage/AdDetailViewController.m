//
//  AdDetailViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/6.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AdDetailViewController.h"
#import "GTCommontHeader.h"
@interface AdDetailViewController ()

@end

@implementation AdDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
    for (UIView* view in self.view.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
    self.titleLabel.text = self.titleStr;
    self.titleLabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(15)];
    self.contentTextView.size = CGSizeMake(self.contentTextView.width, HEIGHT_OF_SCREEN-GTFixHeightFlaot(102)-44);
    
    self.contentTextView.text = self.contenstr;
    self.contentTextView.font = [UIFont systemFontOfSize:GTFixHeightFlaot(14)];
    self.contentTextView.delegate = self;
    if ([self.NavTitle isEqualToString:@"投资协议"]) {
        self.title = self.NavTitle;
        [self requestUserxy];
    }

}
-(void)requestUserxy{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    
    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"YUEMANYING_AGREEMENT" ProductId:nil lendTime:nil Success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz hide:YES afterDelay:1.0];
            self.contentTextView.text = [[response objectForKey:@"data"]  objectForKey:@"content"];
        });

    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:1.0];
        });
        
        CLog(@"首页推荐项目－失败 ＝ %@", response);
    }];
//    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"YUEMANYING_AGREEMENT" lendTime:nil Success:^(id response) {
//        
//    } failure:^(id response) {
//        
//    }];
//
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
