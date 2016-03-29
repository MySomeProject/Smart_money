//
//  ZMPresentWebViewController.m
//  WebView
//
//  Created by zima on 14-10-22.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMPresentWebViewController.h"

@interface ZMPresentWebViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
    UIWebView *webView;
}
@end

@implementation ZMPresentWebViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CLog(@"HHHH  ===== %@", _vkey);
    
    [activityIndicator startAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _vtitle;
    
    _vkey = [self valueForKey:@"vkey"];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
    [activityIndicator setHidesWhenStopped:YES];
    
    webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [webView setBackgroundColor:[UIColor whiteColor]];
    webView.delegate = self;
    
    [webView addSubview:activityIndicator];
    [self.view addSubview: webView];
    
    
    //取消/返回按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"DetailBackButton"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"DetailBackButton"] forState:UIControlStateHighlighted];
    [cancelButton setFrame:CGRectMake(20, 30, 17, 17)];
    [cancelButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    
    
    [self contenthhhhhhhhh];
    return;
    
    
//    [self loadAgreement];
    [self loadWebView];
    return;
    
    
    if (_isWebURL) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_vkey]];
        [webView loadRequest:request];
    }
    else
    {
//        [self loadAgreement];
        [self loadWebView];
    }
}

- (void)loadWebView
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"user-xy" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:reqest];
}




-(void)contenthhhhhhhhh
{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"REGISTRATION_AGREEMENT" ProductId:@""  lendTime:@"" Success:^(id response){

    dispatch_async(dispatch_get_main_queue(), ^{
        [HUDjz hide:YES afterDelay:1.0];
        NSString *URLString = [response valueForKey:@"url"];
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL* url = [NSURL URLWithString:URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        });
    } failure:^(id response) {
        [HUDjz setLabelText:@"请检查网络"];
        [HUDjz hide:YES afterDelay:1.0];
    }];
}


/**
 *  加载直接发送过来的html代码协议
 */
- (void)loadAgreement
{
//    NSString *txtPath = [[NSBundle mainBundle] pathForResource:@"111111" ofType:@"txt"];
//    NSString *string = [[NSString  alloc] initWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
//    
//    return;
    
    
    
    
    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"REGISTRATION_AGREEMENT" ProductId:@"" lendTime:nil Success:^(id response) {
        
        _vkey = [[response objectForKey:@"data"] objectForKey:@"content"];
        NSData *data = [_vkey dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
        });
        
    } failure:^(id response) {
        CLog(@"协议失败 response %@", response);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    [activityIndicator stopAnimating];
}

- (void)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
