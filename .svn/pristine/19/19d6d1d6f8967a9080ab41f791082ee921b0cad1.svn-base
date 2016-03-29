//
//  BankCardTableViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankCardTableViewController.h"

#import "AddBankCardViewController.h"
#import "ChangeBackViewController.h"
#import "BankCardInfoCell.h"
#import "AddBankCardCell.h"
#import "NextStepTableViewCell.h"
#import "RechargeViewController.h"
#import "HUD.h"
#import "GTCommontHeader.h"
#import "Reachability.h"
static NSString * reuseIndentifier = @"reuseIdentifier";
static NSString * addCardReuseIndentifier = @"addCardReuseIndentifier";
static NSString * nextStepReuseIndentifier = @"nextStepReuseIndentifier";

@interface BankCardTableViewController ()
{
    NSMutableArray * bankCardArray;
    
    //充值选中银行卡
    NSDictionary *selectedUserBankInfo;
    BOOL requestFaild;
    UILabel* xianelabel;
    UILabel* changelabel;
}
@end

@implementation BankCardTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*
     * 获取用户银行卡列表
     */
    [self getUserBankList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    requestFaild = NO;
    [self addreturnBtn];
    bankCardArray = [[NSMutableArray alloc] init];
    
    self.title = @"银行卡管理";
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
    [tableHeader setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = tableHeader;
    [self.tableView setBackgroundColor:Color_For_Main_LightGray];
    
    
    //注册nib
    UINib *nib = [UINib nibWithNibName:@"BankCardInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIndentifier];
    
    UINib *addNib = [UINib nibWithNibName:@"AddBankCardCell" bundle:nil];
    [self.tableView registerNib:addNib forCellReuseIdentifier:addCardReuseIndentifier];
    
    [self.tableView registerClass:[NextStepTableViewCell class] forCellReuseIdentifier:nextStepReuseIndentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

}
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    if([reach isReachable])
    {
//        if ([reach.currentReachabilityString isEqualToString:@"WiFi"]) {
                [self getUserBankList];
//        }
    }
    else
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"网络异常,请检查网络"];
    }
    
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
-(void)packagingUserBankList:(NSMutableArray *)userBankList
{
    bankCardArray = userBankList;
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        for(NSDictionary * singleUserBankInfo in bankCardArray)
        {
            if([[singleUserBankInfo objectForKey:@"default"] integerValue] == 1)
            {
                //选定默认
                selectedUserBankInfo = singleUserBankInfo;
            }
            
            /*
             {
             cardName = "\U4e2d\U56fd\U5efa\U8bbe\U94f6\U884c";
             cardNumber = 6217003810007667994;
             default = 1;
             id = 233;
             imgPath = "";
             }
             */
        }
        [self.tableView reloadData];
    });
}
/*
 * 获取用户银行卡列表
 */
- (void)getUserBankList
{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] getUserBankListForWithdraw:NO Success:^(id response)
    {

        requestFaild = NO;


        CLog(@"用户银行卡列表：success = %@", response);
        
         NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];
        
        if ([ZMTools isNullObject:tempBankCardArray]) {
            CLog(@"银行卡数据为空");
            return ;
        }
        [self packagingUserBankList:tempBankCardArray];
        if (!bankCardArray.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [changelabel removeFromSuperview];
                [HUDjz hide:YES afterDelay:1.0];
                if (!xianelabel) {
                    xianelabel = [[UILabel alloc] init];
                    [xianelabel setFrame:CGRectMake(WIDTH_OF_SCREEN/2,GTFixHeightFlaot(100) , WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN/8)];
                    xianelabel.text = @"银行限额说明";
                    xianelabel.textAlignment = NSTextAlignmentCenter;
                    xianelabel.textColor = [UIColor redColor];
                    [self.view addSubview:xianelabel];
                    
                    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setFrame:CGRectMake(WIDTH_OF_SCREEN/2,GTFixHeightFlaot(100) , WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN/8)];
                    [button addTarget:self action:@selector(toBankXiane) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:button];
                }
            });

        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDjz hide:YES afterDelay:1.0];
                self.tableView.scrollEnabled = NO;
                [xianelabel removeFromSuperview];
                if (!changelabel) {
                    changelabel = [[UILabel alloc] init];
                    changelabel.textAlignment = NSTextAlignmentCenter;
                    [changelabel setFrame:CGRectMake(0,GTFixHeightFlaot(100) , WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN/8)];
                    
                    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"如需换卡请点击更换银行卡"];
                    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str1.length-5,5)];
                    changelabel.attributedText = str1;
                    [self.view addSubview:changelabel];
                    
                    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setFrame:CGRectMake(WIDTH_OF_SCREEN/2,GTFixHeightFlaot(100) , WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN/8)];
                    [button addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:button];
                }
            });
        }
        
    }
    failure:^(id response){
        requestFaild = YES;
        CLog(@"用户银行卡列表：failed = %@", response);
        
       
        //银行卡清空
        if(bankCardArray)
        {
            CLog(@"bankCardArray = %@", bankCardArray);
            [bankCardArray removeAllObjects];
            bankCardArray = [[NSMutableArray alloc] init];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"网络异常"];
            [HUDjz hide:YES afterDelay:1.0];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        });
        
        
//        {"message":"没有找到符合条件的数据","code":4003}
        
        if([[response objectForKey:@"code"] integerValue] == 4003)
        {
            CLog(@"%@", [response objectForKey:@"message"]);
        }
    }];
}
-(void)toChange{
    ChangeBackViewController* change = [[ChangeBackViewController alloc] init];
    change.type =@"BANK_CHANGE";
    change.title = @"更换银行卡";
    [self.navigationController pushViewController:change animated:YES];
}
-(void)toBankXiane{
    ChangeBackViewController* change = [[ChangeBackViewController alloc] init];
    change.title = @"银行限额";
    change.type =@"BANK_LIMIT";
    [self.navigationController pushViewController:change animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(bankCardArray.count>0)
    {
        return bankCardArray.count;
    }
    else
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
                return bankCardArray.count;
            break;
            
        case 1:
                return 2;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
        {
            UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
            [tableHeader setBackgroundColor:[UIColor clearColor]];
            return tableHeader;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            BankCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[BankCardInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            }
            
            cell.topLine.hidden = YES;
            
            if(indexPath.row == 0)
            {
                cell.topLine.hidden = NO;
                cell.bottomLine.hidden = NO;
                cell.bottomLongLine.hidden = YES;
            }
            
            if(indexPath.row == (bankCardArray.count - 1))
            {
                cell.bottomLine.hidden = YES;
                cell.bottomLongLine.hidden = NO;
            }
            
            NSDictionary * userbankInfo = [bankCardArray objectAtIndex:indexPath.row];
            [[userbankInfo objectForKey:@"default"] boolValue];
            [userbankInfo objectForKey:@"id"];
            [userbankInfo objectForKey:@"imgPath"];
            
            //银行卡标记
            cell.leftBankTypeLogo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [userbankInfo objectForKey:@"cardName"]]];
            //银行名称
            cell.bankNameLabel.text = [userbankInfo objectForKey:@"cardName"];
            
            //银行卡
            NSString *bankCardNum = [userbankInfo objectForKey:@"cardNumber"];
            bankCardNum = [bankCardNum substringWithRange:NSMakeRange(bankCardNum.length - 4, 4)];
            cell.bankNumberLabel.text = [NSString stringWithFormat:@"尾号%@", bankCardNum];
            
            
            //是否是默认银行卡
            if ([[userbankInfo objectForKey:@"default"] boolValue] == YES)
            {
                cell.selectedImage.hidden = NO;
            }
            else
            {
                cell.selectedImage.hidden = YES;
            }
            
            
            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0)
            {
                AddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:addCardReuseIndentifier forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[AddBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addCardReuseIndentifier];
                }
                
                cell.topLine.hidden = NO;
                cell.bottomLine.hidden = YES;
                cell.bottomLongLine.hidden = NO;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            
            /*
             *
             *
             *   充值按钮
             *
             */
            else
            {
                NextStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nextStepReuseIndentifier forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[NextStepTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nextStepReuseIndentifier];
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (self.isRechargeView)
                {
                    [cell isHiddenNextButton:NO];
                    
                    //用户银行卡数量大于0张，充值按钮有响应
                    if ([bankCardArray count] > 0) {
                        cell.nextStepButton.enabled = YES;
                        [cell.nextStepButton setBackgroundColor:UIColorFromRGB(0xDA3B33)];
                    }
                    else
                    {
                        cell.nextStepButton.enabled = NO;
                        [cell.nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
                    }
                }
                else
                {
                    [cell isHiddenNextButton:YES];
                }
                
                __weak BankCardTableViewController *weakself = self;
                if (!self.rechargeViewController)
                {
                    self.rechargeViewController = [[RechargeViewController alloc]init];
                    self.rechargeViewController.title = @"充值";
                }
                
                //充值
                cell.showRechargeBlock = ^()
                {
                    //选中用户充值银行卡
                    CLog(@"传值：被选中充值的银行卡是 = %@", selectedUserBankInfo);
                    self.rechargeViewController.selectedBankInfo = selectedUserBankInfo;
                    [weakself.navigationController pushViewController:self.rechargeViewController animated:YES];
                };
                return cell;
            }
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return ceil(10 * Ratio_OF_WIDTH_FOR_IPHONE6);
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return ceil(78 * Ratio_OF_WIDTH_FOR_IPHONE6);
            break;
            
        case 1:
            return ceil(48 * Ratio_OF_WIDTH_FOR_IPHONE6);
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
//            进入银行卡详情页面
           self.selectedCell = (BankCardInfoCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            
            CLog(@"selectedcell%ld%@",indexPath.row,self.selectedCell);
            if (self.isRechargeView)
            {
                [self.selectedCell showSelectedImage];
                
                //选中银行
                
                selectedUserBankInfo = [bankCardArray objectAtIndex:indexPath.row];
            }
        }
            break;
            
            
            //添加
        case 1:
        {
            if (requestFaild) {
                [[HUD sharedHUDText] showForTime:2.0 WithText:@"网络异常,请稍后再试"];
                return;
            }
            AddBankCardViewController * next = [[AddBankCardViewController alloc] init];
            [self.navigationController pushViewController: next animated:YES];
        }
            break;
            
        default:
            break;
    }
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
