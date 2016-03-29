//
//  ZMPresentWebViewController.m
//  WebView
//
//  Created by zima on 14-10-22.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMShowWebViewController.h"

@interface ZMShowWebViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
    UIWebView *webView;
}
@end

@implementation ZMShowWebViewController

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
    
    
    
//    [self contenthhhhhhhhh];
//    return;
    
    
    [self loadAgreement];
    return;
    
    
    if (_isWebURL) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_vkey]];
        [webView loadRequest:request];
    }
    else
    {
        [self loadAgreement];
    }
}

-(void)contenthhhhhhhhh
{
    NSString * loanType = [[ZMServerAPIs shareZMServerAPIs] getLoanTypeNameByType:ZMLoanType_YUEMANYING];
    long loanId = 20;
    
    //    NSString * loanType = [[ZMServerAPIs shareZMServerAPIs] getLoanTypeNameByType:ZMLoanType_JIJIFENG];
    //    long loanId = 21;
    
    //    NSString * loanType = [[ZMServerAPIs shareZMServerAPIs] getLoanTypeNameByType:ZMLoanType_SHUANGJIXIN];
    //    long loanId = 22;
    //
    //    NSString * loanType = [[ZMServerAPIs shareZMServerAPIs] getLoanTypeNameByType:ZMLoanType_NIANNIANHONG];
    //    long loanId = 23;
    
    [[ZMServerAPIs shareZMServerAPIs] getProductDetailWithType:loanType LoanId:loanId success:^(id response){
        
        NSDictionary * productInfo = [[response objectForKey:@"data"] objectForKey:@"productInfo"];

        //        [productInfo objectForKey:@"content"];
//        [productInfo objectForKey:@"info"];
        
        CLog(@"content = %@", [productInfo objectForKey:@"content"]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *data = [[productInfo objectForKey:@"productdetails"] dataUsingEncoding:NSUTF8StringEncoding];
            
            [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
        });
        
    } failure:^(id response) {
        
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
    [[ZMServerAPIs shareZMServerAPIs] getAgreementWithAgreementType:@"YUEMANYING_AGREEMENT" ProductId:@"" lendTime:nil Success:^(id response) {
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
