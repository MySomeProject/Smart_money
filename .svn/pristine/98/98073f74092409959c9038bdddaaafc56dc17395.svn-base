//
//  aboutMeViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/6.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "aboutMeViewController.h"
#import "GTCommontHeader.h"
@interface aboutMeViewController (){
    UIWebView * webview;
    float YOffsetForSubviewInVC;
}
@property(copy,nonatomic) NSString *detailUrl;
@end
@implementation aboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YOffsetForSubviewInVC =  64;
  /*  UIWebView* webView = [[UIWebView alloc ] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)
                          ];
    [webView setBackgroundColor:[UIColor whiteColor]];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"app-about-us" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
   */
    [self requestUrl];
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
-(void)requestUrl{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] getUrlByType:@"ABOUT_US" Success:^(id response) {
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
