//
//  InvitefriendsViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/8/28.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InvitefriendsViewController.h"
//分享
#import "UMSocial.h"
@interface InvitefriendsViewController ()<UMSocialUIDelegate>{
    UIWebView * webview;
    float YOffsetForSubviewInVC;
    NSString* shareContent;
    NSString* shareUrl;
    NSString * shareTitle;
    NSURL *imgUrl;
}
/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property(copy,nonatomic) NSString *detailUrl;
@end
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
@implementation InvitefriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YOffsetForSubviewInVC =  64;

    if (Version>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
    }
    [self requestUrl];
}
-(void)initWebView{
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, YOffsetForSubviewInVC , WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - YOffsetForSubviewInVC )];
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
//("url",url);//页面url
//("shareTitle", "财行家分享标题");
//("shareContent", "财行家APP，不玩你就OUT了，我正在用它赚钱，你也快来下载吧，注册邀请码" + myShareCode+" "+downloadUrl);
//("share_imgurl","http://wap.caihangjia.com/theme/html/images/icon.png");
//("share_url", "http....");
//[UIImage
// 
// imageWithData:[NSData
//                
//                
//                
//                
//                dataWithContentsOfURL:[NSURL
//                                       
//                                       URLWithString:urlstring]]];
//
-(void)requestUrl{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] RequestInviteFriendsUrlSuccess:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            shareContent = [NSString stringWithFormat:@"%@",[response objectForKey:@"shareContent"]];
            shareUrl = [NSString stringWithFormat:@"%@",[response objectForKey:@"share_url"]];
            shareTitle = [NSString stringWithFormat:@"%@",[response objectForKey:@"shareTitle"]];
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"share_imgurl"]]];
            [HUDjz hide:YES afterDelay:1.0];
            self.detailUrl = [response objectForKey:@"url"];
            [self initWebView];
        });
        
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:1.0];
        });
        
        CLog(@"邀请好友－失败 ＝ %@", response);
    }];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
//        if ([webView subviews]) {
//            UIScrollView* scrollView = [[webView subviews] objectAtIndex:0];
//            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        }
        [self ShareAction];
        if (Version<8.0) {
            [webView reload];
        }
//        NSURL *url = [request URL];
//        if([[UIApplication sharedApplication]canOpenURL:url])
//        {
//            [[UIApplication sharedApplication]openURL:url];
//        }
        return NO;
    }
    return YES;
}
-(void)ShareAction{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5599dac267e58ebe36003a91"
                                      shareText:nil
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToSms,nil]
                                       delegate:self];
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToSina) {
        socialData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        socialData.title =shareTitle;
        socialData.shareText = shareContent;
    }else if (platformName == UMShareToSms) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:nil];
        socialData.shareText = shareContent;
    }else if (platformName == UMShareToTencent) {
        socialData.title =shareTitle;
        socialData.shareText = shareContent;

    }
    else if (platformName == UMShareToQQ) {
        [UMSocialData defaultData].extConfig.qqData.title = shareTitle;
        socialData.shareText = shareContent;
        socialData.title =shareTitle;
        socialData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
//        socialData.shareImage = [UIImage imageNamed:@"fenxiang"];
//        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageNamed:@"fenxiang"];
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:shareUrl];
    }else if (platformName == UMShareToWechatSession) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
        socialData.shareText = shareContent;
        socialData.title =shareTitle;
        socialData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:shareUrl];

    }else if (platformName == UMShareToWechatTimeline) {
//        socialData.shareImage = [UIImage imageNamed:@"fenxiang"];
        socialData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        socialData.title =shareTitle;
        socialData.shareText = shareContent;
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:shareUrl];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
