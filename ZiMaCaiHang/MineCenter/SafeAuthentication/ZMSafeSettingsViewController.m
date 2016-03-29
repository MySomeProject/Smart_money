//
//  ZMSafeSettingsViewController.m
//  ZMSD
//
//  Created by zima on 14-12-18.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMSafeSettingsViewController.h"

#import "ZMSafeSettingCell.h"

#import "ZMNikeNameSettingViewController.h"
#import "ZMRealNameSettingViewController.h"
#import "ZMPhoneNumberSettingViewController.h"
#import "ZMEmailSettingViewController.h"
#import "ZMEmailVerifyCodeViewController.h"

#import "ZMConfirmViewController.h"

//修改密码
#import "ModifyPasswordController.h"
#import "MobClick.h"
#define UPDATE_USER_INFO @"updateuserinfo"


typedef void(^MobileAuthenticationBlock)(BOOL isAuthentication);

@interface ZMSafeSettingsViewController ()
{
    ZMAdminUserStatusModel * adminUserInfoModel;
    
    BOOL isNikeNameAuthentication;
    BOOL isRealNameAuthentication;
    BOOL isMobileAuthentication;
    BOOL isEmailaAuthentication;
}
@property(nonatomic, strong)UITableView* tableView;
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define HEIGHTDOWN 64
@end

@implementation ZMSafeSettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"安全认证"];
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"安全认证"];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addreturnBtn];
    [self creatTableView];
    if (Version>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
        [self.tableView setOrigin:CGPointMake(self.tableView.left, self.tableView.top+HEIGHTDOWN)];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatetableview) name:UPDATE_USER_INFO object:nil];

    isNikeNameAuthentication = NO;
    
    isRealNameAuthentication = NO;
    
    isMobileAuthentication = NO;
    
    isEmailaAuthentication = NO;
    
    self.title = @"安全设置";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
    [tableHeader setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = tableHeader;
    [self.tableView setBackgroundColor:Color_For_Main_LightGray];
    

    adminUserInfoModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    
    
    //注册nib
    UINib *nib = [UINib nibWithNibName:@"ZMSafeSettingCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
-(void)updatetableview{
    [self.tableView reloadData];
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

-(void)addreturnBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 25);
    [btn setImage:[UIImage imageNamed:@"DetailBackButton"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = returnItem;
}
-(void)returnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义的cell(纯代码书写)
    static NSString * reuseIndentifier = @"reuseIdentifier";
    ZMSafeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZMSafeSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.bottomLongLine.hidden = YES;
    
    NSString *classTitle;
    NSString *statusTitle;
    switch (indexPath.row) {
        case 0:
            classTitle = @"实名认证";
            if (!adminUserInfoModel.idCardValidated)
            {
                statusTitle = @"未认证";
                
                if (isRealNameAuthentication) { //认证成功的后刷新重置
                    statusTitle = @"已认证";
                }
            }
            else
            {
//                statusTitle = @"已认证";
                
//                adminUserInfoModel.adminuserBaseInfo.idCard;
//                adminUserInfoModel.adminuserBaseInfo.realname;
                statusTitle = [ZMTools hideRealName:adminUserInfoModel.adminuserBaseInfo.realname];
            }
            
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = NO;
            cell.bottomLongLine.hidden = YES;
            
            break;
            
        case 1:
            classTitle = @"登录密码";
            
//            if ([adminUserInfoModel.nickName isEqualToString:@""] || adminUserInfoModel.nickName == nil)
//            {
//                statusTitle = @"";
//                
//                if (isNikeNameAuthentication) { //认证成功的后刷新重置
//                   statusTitle = @"";
//                }
//            }
//            else
//            {
//                statusTitle = @"已认证";
//            }
            statusTitle = @"修改密码";
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = YES;
            break;
            
        case 2:
            classTitle = @"绑定手机";
            if (!adminUserInfoModel.mobileValidated)
            {
                statusTitle = @"未认证";
                if (isMobileAuthentication) { //认证成功的后刷新重置
                    statusTitle = @"已认证";
                }
            }
            else
            {
                statusTitle = [ZMTools hideString:adminUserInfoModel.adminuserBaseInfo.mobile];
            }
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = YES;
            break;
            
        case 3:
            classTitle = @"绑定邮箱";
            if (!adminUserInfoModel.emailValidated)
            {
                statusTitle = @"未认证";
//                if (isMobileAuthentication) { //认证成功的后刷新重置
//                    statusTitle = @"已认证";
//                }
            }
            else
            {
                statusTitle = [ZMTools hideString:adminUserInfoModel.adminuserBaseInfo.email];
            }
            cell.bottomLine.hidden = YES;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = NO;
            break;
            
        default:
            break;
    }
    
    
    cell.leftClassTitleLabel.text = classTitle;
    cell.statusLabel.text = statusTitle;
    
    
    
//    [cell.bottomLine setFrame:CGRectMake(0, cell.frame.size.height - 0.5, WIDTH_OF_SCREEN, 0.5)];
    
//    [cell.leftClassTitleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//    [cell.leftClassTitleLabel setTextColor:[UIColor grayColor]];

    
    
//    CLog(@"cell.frame = %@", NSStringFromCGRect(cell.frame));
//    [cell.lineLabel setFrame:CGRectMake(0, cell.frame.size.height - 0.5, WIDTH_OF_SCREEN, 0.5)];
//    [cell.lineLabel setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ceil(50 * Ratio_OF_WIDTH_FOR_IPHONE6);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ZMRealNameSettingViewController * next = [[ZMRealNameSettingViewController alloc] init];
            if ([[ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.idCard isEqualToString:@""])
            {
                next.isAlreadyAuthen = NO;
            }
            else
            {
                next.isAlreadyAuthen = YES;
            }
            next.realNameAuthenticationBlock = ^(BOOL isAuthentication){
                if (isAuthentication) {
                    
                    isRealNameAuthentication = isAuthentication;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //刷新用户基本信息
                        [self updateAdminUserInfoAfterSafeSetting];
                    });
                }
            };
            
            [self.navigationController pushViewController:next animated:YES];
        }
            break;
        case 1:
        {
            ModifyPasswordController * next = [[ModifyPasswordController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
//            
//            if (!adminUserInfoModel.idCardValidated  && !isRealNameAuthentication)
//            {
//                ZMRealNameSettingViewController * next = [[ZMRealNameSettingViewController alloc] init];
//                
//                next.realNameAuthenticationBlock = ^(BOOL isAuthentication){
//                    if (isAuthentication) {
//                        isRealNameAuthentication = isAuthentication;
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                            
//                            [self updateAdminUserInfoAfterSafeSetting];
//                        });
//                    }
//                };
//                
//                [self.navigationController pushViewController:next animated:YES];
//            }
        }
            break;
        case 2:
        {
            if (adminUserInfoModel.mobileValidated && !isMobileAuthentication)
            {
                ZMPhoneNumberSettingViewController * next = [[ZMPhoneNumberSettingViewController alloc] init];
                
                [next mobileBlock:^(BOOL isAuthentition) {
                    
                    if (isAuthentition) {
                        CLog(@"手机认证成功");
                        isMobileAuthentication = isAuthentition;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self updateAdminUserInfoAfterSafeSetting];
                            CLog(@"手机认证成功 indexPath = %ld", indexPath.row);
                            
                            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            
                        });
                    }
                    else
                    {
                        CLog(@"手机认证失败");
                    }
                }];
                
                [self.navigationController pushViewController:next animated:YES];
            }
            else
            {
                ZMPhoneNumVerifyCodeViewController * next = [[ZMPhoneNumVerifyCodeViewController alloc] init];
                
                next.mobileAuthenticationBlock = ^(BOOL isAuthentition) {
                    
                    if (isAuthentition) {
                        CLog(@"手机认证成功");
                        isMobileAuthentication = isAuthentition;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            CLog(@"手机认证成功 indexPath = %ld", indexPath.row);
                            
                            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            
                            [self updateAdminUserInfoAfterSafeSetting];
                        });
                    }
                    else
                    {
                        CLog(@"手机认证失败");
                    }
                };
                next.changePhoneNum =^(NSString* phonenum){
                    [self.tableView reloadData];
                };
                
                [self.navigationController pushViewController:next animated:YES];
            }
        }
            break;
        case 3:
        {
            if (adminUserInfoModel.emailValidated && !isEmailaAuthentication)
            {
                ZMEmailSettingViewController * next = [[ZMEmailSettingViewController alloc] init];
                
                [next mobileBlock:^(BOOL isAuthentition) {
                    
                    if (isAuthentition) {
                        CLog(@"邮箱认证成功");
                        isEmailaAuthentication = isAuthentition;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            CLog(@"邮箱认证成功 indexPath = %ld", indexPath.row);
                            
                            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            
                            [self updateAdminUserInfoAfterSafeSetting];
                        });
                    }
                    else
                    {
                        CLog(@"邮箱认证失败");
                    }
                }];
            
                [self.navigationController pushViewController:next animated:YES];
            }
            else
            {
                ZMEmailVerifyCodeViewController * next = [[ZMEmailVerifyCodeViewController alloc] init];
                
                next.mobileAuthenticationBlock = ^(BOOL isAuthentition) {
                    
                    if (isAuthentition) {
                        CLog(@"邮箱认证成功");
                        isMobileAuthentication = isAuthentition;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            CLog(@"邮箱认证成功 indexPath = %ld", indexPath.row);
                            
                            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                            
                            [self updateAdminUserInfoAfterSafeSetting];
                        });
                    }
                    else
                    {
                        CLog(@"邮箱认证失败");
                    }
                };
                
                [self.navigationController pushViewController:next animated:YES];

            }
        }
            break;

        default:
            break;
    }
}

//有安全设置成功，即刻进行个人信息的同步
-(void)updateAdminUserInfoAfterSafeSetting
{
    [adminUserInfoModel updateUserBaseInfo];
}



@end
