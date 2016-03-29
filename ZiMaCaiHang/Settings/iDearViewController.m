//
//  iDearViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/1.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "iDearViewController.h"
#import "HUD.h"
#import "GTCommontHeader.h"
@interface iDearViewController ()

@end

@implementation iDearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"意见反馈"];
    self.idearTextView.delegate = self;
    for (UIView* view in self.view.subviews) {
        view.frame = GetFramByXib(view.frame);
    }
    self.sendbtn.userInteractionEnabled = NO;
    self.placeholderlabel.font = [UIFont systemFontOfSize:GTFixHeightFlaot(12)];
    self.idearTextView.font = [UIFont systemFontOfSize:GTFixHeightFlaot(12)];
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone5s
    {
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
    {
        self.placeholderlabel.origin = CGPointMake(self.placeholderlabel.origin.x, self.placeholderlabel.origin.y-3);
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
    {
        self.placeholderlabel.origin = CGPointMake(self.placeholderlabel.origin.x, self.placeholderlabel.origin.y-3);
    }
    [self.sendbtn addTarget:self action:@selector(sendbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
-(void)sendbtnClick:(UIButton*)sender{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"发送ing..."];
    
    
    [[ZMServerAPIs shareZMServerAPIs] SendiDearsWith:self.idearTextView.text Success:^(id response) {
        CLog(@"发送用户反馈成功 OK ＝ %@", response);
                //刷新首页项目数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"发送成功"];
            self.idearTextView.text = nil;
            self.placeholderlabel.hidden = NO;
//            [self.navigationController popViewControllerAnimated:YES];
            
            [self.idearTextView resignFirstResponder];
            [HUDjz hide:YES afterDelay:1.0];
        });

        
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:1.0];
        });

    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.idearTextView resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    CLog(@"%@",text);
  

    if (textView.text.length >100) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"您的意见有些太长哦,不能再输了~"];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>=15) {
        self.sendbtn.userInteractionEnabled = YES;
        [self.sendbtn setBackgroundImage:[UIImage imageNamed:@"yijianfankuisendred"] forState:UIControlStateNormal];
    }
    else {
        self.sendbtn.userInteractionEnabled = NO;
        [self.sendbtn setBackgroundImage:[UIImage imageNamed:@"yijianfankuisend"] forState:UIControlStateNormal];
    }
    if (textView.text.length > 0) {
        self.placeholderlabel.hidden = YES;
    }else{
        self.placeholderlabel.hidden = NO;
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
