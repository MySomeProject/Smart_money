//
//  tzxyViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/8/7.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "tzxyViewController.h"
#import "GTCommontHeader.h"

@interface tzxyViewController (){
    UIWebView * webview;
    float YOffsetForSubviewInVC;
}

@end

@implementation tzxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投资协议";
    YOffsetForSubviewInVC = 64;
    [self requestUserxy];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWebView{
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, YOffsetForSubviewInVC , WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - YOffsetForSubviewInVC)];
    [webview setDelegate:self];
    [webview setBackgroundColor:[UIColor whiteColor]];
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"yinsiBaohu" ofType:@"html"];
    //    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSURL *url;
    NSString *URLString = [self valueForKey:@"detailUrl"];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
}
-(void)requestUserxy{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"YUEMANYING_AGREEMENT" ProductId:self.productId lendTime:self.lendTime Success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz hide:YES afterDelay:1.0];
            self.detailUrl = [response objectForKey:@"url"];
            [self initWebView];
        });
        
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:1.0];
        });
        
        CLog(@"首页推荐项目－失败 ＝ %@", response);
    }];
    
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
