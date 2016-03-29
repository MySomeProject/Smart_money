//
//  AssetManagementViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetManagementViewController.h"
#import "ZMAdminUserStatusModel.h"
#import "ZMServerAPIs.h"
#import "ZMAdminUserAssert.h"

 /*
 {
 "userPointVO":{"amount":10514.89,"availablePoints":8092.65,"waittingPrincipal":2422.24,"frozenPoints":0.0},
 
 "userProfitVo":{"totalAlreadyProfit":16.41,
 "totalWaitingProfit":560.27,
 "alreadyProfits":[{"amount":352.5,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
 {"amount":207.77,"productName":"PRODUCT","displayProductName":"紫贷宝"}],
 
 "waittingProfits":[{"amount":352.5,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
 {"amount":207.77,"productName":"PRODUCT","displayProductName":"紫贷宝"}]
 },
 
 "userInvestVO":{"amount":6600.0,
 "invsetAmouts":[{"amount":100.0,"productName":"RIZIBAO","displayProductName":"日紫宝"},
 {"amount":4000.0,"productName":"INVEST_PRODUCT","displayProductName":"紫定盈"},
 {"amount":2500.0,"productName":"PRODUCT","displayProductName":"紫贷宝"}]
 }
 },
 */


@interface AssetManagementViewController ()

@end

@implementation AssetManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)refreshCell
{
    [_assetInfoTableViewCell setValueByModel];
    [_assetDistributeTableViewCell setValueByModel];
    [_incomeDistributeTableViewCell setValueByModel];
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

- (void)createView{
    self.dataArray = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",
                                       @"黄岩岛",nil];
    [self.view setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    _assetManagementTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 435)];
    [_assetManagementTabelView setScrollEnabled:NO];
    if ([UIScreen mainScreen].bounds.size.height - 60 < 435) {
        [_assetManagementTabelView setFrame:CGRectMake(0, 60, _assetManagementTabelView.frame.size.height, [UIScreen mainScreen].bounds.size.height - 60)];
        [_assetManagementTabelView setScrollEnabled:YES];
    }
    [_assetManagementTabelView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 435)];
    [_assetManagementTabelView setDataSource:self];
    [_assetManagementTabelView setDelegate:self];
    _assetManagementTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_assetManagementTabelView];
    UIImageView *slideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _assetManagementTabelView.frame.origin.y - 1, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [slideView setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
    [self.view addSubview:slideView];
    
    
    if (![ZMAdminUserStatusModel shareAdminUserStatusModel]||![ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert.userInvestVO)
    {
        if ([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn])
        {
            if (![ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert) {
                [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert = [[ZMAdminUserAssert alloc] init];
            }
            //请求数据
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            progressHUD.delegate = self;
            progressHUD.mode = MBProgressHUDModeIndeterminate;
            progressHUD.animationType = MBProgressHUDAnimationFade;
            [progressHUD setLabelText:@"数据加载中..."];
            
            [[ZMServerAPIs shareZMServerAPIs] getUserAssertSuccess:^(id response){
                NSDictionary *dataDic = [response valueForKey:@"data"];
                [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert.userPointVO = [dataDic valueForKey:@"userPointVO"];
                [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert.userProfitVo = [dataDic valueForKey:@"userProfitVo"];
                [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert.userInvestVO = [dataDic valueForKey:@"userInvestVO"];
                dispatch_async(dispatch_get_main_queue(), ^(){
                    progressHUD.tag = 2001;
                    [progressHUD hide:YES afterDelay:0];
                    [self refreshCell];
                });
            }
            failure:^(id response){
                
                CLog(@"数据加载中 %@", response);
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAssert = nil;
                    progressHUD.tag = 2001;
                    [progressHUD setLabelText:@""];
                    [progressHUD hide:YES afterDelay:0];
                });
            }];
        }
    }
    else
    {
        [self refreshCell];
    }
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        if (!_assetInfoTableViewCell){
            _assetInfoTableViewCell = [[AssetInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"assetInfo"];
            [_assetInfoTableViewCell setModel:self.dataArray[indexPath.row]];
        }
        return _assetInfoTableViewCell;
    }
    else if (indexPath.row == 1){
        if (!_assetDistributeTableViewCell){
             _assetDistributeTableViewCell = [[AssetDistributeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"assetDis"];
        }
        return _assetDistributeTableViewCell;
    }
    else if (indexPath.row == 2){
        if (!_incomeDistributeTableViewCell) {
            _incomeDistributeTableViewCell = [[IncomeDistributeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeDis"];
        }
        return _incomeDistributeTableViewCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0||indexPath.row == 1){
        return 165;
    }
    else if (indexPath.row == 2){
        return 105;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        if (!self.assetInfoViewController)
        {
            self.assetInfoViewController = [[AssetInfoViewController alloc] initWithNibName:@"AssetInfoViewController" bundle:nil];
            self.assetInfoViewController.title = @"资产详情";
        }
        [self.navigationController pushViewController:self.assetInfoViewController animated:YES];
    }
    else if (indexPath.row ==1)
    {
        self.assetDisTableViewController = [[AssetDisTableViewController alloc] init];
        self.assetDisTableViewController.title = @"投资分布";
        [self.navigationController pushViewController:self.assetDisTableViewController animated:YES];
    }
    else
    {
        if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
        {
            self.incomeViewController = [[IncomeViewController alloc] initWithNibName:@"IncomeView5" bundle:nil];
        }
        else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
        {
             self.incomeViewController = [[IncomeViewController alloc] initWithNibName:@"IncomeView6" bundle:nil];
        }
        else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
        {
            self.incomeViewController = [[IncomeViewController alloc] initWithNibName:@"IncomeView6Plus" bundle:nil];
        }
        self.incomeViewController.title = @"收益分布";
        [self.navigationController pushViewController:self.incomeViewController animated:YES];
    }
}
@end
