//
//  BankCardTableViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankCardTableViewController.h"

#import "AddBankCardViewController.h"

#import "BankCardInfoCell.h"
#import "AddBankCardCell.h"
#import "NextStepTableViewCell.h"
#import "RechargeViewController.h"

static NSString * reuseIndentifier = @"reuseIdentifier";
static NSString * addCardReuseIndentifier = @"addCardReuseIndentifier";
static NSString * nextStepReuseIndentifier = @"nextStepReuseIndentifier";

@interface BankCardTableViewController ()
{
    NSMutableArray * bankCardArray;
    
    //充值选中银行卡
    NSDictionary *selectedUserBankInfo;
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
    [[ZMServerAPIs shareZMServerAPIs] getUserBankListForWithdraw:NO Success:^(id response)
    {
        CLog(@"用户银行卡列表：success = %@", response);
        
         NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];
        
        if ([ZMTools isNullObject:tempBankCardArray]) {
            
            CLog(@"银行卡数据为空");
            
            return ;
        }
        
        [self packagingUserBankList:tempBankCardArray];
        
        
        /*
         {
             branchName = "<null>";
             cardName = "\U4e2d\U56fd\U5efa\U8bbe\U94f6\U884c";
             cardNumber = 6217003810007667994;
         default = 1;
             id = 61;
             imgPath = "";
         }
         */
        
        /*
        {
            cardName = "\U4e2d\U56fd\U5efa\U8bbe\U94f6\U884c";
            cardNumber = 6217003810007667994;
        default = 1;
            id = 233;
            imgPath = "";
        }
         */
        
        /*
         {
             cardName = "\U4e2d\U56fd\U6c11\U751f\U94f6\U884c";
             cardNumber = 6217003810007667994cd;
             default = 0;
             id = 126;
             imgPath = "";
         },
         */
        
        /*
         success = {
         code = 1000;
         data =     
         {
             userBanks =         (
             {
                 cardNumber = 6217003810007667994;
                 default = 1;
                 id = 126;
                 imgPath = "";
             },
             {
                 cardNumber = 6221682092572192;
                 default = 0;
                 id = 133;
                 imgPath = "";
             }
         );
         };
         message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
         }

         */
    }
    failure:^(id response){
        CLog(@"用户银行卡列表：failed = %@", response);
        
        //银行卡清空
        if(bankCardArray)
        {
            CLog(@"bankCardArray = %@", bankCardArray);
            [bankCardArray removeAllObjects];
            bankCardArray = [[NSMutableArray alloc] init];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        });
        
        
//        {"message":"没有找到符合条件的数据","code":4003}
        
        if([[response objectForKey:@"code"] integerValue] == 4003)
        {
            CLog(@"%@", [response objectForKey:@"message"]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
                        [cell.nextStepButton setBackgroundColor:[UIColor colorWithRed:236/255.0 green:46/255.0 blue:144/255.0 alpha:1.0]];
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
            
            
            NSLog(@"selectedcell%ld%@",indexPath.row,self.selectedCell);
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
