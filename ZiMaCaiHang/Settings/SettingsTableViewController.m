//
//  SettingsTableViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SetGestureTableViewCell.h"
#import "PushMessageTableViewCell.h"
#import "LoginOutTableViewCell.h"
#import "SetUserTableViewCell.h"
#import "SetotherTableViewCell.h"
#import "GTCommontHeader.h"
#import "AboutUsViewController.h"
#import "InsuranceViewController.h"
#import "BankCardTableViewController.h"
#import "BankCardViewController.h"
#import "HUD.h"
#import "UIImageView+WebCache.h"
#import "ZMSafeSettingsViewController.h"
#import "iDearViewController.h"
#import "aboutMeViewController.h"
#import "HelpViewController.h"
#import "PayPassWordController.h"

#import "ZMRegisterInViewController.h"
#import "ZMLogInLogOutViewController.h"

//手势密码设置页面
#import "PatternLockViewController.h"

//蒲公英版本检测
#import <PgySDK/PgyManager.h>
#import "Reachability.h"
#define ALERTVIEW_TAG_UPDATE_VERSION        1000
#define ALERTVIEW_TAG_CLOSE_PATTERN         1001

#define ALERTVIEW_TAG_CHECK_USER_PATTERN    1003

#define ALERTVIEW_TAG_SIGN_OUT              1002
#define ALERTVIEW_TAG_USER_IMG              1004
#define NotificationCenterKey @"resivenotification"
#define UPDATE_USER_INFO @"updateuserinfo"
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define HEIGHTDOWN 64

@interface SettingsTableViewController ()
{
    NSString *_lastestVersion;
    
    SevenSwitch * patternSwitchButton;     //手势密码
    
    BOOL isPatternSwitchButtonOn;          //手势密码是否
    NSArray* cellImageAry;
    NSArray* cellTitleAry;
    NSArray* RectAry;
    NSString *realName;
    SevenSwitch* switchButtonss;
    SevenSwitch* switchButtonts;

}
@end

static NSString *SetUserTableViewCellIdentifier = @"SetUserTableViewCell";
static NSString *SetotherTableViewCellIdentifier = @"SetotherTableViewCell";

@implementation SettingsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //默认为当前版本
    _lastestVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
//    [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
    
    
//    //检测是否有新版本
//    
//    [self checkingNewestVersion];
//
//    //企业发布模式
//    if(EnterpriseDistributeModel == 1)
//    {
////        [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
//    }
//    //App store
//    else
//    {
//        [self checkingNewestVersion];
//    }
//    
//    [self.tableView reloadData];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];


  
    
    if ([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
    {
        NSString* namestr = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
        NSString* moblestr = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.mobile;
        
        if (![namestr isEqual:@""]) {
            realName = namestr;
        }
        if([namestr isEqualToString:@""] || realName == nil)
        {
//            realName = @"财行家用户";
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
            namestr = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
            
            if ([namestr isEqual:@""]&& ![moblestr isEqual:@""]) {
                realName = moblestr;
            }else
            realName = namestr;
        }
        if (realName.length ==
            11) {
            NSMutableString* mutbName = [NSMutableString stringWithString:realName];
            [mutbName replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            realName = mutbName;
        }
    }else{
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:NO];
        [patternSwitchButton setOn:NO animated:YES];
    }
    
    [self.tableView reloadData];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSettingTableView) name:UPDATE_USER_INFO object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self creatTableView];
    if (Version>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
        [self.tableView setOrigin:CGPointMake(self.tableView.left, self.tableView.top+HEIGHTDOWN)];
    }
    self.title = @"发现";
    self.ftpManager.delegate = self;
    cellImageAry = @[@"anquanrenzheng",@"yinhangkaguanli",@"shoushimima",@"tzzx",@"bangzhuzhongxin",@"yijianfankui",@"guanyuwomen"];
    cellTitleAry =@[@"安全认证",@"银行卡管理",@"手势密码",@"通知中心",@"帮助中心",@"意见反馈",@"关于我们"];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:243/255.0f alpha:1];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView=nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    [self.tableView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:243/255.0 alpha:1.0]];
    UINib *nib = [UINib nibWithNibName:SetUserTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:SetUserTableViewCellIdentifier];
    nib = [UINib nibWithNibName:SetotherTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:SetotherTableViewCellIdentifier];

    
//    [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_SETTING_VIEW_NOTIFICATION_NAME object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSettingTableView) name:RELOAD_SETTING_VIEW_NOTIFICATION_NAME object:nil];
    
    //在其他移动设备登录了
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSettingTableView) name:LOGIN_ON_OTHER_DEVICE_NOTIFICATION_NAME object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}
-(void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN-44-64) style:UITableViewStylePlain];
    //    _tableview.layer.cornerRadius= 6;
    //    _tableview.layer.masksToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.allowsSelection=YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.89];
    //        _tableview.tableHeaderView=nil;
    //        _tableview.tableFooterView= nil;
    //    _tableview.tableFooterView.backgroundColor = [UIColor whiteColor];
    //    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];

}
//网络连接检查
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable])
    {
        [self.tableView reloadData];
    }
    else
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"网络异常,请检查网络"];
        
    }
    
}

-(void)requestUserNameAndIMg{
    
}
- (NSString *)saveImage:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userImage.png"]];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath atomically:YES];
    if (!result)
    {
        return @"";
    }
    return filePath;
}

/*
 * 被另一台设备上登陆
 */
- (void)loginOnOtherDeviceNotificationName:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////获取版本更新信息
//-(NSString *)checkingNewestVersion
//{
//    [[ZMServerAPIs shareZMServerAPIs] checkingNewestVersion:^(id response) {
//        if (response) {
//            
//            CLog(@"lastestversion %@", response);
//            NSString *newVersion = (NSString *)response;
//            _lastestVersion = newVersion;
//            
//            NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            
//            if (![localVersion isEqualToString:_lastestVersion]) {
//                
//                //改变文字显示
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
//                });
//            }
//        }
//    }];
//    
//    return @"";
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
    {
        return 4;
    }
    else if(section==2)
    {
        return 3;
    }
    return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGFloat height = 10.0;
//    if (section == 0)
//    {
//        height = 20.0;
//    }
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, height)];
//    if (section == 0)
//    {
//        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, WIDTH_OF_SCREEN, 1)];
//        topLine.text = @"";
//        [topLine setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]];
//        [self.tableView addSubview:topLine];
//        [backView addSubview:topLine];
//    }
//    return backView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return GTFixHeightFlaot(12);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return GTFixHeightFlaot(66.0);
    }else{
        return GTFixHeightFlaot(42.0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        SetUserTableViewCell* cell;
        cell = [tableView dequeueReusableCellWithIdentifier:SetUserTableViewCellIdentifier forIndexPath:indexPath];
        if (!cell)
        {
            cell = [[SetUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetUserTableViewCellIdentifier];
            for (UIView* view in cell.contentView.subviews) {
                view.frame = GetFramByXib(view.frame);
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            
        }

        
        cell.cellTitle.font = [UIFont systemFontOfSize:GTFixHeightFlaot(15)];
        cell.loginlabel.font =[UIFont systemFontOfSize:GTFixHeightFlaot(14)];
        cell.cellExitBtn.titleLabel.font =[UIFont systemFontOfSize:GTFixHeightFlaot(16)];
        
        [cell.cellExitBtn addTarget:self action:@selector(exitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.leftloginbtn addTarget:self action:@selector(loginbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightResignbtn addTarget:self action:@selector(resignbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.userButton addTarget:self action:@selector(userButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
        UIButton* button =(UIButton*)[cell.contentView viewWithTag:555];
        if (!button) {
            button  =[ UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame: CGRectMake(0, 0, WIDTH_OF_SCREEN/2, cell.cellTitle.width+cell.userImg.width)];
            [button addTarget:self action:@selector(userButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 555;
            [cell.contentView addSubview:button];
        }
        if ([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        {
            
//            realName = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
            
//            if([realName isEqualToString:@""] || realName == nil)
//            {
//                realName = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.mobile; //@"紫马用户";
//            }
//            if (realName.length == 11) {
//                NSMutableString* mutbName = [NSMutableString stringWithString:realName];
//                [mutbName replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//                realName = mutbName;
//            }
            //用户头像加载
            NSString *imagePath = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.avartar;
            //http://192.168.3.20/headImg/0be31d81-e183-438f-9f13-51325af86047.png
           // http://192.168.3.20/headImg/22db535c-a276-4f29-930b-add39cb5c4bb.png
            NSURL *imageUrl = [NSURL URLWithString:imagePath];
            
            [cell.cellTitle setText:realName];
            CLog(@"%@",imagePath);
            [cell.userImg sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxian"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"unlockUserImg"];
            [[NSUserDefaults standardUserDefaults] setObject:realName forKey:@"unlockUserName"];

            cell.leftloginbtn.hidden = YES;
            cell.rightResignbtn.hidden = YES;
            cell.loginlabel.hidden = YES;
            cell.cellExitBtn.hidden = NO;
            cell.userImg.userInteractionEnabled = YES;
            cell.cellTitle.userInteractionEnabled = YES;
            CLog(@"%@",cell.cellTitle.text);
        }
        else
        {
            [cell.userImg setImage:[UIImage imageNamed:@"touxian"]];
            cell.cellTitle.text = @"请您登录或者注册";
            cell.leftloginbtn.hidden = NO;
            cell.rightResignbtn.hidden = NO;
            cell.loginlabel.hidden = NO;
            cell.cellExitBtn.hidden = YES;
        }
        
        [ZMAdminUserStatusModel shareAdminUserStatusModel].userUpdatedBaseInfo = ^(ZMAdminUserBaseInfo *userBaseInfo){
            
           /* if ([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]) {
                
                NSString *realName = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
                
                if([realName isEqualToString:@""] || realName == nil)
                {
                    realName = @"紫马用户";
                }
                
                if (realName.length == 11) {
                    NSMutableString* mutbName = [NSMutableString stringWithString:realName];
                    [mutbName replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                    realName = mutbName;
                }
                
                //用户头像加载
                NSString *imagePath = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.avartar;
                
                NSURL *imageUrl = [NSURL URLWithString:imagePath];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [cell.cellTitle setText:realName];
                    
//                    [cell.headerButton sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatarHeader.png"]];
                    cell.leftloginbtn.hidden = YES;
                    cell.rightResignbtn.hidden = YES;
                    cell.loginlabel.hidden = YES;
                });
            }
            else
            {
                cell.cellTitle.text = @"请您登录或者注册";
                cell.cellExitBtn.hidden = YES;
            }
            */
        };
        
        return cell;

    }
    else {

        SetotherTableViewCell* cell;

        cell = [tableView dequeueReusableCellWithIdentifier:SetotherTableViewCellIdentifier forIndexPath:indexPath];
        if (!cell)
        {
            cell = [[SetotherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetotherTableViewCellIdentifier];
            for (UIView* view in cell.contentView.subviews) {
                view.frame = GetFramByXib(view.frame);
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (indexPath.section == 1 &&indexPath.row == 2) {

          
            if (!switchButtonss) {
                switchButtonss = [[SevenSwitch alloc] initWithFrame:CGRectMake(cell.contentView.width - 65, 0, 50, 27)];
                switchButtonss.center = CGPointMake(switchButtonss.frame.origin.x + 25,cell.contentView.height/2);
                switchButtonss.onColor = [UIColor colorWithRed:227/225.0 green:82/255.0 blue:66/255.0 alpha:1.00f];
                switchButtonss.inactiveColor = [UIColor whiteColor];
                [switchButtonss addTarget:self action:@selector(settingGesturePatternLock:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:switchButtonss];
                NSString *patternLockPassword = [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
                patternSwitchButton = switchButtonss;
                if ([patternLockPassword length] >= 3)
                {
                    [switchButtonss setOn:YES animated:NO];
                }
                

            }
        }
        if (indexPath.section == 1 &&indexPath.row == 3) {
            
            if (!switchButtonts) {
                switchButtonts = [[SevenSwitch alloc] initWithFrame:CGRectMake(cell.contentView.width - 65, 0, 50, 27)];
                switchButtonts.center = CGPointMake(switchButtonts.frame.origin.x + 25,cell.contentView.height/2);
                switchButtonts.onColor = [UIColor colorWithRed:227/225.0 green:82/255.0 blue:66/255.0 alpha:1.00f];
                switchButtonts.inactiveColor = [UIColor whiteColor];
                [switchButtonts addTarget:self action:@selector(offTuisong:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:switchButtonts];

            }
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            BOOL resive = [accountDefaults boolForKey:NotificationCenterKey];
            
            BOOL sysCan;
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
                if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == 0) {
                    sysCan = NO;
                }else
                    sysCan = YES;
            }else if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
                
                if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == 0) {
                    sysCan = NO;
                }else{
                    sysCan = YES;
                }
            }
            if (sysCan && resive) {
                [switchButtonts setOn:resive animated:NO];
            }else{
                [switchButtonts setOn:NO animated:NO];
            }
        }

        UIImage* image =[UIImage imageNamed:[cellImageAry objectAtIndex:(indexPath.row+(indexPath.section-1)*4)]];
        cell.cellImage.image = image;
//        cell.cellImage.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//        cell.cellImage.center = CGPointMake(33, 21);
        cell.cellTitle.text = [cellTitleAry objectAtIndex:(indexPath.row+(indexPath.section-1)*4)];
        cell.cellTitle.font = [UIFont systemFontOfSize:GTFixHeightFlaot(14.0)];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if(indexPath.section == 1 &&indexPath.row == 2)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if(indexPath.section == 1 &&indexPath.row == 3)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;

    }
    
}
-(void)userButtonClcik:(UIButton*)sender{
    
    if ([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消操作"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"更改个人头像", nil];
        //                                                otherButtonTitles:@"更改个人头像", @"更改个人资料", nil];
        [actionSheet showInView:self.view];
    
    }
    
}
-(void)exitBtnClick:(UIButton*)sender{
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"亲，确定退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.tag = ALERTVIEW_TAG_SIGN_OUT;
        [alter show];
    }
    else
    {
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    }
}
-(void)loginbtnClick:(UIButton*)sender{
    
    /*
     * 判断是否已经登陆
     */
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        return;
    
    CLog(@"startLoginAction");
    
    ZMLogInLogOutViewController * LILO = [[ZMLogInLogOutViewController alloc] init];
//    ZMNavigationController * nav = [[ZMNavigationController alloc] initWithRootViewController:LILO];
//    nav.navigationBarHidden = YES;
//    [self presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:LILO animated:YES];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

//    isShowingLoginView = YES;
//    [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
//    [self resetBackImageViewFrame];
}
-(void)resignbtnClick:(UIButton*)sender{
    /*
     * 判断是否已经登陆
     */
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        return;
    
    CLog(@"startRegisterAction");
//    isShowingLoginView = YES;
    //    [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    
//    [[ZMAdminUserStatusModel shareAdminUserStatusModel] popRegisterVCWithCurrentViewController:self];
//    [self resetBackImageViewFrame];

    ZMRegisterInViewController * LILO2 = [[ZMRegisterInViewController alloc] initWithNibName:@"ZMRegisterInViewController" bundle:nil];
    
//    ZMNavigationController * nav = [[ZMNavigationController alloc] initWithRootViewController:LILO2];
//    nav.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:LILO2 animated:YES];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

//    [self presentViewController:LILO2 animated:YES completion:nil];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        return;
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
                [[HUD sharedHUDText] showForTime:2.0 WithText:@"世界上最遥远的距离是您没有登录"];
                return;
            }
            ZMSafeSettingsViewController * next = [[ZMSafeSettingsViewController alloc]init];
            [self.navigationController pushViewController: next animated:YES];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

            
        }
        if (indexPath.row == 1)
        {
            if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
                [[HUD sharedHUDText] showForTime:2.0 WithText:@"世界上最遥远的距离是您没有登录"];
                return;
            }
            
//            银行卡管理
            BankCardViewController * next = [[BankCardViewController alloc]init];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
            
            [self.navigationController pushViewController: next animated:YES];

        }
        if (indexPath.row == 3)
        {
            /*if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
                [[HUD sharedHUDText] showForTime:2.0 WithText:@"世界上最遥远的距离是您没有登录"];
                return;
            }
            PayPassWordController* pay = [[PayPassWordController alloc] init];
            [self.navigationController pushViewController:pay animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

            //支付密码
           */
        }
        if (indexPath.row == 2)
        {
//            //手势密码
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            //帮助中心
            HelpViewController* help = [[HelpViewController alloc] init];
            [self.navigationController pushViewController:help animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];


        
        }
        if (indexPath.row == 1)
        {
            //意见反馈
            if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
                [[HUD sharedHUDText] showForTime:2.0 WithText:@"世界上最遥远的距离是您没有登录"];
                return;
            }

            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
            [self.navigationController pushViewController:[[iDearViewController alloc] init] animated:YES];
//            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4000866106"];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
           
        }
        if (indexPath.row == 2)
        {
            aboutMeViewController* about = [[aboutMeViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
        }
        if (indexPath.row == 3)
        {
            //版本更新
            //版本更新
            
//            NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            
//            if (![_lastestVersion isEqualToString:localVersion]) {
//                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"有新版本发布啦，现在就去更新吧！" delegate:self cancelButtonTitle:@"遗憾地放弃" otherButtonTitles:@"果断更新", nil];
//                alter.tag = ALERTVIEW_TAG_UPDATE_VERSION;
//                [alter show];
//                alter=nil;
//            }
//            else{
//                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                [HUD setLabelText:@"暂无新版本"];
//                [HUD hide:YES afterDelay:1.0];
//            }

        }
    }
}


-(void)updateSettingTableView
{
    [self.tableView reloadData];
}


#pragma  mark   ---------- 手势密码的设置和取消 ------------

-(void)offTuisong:(id)sender{
    SevenSwitch* button = (SevenSwitch*)sender;
    if (button.on) {
        
        BOOL sysCan;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
            if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == 0) {
                sysCan = NO;
            }else{
                sysCan = YES;

            }
        }else if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
            
            if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == 0) {
                sysCan = NO;
            }else{
                sysCan = YES;
            }
        }
        [button setOn:sysCan animated:YES];
        if (!sysCan) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您可以按设置-通知-财行家-允许通知步骤打开通知哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }else{
            [button setOn:YES animated:YES];
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            [accountDefaults setBool:YES forKey:NotificationCenterKey];
        }
       }else{
            [button setOn:NO animated:YES];
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            [accountDefaults setBool:NO forKey:NotificationCenterKey];
    }
}
-(void)settingGesturePatternLock:(id)sender
{
    if(![[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"世界上最遥远的距离是您没有登录"];
        [patternSwitchButton setOn:NO animated:YES];
        return;
    }

    NSString *patternLockPassword = [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
    if ([patternLockPassword length] >= 3)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关闭手势密码？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = ALERTVIEW_TAG_CLOSE_PATTERN;
        [alertView show];
        
        return;
    }
    else
    {
        PatternLockViewController *next = [[PatternLockViewController alloc]init];
        
        next.hasPatternSettedBlock = ^(BOOL hasSetted){
            CLog(@"手势密码=== %@", hasSetted? @"密码设置成功": @"密码设置成功");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (hasSetted) {
                    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                }else{
                    [patternSwitchButton setOn:NO animated:NO];

                }
               
            });
        };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
        [self.navigationController pushViewController: next animated:YES];
    }
}

//进行手势密码设置／解除
-(void)startDealWithPattern
{
    //ALERTVIEW_TAG_CLOSE_PATTERN
    NSString *patternLockPassword = [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
    if ([patternLockPassword length] >= 3)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关闭手势密码？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = ALERTVIEW_TAG_CLOSE_PATTERN;
        [alertView show];
        
        return;
    }
    else
    {
        PatternLockViewController *next = [[PatternLockViewController alloc]init];
        
        next.hasPatternSettedBlock = ^(BOOL hasSetted){
            CLog(@"手势密码=== %@", hasSetted? @"密码设置成功": @"密码设置成功");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (hasSetted) {
                    [patternSwitchButton setOn:NO animated:NO];
                }else{
                    [patternSwitchButton setOn:YES animated:NO];

                }

                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            });
        };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];

        [self.navigationController pushViewController: next animated:YES];
    }
}

#pragma mark-----UIImagePickerController------------------

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"上传中..."];
    
    [[ZMServerAPIs shareZMServerAPIs] SendiUserIconWithUserIcon:originImage  Success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz hide:YES afterDelay:1.0];
            NSIndexPath* index  = [NSIndexPath indexPathForRow:0 inSection:0];
            SetUserTableViewCell* cell = (SetUserTableViewCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell.userImg setImage:originImage];

        });

        CLog(@"发送用户头像成功 OK ＝ %@", response);
        
        //刷新首页项目数据
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"请重试"];
            [HUDjz hide:YES afterDelay:1.0];
        });

        CLog(@"发送用户头像失败 OK ＝ %@", response);
    }];
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        originImage=[self rotateImage:originImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        //        [self.textView becomeFirstResponder];
        //        [self.deleteImageButton setTitle:@"删除图片" forState:UIControlStateNormal];
        //        isHadImage=YES;
    }];
//

    
}

- (UIImage*)rotateImage:(UIImage *)image
{
    int kMaxResolution = 320; // Or whatever
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //        [self.textView becomeFirstResponder];
        
    }];
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
-(UIImage *)newCreateImage:(UIImage*)imge withSize:(CGSize)Size{
    UIGraphicsBeginImageContext(Size);
    [imge drawInRect:CGRectMake(0, 0, Size.width, Size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)userPhontoImage{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"照相机", nil];
    alter.tag = ALERTVIEW_TAG_USER_IMG;
    [alter show];
    alter=nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self userPhontoImage];
    }
    //    else if (buttonIndex == 1)
    //    {
    //        UIStoryboard * ModifyUserInfo = [UIStoryboard storyboardWithName:@"ModifyUserInfoA" bundle:nil];
    //
    //        AModifyUserInfoViewController *userInfoVC = [ModifyUserInfo instantiateViewControllerWithIdentifier:@"AModifyUserInfoViewController"];
    //
    //        ZMNavigationController *nav = [[ZMNavigationController alloc] initWithRootViewController:userInfoVC];
    //        [self presentViewController:nav animated:YES completion:nil];
    //    }
    //    else if (buttonIndex == 2)
    //    {
    //        CLog(@"取消");
    //    }
}


#pragma  mark   -----------------UIAlertView Delegate-----------------

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //下载更新 App
//    if (alertView.tag == ALERTVIEW_TAG_UPDATE_VERSION){
//        if (buttonIndex == 1) {
//
//            //企业发布模式
//            if(EnterpriseDistributeModel == 1)
//            {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pgyer.com/evZ9"]];
//            }
//            else
//            {
//                [[UIApplication sharedApplication] openURL:APPSTORE_URL];
//            }
//        }
//    }
    
    if (alertView.tag == ALERTVIEW_TAG_SIGN_OUT) {
        CLog(@"%ld", buttonIndex);
        
        if (buttonIndex == 0){
            return;
        }
        if (buttonIndex == 1)
        {
            [[ZMAdminUserStatusModel shareAdminUserStatusModel] setLoggedStatus:NO];
            
            //重新刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_SETTING_VIEW_NOTIFICATION_NAME object:nil];
            
            //改变用户登录状态（刷新主菜单）
            [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_BSAE_USER_INFO_SUCCESS_NOTIFICATION_NAME object:nil];
            [patternSwitchButton setOn:NO animated:YES];
        }
    }
    
    /*
     * 刷新手势密码设置项目
     */
    if (alertView.tag == ALERTVIEW_TAG_CLOSE_PATTERN) {
        if (buttonIndex == 0){
            CLog(@"%ld", buttonIndex);

            dispatch_async(dispatch_get_main_queue(), ^{
                [patternSwitchButton setOn:YES animated:NO];
            });
        }
        if (buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_PatternPassword];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            });
        }
    }
    
    //检查是否是真实用户
    if (alertView.tag == ALERTVIEW_TAG_CHECK_USER_PATTERN) {
        if (buttonIndex == 0){
            CLog(@"%ld", buttonIndex);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (isPatternSwitchButtonOn) {
                    [patternSwitchButton setOn:YES animated:NO];
                }
                else
                {
                    [patternSwitchButton setOn:NO animated:NO];
                }
            });
            
            return;
        }
        
        if (buttonIndex == 1)
        {
            UITextField *textInput = [alertView textFieldAtIndex:0];
            
            CLog(@"textInput.text = %@", textInput.text);
            
            [[ZMServerAPIs shareZMServerAPIs] checkWhetherIsTheAdminUser:textInput.text success:^(id response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    {"message":"密码验证成功","code":1000}
                    CLog(@"验证成功 = %@", response);
                    
                    [self startDealWithPattern];
                });
                
            } failure:^(id response) {
                dispatch_async(dispatch_get_main_queue(), ^{

                    if (isPatternSwitchButtonOn) {
                        [patternSwitchButton setOn:YES animated:NO];
                    }
                    else
                    {
                        [patternSwitchButton setOn:NO animated:NO];
                    }
                    
                    CLog(@"验证失败 = %@", response);
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"验证失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                });
            }];
        }
    }
    if (alertView.tag == ALERTVIEW_TAG_USER_IMG) {
        if (buttonIndex==1) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.sourceType = sourceType;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
        }
        else if (buttonIndex==2){
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.sourceType = sourceType;
            picker.allowsEditing=YES;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
        }
    }
}

#pragma mark - FTPManager delegate ------- ------- ------- -------
- (void)ftpDownloadFinishedWithSuccess:(BOOL)success
{
    if (!success)
    {
        //handle your error
    }
}
-(void)ftpError:(NSString *)err
{
    //handle your error
    CLog(@"123");
}

-(void)directoryListingFinishedWithSuccess:(NSArray *)arr
{
    //use the array the way you need it
    CLog(@"123");
}

- (void)ftpUploadFinishedWithSuccess:(BOOL)success
{
    if (!success)
    {
        //handle your error
    }
}

@end
