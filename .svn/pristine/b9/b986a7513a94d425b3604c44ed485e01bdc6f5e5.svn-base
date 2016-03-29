//
//  HXWebViewController.m
//  miXin
//
//  Created by HAIXUN on 10/13/14.
//  Copyright (c) 2014 HAIXUN. All rights reserved.
//

#import "HXWebViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#define  kScreen_width ([UIScreen mainScreen].applicationFrame.size.width)
#define  kScreen_height ([UIScreen mainScreen].bounds.size.height)

#define IOS8      [[[UIDevice currentDevice] systemVersion]floatValue]>=7.8
#define IOSNew7   ([[[UIDevice currentDevice] systemVersion]floatValue]>=7 && [[[UIDevice currentDevice] systemVersion]floatValue]<7.8)

@interface HXWebViewController ()<UIWebViewDelegate>
{
    /**
     *  ios 8 偏移量
     */
    NSInteger YOffsetForSubviewInVC;
    
    
    UIActivityIndicatorView *activityIndicatorView;
    UIWebView *webview;
    NSString* shareContent;
    NSString* shareUrl;
}
@end

@implementation HXWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [activityIndicatorView startAnimating];
    [self.navigationController.navigationBar setHidden:NO];
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  ios 8 偏移量
     */
    if (IOS8) {
        YOffsetForSubviewInVC = 64;
    }
    else if (IOSNew7){
        YOffsetForSubviewInVC = 0;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue]
        >=8.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
    }
    [webview removeFromSuperview];
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, YOffsetForSubviewInVC, kScreen_width, kScreen_height - YOffsetForSubviewInVC)];
    if (IOSNew7) {
        webview.size = CGSizeMake(WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN+49);
    }
    [webview setDelegate:self];
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"yinsiBaohu" ofType:@"html"];
    //    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSURL *url;
    NSString *URLString = [self valueForKey:@"detailUrl"];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    [self.view insertSubview:activityIndicatorView aboveSubview:webview];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(kScreen_width/2, kScreen_height/2);//只能设置中心，不能设置大小
    [activityIndicatorView setHidesWhenStopped:YES];
    [activityIndicatorView startAnimating];
    UIButton* rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn addTarget:self action:@selector(sharedAction:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self addrightTopBtnWith:rightBtn];
}
-(void)sharedAction:(UIButton*)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5599dac267e58ebe36003a91"
                                      shareText:nil
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToSina,UMShareToQQ,UMShareToSms,nil]
                                       delegate:self];

}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToSina) {
        socialData.title = self.shareTitle;
        socialData.shareText = self.shareContent;
    }else if (platformName == UMShareToSms) {
        //        socialData.shareImage = [UIImage imageNamed:@"fenxiang"];
        [UMSocialData defaultData].extConfig.smsData.shareImage =[UIImage imageNamed:@"meiyou"];
        socialData.shareText = self.shareContent;
    }else if (platformName == UMShareToQzone) {
        [UMSocialQQHandler setQQWithAppId:@"1104778512" appKey:@"VJsApXjPlwdgNZLg" url:self.shareUrl];

        [UMSocialData defaultData].extConfig.qzoneData.title = self.shareTitle;
        socialData.shareText = self.shareContent;
        NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]];
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.shareUrl];

        [UMSocialData defaultData].extConfig.qzoneData.shareImage =dateImg;
    }
    else if (platformName == UMShareToQQ) {
        [UMSocialData defaultData].extConfig.qqData.title = self.shareTitle;
        socialData.shareText = self.shareContent;
        //        socialData.shareImage = [UIImage imageNamed:@"fenxiang"];
        NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]];
        [UMSocialQQHandler setQQWithAppId:@"1104778512" appKey:@"VJsApXjPlwdgNZLg" url:self.shareUrl];
        [UMSocialData defaultData].extConfig.qqData.shareImage =dateImg;
        //        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.shareUrl];
        CLog(@"%@",self.shareUrl);
    }else if (platformName == UMShareToWechatSession) {
        [UMSocialWechatHandler setWXAppId:@"wxdd8ea8c380def15d" appSecret:@"9dc4d7e88d59acd4417ac1076dbf189a" url:self.shareUrl];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = self.shareTitle;
        socialData.shareText = self.shareContent;
        socialData.title =self.shareTitle;
        NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]];
        socialData.shareImage = dateImg;
        CLog(@"%@",[NSURL URLWithString:self.shareImage]);
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:self.shareUrl];
        [[UMSocialData defaultData].urlResource setUrl:self.shareUrl];
        
        CLog(@"%@",self.shareUrl);
    }else if (platformName == UMShareToWechatTimeline) {
        [UMSocialWechatHandler setWXAppId:@"wxdd8ea8c380def15d" appSecret:@"9dc4d7e88d59acd4417ac1076dbf189a" url:self.shareUrl];
        
        NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]];
        socialData.shareImage = dateImg;
        socialData.shareText = self.shareTitle;
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.shareUrl];
        CLog(@"%@",self.shareUrl);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicatorView stopAnimating];
    
    CLog(@"网页加载失败");
}

@end
