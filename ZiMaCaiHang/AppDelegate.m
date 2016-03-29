//
//  AppDelegate.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-1.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"

#import "ZMLogInLogOutViewController.h"

//手势解锁
#import "PatternLockView.h"

//AES256编码
#import "NSData+Encryption.h"
#import "Base64.h"

//DES编码
#import "DESUtil.h"

#import "ZMServerAPIs.h"
//分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"

//#import <PgySDK/PgyManager.h>

#import <PgySDK/PgyManager.h>
#import "Reachability.h"
#import "UMessage.h"
#import "GTCommontHeader.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试
#define ALERTVIEW_TAG_UPDATE_VERSION        1000
#define _IPHONE80_ 80000
#define UMENG_APPKEY @"5599dac267e58ebe36003a91"
#define UMOnlineConfigDidFinishedNotification @"OnlineConfigDidFinishedNotification"
#define NotificationCenterKey @"resivenotification"
@interface AppDelegate ()<ZMLogInLogOutViewControllerDelegate>{
    PatternLockView * lockView ;
}
-(void)reachabilityChanged:(NSNotification*)note;

@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;
@property(strong) NSString *url;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLog(@"%f",ScreenWidth);
    self.isTellPhone = NO;
    self.isResignActive = NO;
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    [self aboutWe];
//    [self checkingNewestVersion];
    if(EnterpriseDistributeModel==1)
    {
        [[PgyManager sharedPgyManager] startManagerWithAppId:@"88c9687e4af250b1dc91cc7b62bebc1f"];
        [[PgyManager sharedPgyManager]checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
        [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    }
    [self setUpShareSDK];
    //set AppKey and AppSecret
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
//    [UMessage setLogEnabled:YES];
    [self netchange];
    
    [self.window makeKeyAndVisible];
    if (HEIGHT_OF_SCREEN>480) {
        [self animationForLead];

    }

    return YES;
}
-(void)animationForLead{
    
    UIImageView* leadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)];
    [leadView setImage:[UIImage imageNamed:@"LaunchDefault"]];
    UIView* lunchView = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreen" owner:nil options:nil][0];
    lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    [self.window addSubview:lunchView];
    
    [lunchView addSubview:leadView];
    [self.window bringSubviewToFront:lunchView];
    UIImageView* caihangjiaView = [[UIImageView alloc] init];
    [caihangjiaView setFrame:CGRectMake(0,100, GTFixWidthFlaot(172),GTFixHeightFlaot(82))];
    caihangjiaView.center = lunchView.center;
    [caihangjiaView setOrigin:CGPointMake(caihangjiaView.left, GTFixHeightFlaot(100))];
    [caihangjiaView setImage:[UIImage imageNamed:@"AnimationLogo"]];
    caihangjiaView.alpha = 0;
    [lunchView addSubview:caihangjiaView];
    if (HEIGHT_OF_SCREEN == 480) {
        [caihangjiaView setImage:[UIImage imageNamed:@"AnimationLogoFor4"]];
    }
    //changeFor4s
    
    
    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    [UIView animateWithDuration:.35 animations:^{
        caihangjiaView.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.35 animations:^{
                lunchView.alpha = 0.0;
                lunchView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.15f, 1.15f);
            } completion:^(BOOL finished) {
                [lunchView removeFromSuperview];
            }];
        });
    }];
}
- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) BATCH channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
//    [MobClick updateOnlineConfig];  //在线参数配置
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    CLog(@"online config has fininshed and note = %@", note.userInfo);
}


-(void)netchange{
    self.googleReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [self.googleReach startNotifier];
    
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    self.localWiFiReach.reachableOnWWAN = NO;
    [self.localWiFiReach startNotifier];
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    [self.internetConnectionReach startNotifier];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    self.isResignActive = YES;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
    
    
    /**
     *  check the pattern lock
     */
//    NSString *patternLockPassword = [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
//    if ([patternLockPassword length] >= 3) {
//        [self openThePatternLock];
//    }
    self.isResignActive = NO;
    [lockView removeFromSuperview];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    CLog(@"%@",deviceToken);
    CLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);

    [UMessage registerDeviceToken:deviceToken];
    
}

//接受消息成功
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    CLog(@"%@",userInfo);
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    BOOL resive = [accountDefaults boolForKey: NotificationCenterKey];
    if (resive) {
        [UMessage didReceiveRemoteNotification:userInfo];

    }else{
        [UMessage unregisterForRemoteNotifications];
    }
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
                                                                message:userInfo[@"description"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    
    
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn] &&
       [[ZMAdminUserStatusModel shareAdminUserStatusModel] getLoginKey] != nil) {
    
        ZMNavigationController* nav= (ZMNavigationController*)self.window.rootViewController;
        NSArray* childViewControllers=nav.childViewControllers;
        [nav popToViewController:childViewControllers[0] animated:YES];
        UITabBarController* bar=(UITabBarController*)childViewControllers[0];
        [bar setSelectedIndex:1];
        
    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    CLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    CLog(@"applicationDidBecomeActive");
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    /**
     *  更新用户信息
     */
    [self updateAdminUserInfo];
    
    /*
     *  检测系统版本
     */

  
//    if (EnterpriseDistributeModel == 1){
//        [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
//    }
//    else
//    {
//        [self checkingNewestVersion];
//    }

    //上传头像
//    UIImage *image = [UIImage imageNamed:@"propeller.png"];
//    NSData *data = UIImagePNGRepresentation(image);
//    [[ZMServerAPIs shareZMServerAPIs] uploadAvatar:data Success:^(id response) {
//        
//        CLog(@"上传头像成功 ＝ %@", response);
//        
//    } failure:^(id response) {
//        
//        CLog(@"上传头像失败 ＝ %@", response);
//        
//    }];
    
    NSString *patternLockPassword = [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
    
    if ([patternLockPassword length] >= 3) {
        if (!self.isTellPhone) {
            if (self.isResignActive) {
                self.isResignActive = NO;
                LAContext *context = [[LAContext alloc] init];
                NSError *error = nil;
                if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                    
                    return;
                }
            }else{
                
            }
            [self openThePatternLock];

        }
        self.isTellPhone = NO;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark ------------- ZMLogInLogOutViewController Delegate ---------------

-(void)finishedLoginOrRegister:(id)sender
{
    UIStoryboard *mainStoryBoard = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
    
    self.window.rootViewController = (UIViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
}
/**
 *  重
 */
-(void)CheckingLogOrNot
{
    lockView = nil;
//    UIStoryboard *mainStoryBoard = [UIStoryboard  storyboardWithName:@"logInOut" bundle:nil];
//    ZMNavigationController *nav = (ZMNavigationController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ZMLogInLogOutNav"];
    ZMLogInLogOutViewController *LILO = [[ZMLogInLogOutViewController alloc]
                                         init];

    LILO.delegate = self;
    
    LILO.isFromAppDelegate = YES;
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:LILO];
    nav.navigationItem.leftBarButtonItem = nil;
    
    CLog(@"viewControllers = %@", [nav viewControllers]);
    
    [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:NO];
    
    //重新刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_SETTING_VIEW_NOTIFICATION_NAME object:nil];
    //改变用户登录状态（刷新主菜单）
    [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_BSAE_USER_INFO_SUCCESS_NOTIFICATION_NAME object:nil];
    
//    if([nav.visibleViewController isKindOfClass:[ZMLogInLogOutViewController class]])
//    {
//        ZMLogInLogOutViewController *LILO = (ZMLogInLogOutViewController *)nav.topViewController;
//        
//        LILO.delegate = self;
//        
//        LILO.isFromAppDelegate = YES;
//    }
//    
    
    
    
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
}


/**
 *  手势解锁
 */
-(void)openThePatternLock

{
    [lockView removeFromSuperview];
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    lockView = [[PatternLockView alloc]initWithFrame:frame forSettingLock:NO];
    
    lockView.forgetPatternPasswordBlock = ^{
        
        CLog(@"忘记密码 忘记密码");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self CheckingLogOrNot];
            
        });
    };

    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:lockView];
    [window bringSubviewToFront:lockView];
}

/**
 *  更新用户信息
 */
- (void)updateAdminUserInfo
{
    NSString * loginKey = [[ZMAdminUserStatusModel shareAdminUserStatusModel] getLoginKey];
    //是否已经登录
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn] &&
       loginKey != nil)
    {
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAssert];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAccount];
    }
}

-(void)aboutWe
{
    
    [[ZMServerAPIs shareZMServerAPIs] getUserNowSuccess:^(id response) {
        CLog(@"%@",response);
        NSDictionary *dict = (NSDictionary *)response;
        
        NSDictionary *subDict = dict[@"data"];
        
        NSString *message = subDict[@"messageCenter"];
        
        int level = [subDict[@"level"] intValue];
        _url = subDict[@"url"];
        
        if (level == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                                delegate:self
                                                        cancelButtonTitle:@"取消"
                                                        otherButtonTitles:@"确定", nil];
                alter.tag = 1001;
                [alter show];
                alter=nil;
            });
            
            
        }else if(level == 2){
        
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                alter.tag = 1002;
                [alter show];
                alter=nil;
            });
        }else
        {
            
        }
        
    } failure:^(id response) {
        
        CLog(@"获取数据失败");
        
    }];
}


/*
 * 检测系统版本（App store）
 */
//-(NSString *)checkingNewestVersion
//{
//    [[ZMServerAPIs shareZMServerAPIs] checkingNewestVersion:^(id response) {
//        if (response) {
//            
//            CLog(@"lastestversion %@", response);
//            NSString *newVersion = (NSString *)response;
//            
//            NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            
//            if (![localVersion isEqualToString:newVersion]) {
//                
//                //改变文字显示
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@""
//                                                                    message:@"有新版本发布啦，现在就去更新吧！"
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"放弃"
//                                                          otherButtonTitles:@"更新", nil];
//                    alter.tag = ALERTVIEW_TAG_UPDATE_VERSION;
//                    [alter show];
//                    alter=nil;
//                });
//            }
//        }
//    }];
//    
//    return @"";
//}

/*
 *  企业级版本更新
 */
//- (void)updateMethod:(NSDictionary *)response
//{
//    CLog(@"蒲公英更新回调信息：%@", response);
//    if (response[@"downloadURL"])
//    {
//        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//        
//        NSString *versionCode = response[@"versionCode"];
//        
//        if ([versionCode isEqualToString:localVersion]) {
//            return;
//        }
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"有新版本发布啦，现在就去更新吧！"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"放弃"
//                                                  otherButtonTitles:@"更新",nil];
//        alertView.tag = ALERTVIEW_TAG_UPDATE_VERSION;
//        [alertView show];
//    }
//        [[PgyManager sharedPgyManager] updateLocalBuildNumber];
//}

/**
 *  建立分享链接
 */
-(void)setUpShareSDK
{
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:@"wxdd8ea8c380def15d" appSecret:@"9dc4d7e88d59acd4417ac1076dbf189a" url:@"http://www.caihangjia.com/"];
    [UMSocialQQHandler setQQWithAppId:@"1104778512" appKey:@"VJsApXjPlwdgNZLg" url:@"http://www.caihangjia.com/"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://mobile.caihangjia.com/app/"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
        }
    }
    if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
        }
    }
    
//    //下载更新 App
//    if (alertView.tag == ALERTVIEW_TAG_UPDATE_VERSION){
//        if (buttonIndex == 1) {
//            
//            //企业发布模式
//            if(EnterpriseDistributeModel == 1)
//            {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pgyer.com/caihangjia"]];
//            }
//            else
//            {
//                [[UIApplication sharedApplication] openURL:APPSTORE_URL];
//            }
//        }
//    }
}

#pragma mark －－－－－Share SDK 应用跳转接口－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
+ (void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = CGRectMake1(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
            for (UIView *temp2 in temp1.subviews) {
                temp2.frame = CGRectMake1(temp2.frame.origin.x, temp2.frame.origin.y, temp2.frame.size.width, temp2.frame.size.height);
            }
        }
    }
}
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
    //    CLog(@"%lf,%lf,%lf,%lf",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    return rect;
}


@end
