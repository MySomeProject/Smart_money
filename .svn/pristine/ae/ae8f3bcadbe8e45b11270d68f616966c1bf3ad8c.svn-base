//
//  CustomTabbarController.m
//  自定义tabbar
//
//  Created by Hanguoxiang on 15-1-28.
//  Copyright (c) 2015年 zhangyuanyuan. All rights reserved.
//

#import "CustomTabbarController.h"
#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000
#import "newHomeViewController.h"
#import "MineCenterViewController.h"
#import "SettingsTableViewController.h"
#import "ZMNavigationController.h"
#import "ZMLogInLogOutViewController.h"
#import "FinancingTableViewController.h"
#import "NewFeatureViewController.h"
#import "newHomeViewController.h"
#import "AppDelegate.h"

#define NotificationCenterKey @"resivenotification"

@interface CustomTabbarController ()<ZMLogInLogOutViewControllerDelegate>

@end

@implementation CustomTabbarController
{
    UIButton *_button;
    NSInteger myIndex;
    UIButton *_selectIndexBtn;
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    //1.2 获取当前版本号
    NSString *currentVresion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersion isEqualToString:currentVresion]) {
        //不是第一次使用
        [self start];
    }else{
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setBool:YES forKey:NotificationCenterKey];//储存开启通知状态为可以;

        [[NSUserDefaults standardUserDefaults]setObject:currentVresion forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //显示新特性控制器
        NewFeatureViewController *new = [[NewFeatureViewController alloc]init];
//        __unsafe_unretained CustomTabbarController * app = self;
        new.starXJEducate= ^(){
            [self start];
            
        };
        new.starAddlogin =^(){
            [self start];
            ZMLogInLogOutViewController* log = [[ZMLogInLogOutViewController alloc] initWithNibName:@"ZMLogInLogOutViewController" bundle:nil];
            
            UINavigationController* nav  = [[UINavigationController alloc] initWithRootViewController:log];
            nav.navigationBarHidden = YES;
            [self presentViewController:nav animated:YES completion:nil];
        };
        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        myDelegate.window.rootViewController = new;
    }

}
-(void)start{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.window.rootViewController = self;
    
   
    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    [self initControllers];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttomTabbarHiden) name:@"hiden" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttomTabbarShow) name:@"show" object:nil];

}
- (void)buttomTabbarHiden
{
    if(_myTabbar.hidden==YES)
    {
        return;
    }
    else
    {
        _myTabbar.hidden = YES;
    }
}
- (void)buttomTabbarShow
{
    if(_myTabbar.hidden==NO)
    {
        return;
    }
    else
    {
        _myTabbar.hidden = NO;
    }

}
#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    //  主页
//    UIStoryboard * homePage = [UIStoryboard storyboardWithName:@"HomePage4" bundle:nil];
//    HomePageViewController *home = [homePage instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    newHomeViewController* newhome = [[newHomeViewController alloc] init];
    
    
    [self addViewControllers:newhome title:@"主页"];
    
    //  我要投资

    FinancingTableViewController *invest = [[FinancingTableViewController alloc]init];
    [self addViewControllers:invest title:@"我要投资"];
    //  我的账户
    UIStoryboard * myCenterStoryboard = [UIStoryboard storyboardWithName:@"MineCenter" bundle:nil];
    MineCenterViewController *myCenterVC = [myCenterStoryboard instantiateViewControllerWithIdentifier:@"MineCenterViewController"];
//    MineCenterViewController * myCenterVC = [[MineCenterViewController alloc] init];
    [self addViewControllers:myCenterVC title:@"我的账户"];
    //  更多
    SettingsTableViewController *inforMa = [[SettingsTableViewController alloc]init];
    [self addViewControllers:inforMa title:@"更多"];
    //  照着上面添加控制球就行了
}
#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController title:(NSString *)title
{
    ZMNavigationController *nav = [[ZMNavigationController alloc]initWithRootViewController:childController];
    childController.navigationItem.title = title;
    //  添加导航栏的背景颜色
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"caiahgnjiashangtiao"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}
- (void)creatTabbar:(NSInteger)ControllersNum
{
    //  只需要该图片名字就行
    NSArray * normImage = @[@"icon5",@"icon6",@"icon7",@"icon8"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"icon4",@"icon2",@"icon3",@"icon"];
     self.tabBar.hidden = YES;
    _myTabbar = [[UIImageView alloc]initWithFrame:self.tabBar.frame];
//    [_myTabbar setImage:[UIImage imageNamed:@"sy2@2x"]]
    _myTabbar.backgroundColor = UIColorFromRGB(0xf8f8f8);
    _myTabbar.userInteractionEnabled = YES;
    for(int i = 0;i<self.viewControllers.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(EACH_W(self.viewControllers.count)*i, 0, EACH_W(self.viewControllers.count), EACH_H);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
        btn.tag = BTNTAG+i;
        [_myTabbar addSubview:btn];
        if(btn.tag==BTNTAG)
        {
            [self btnSelect:btn];
        }
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_myTabbar];
    
}
- (void)btnSelect:(UIButton *)sender
{

    _selectIndexBtn = sender;
        //登录
    if(sender.tag - BTNTAG ==2 )
    {
        if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        {
            /*UIStoryboard *mainStoryBoard = [UIStoryboard  storyboardWithName:@"logInOut" bundle:nil];
            ZMNavigationController *nav = (ZMNavigationController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ZMLogInLogOutNav"];
            
            CLog(@"viewControllers = %@", [nav viewControllers]);
            
            if([nav.visibleViewController isKindOfClass:[ZMLogInLogOutViewController class]])
            {
                ZMLogInLogOutViewController *LILO = (ZMLogInLogOutViewController *)nav.topViewController;
                LILO.delegate = self;
                LILO.isCustomTabbarAcount = YES;
        
            }*/
            ZMLogInLogOutViewController* log = [[ZMLogInLogOutViewController alloc] initWithNibName:@"ZMLogInLogOutViewController" bundle:nil];
            
            UINavigationController* nav  = [[UINavigationController alloc] initWithRootViewController:log];
            nav.navigationBarHidden = YES;
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
    }
    self.selectedIndex = sender.tag-BTNTAG;
    _button.selected =NO ;
    sender.selected = YES;
    _button = sender;
}
-(void)finishedLoginOrRegister:(id)sender
{
    [self btnSelect:_selectIndexBtn];
}
@end
