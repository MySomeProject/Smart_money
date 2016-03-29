//
//  BankCardViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/9/1.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankCardViewController.h"
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
@interface BankCardViewController (){
    NSMutableArray * bankCardArray;
    //充值选中银行卡
    NSDictionary *selectedUserBankInfo;
    BOOL requestFaild;
    UILabel* xianelabel;
    UILabel* changelabel;
    UITableView* _tableview;
    BOOL isFaild;
}

@end

@implementation BankCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
     * 获取用户银行卡列表
     */
    [self getUserBankList];
}
-(void)addRightNavBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,GTFixWidthFlaot(60),GTFixHeightFlaot(20));
    btn.titleLabel.font = [UIFont systemFontOfSize:GTFixWidthFlaot(12)];
    if (HEIGHT_OF_SCREEN<600) {
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 25);
    [btn setTitle:@"银行限额" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBankXiane) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = returnItem;
}
-(void)creattableview{

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN-75-64) style:UITableViewStylePlain];
    //    _tableview.layer.cornerRadius= 6;
    //    _tableview.layer.masksToBounds = YES;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundView = nil;
    _tableview.tableFooterView = nil;
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.allowsSelection=YES;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.sectionIndexColor = [UIColor grayColor];
    _tableview.sectionIndexBackgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.89];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
    [tableHeader setBackgroundColor:[UIColor clearColor]];
    _tableview.tableHeaderView = tableHeader;
    [_tableview setBackgroundColor:Color_For_Main_LightGray];
    
    //注册nib
    UINib *nib = [UINib nibWithNibName:@"BankCardInfoCell" bundle:nil];
    [_tableview registerNib:nib forCellReuseIdentifier:reuseIndentifier];
    
    UINib *addNib = [UINib nibWithNibName:@"AddBankCardCell" bundle:nil];
    [_tableview registerNib:addNib forCellReuseIdentifier:addCardReuseIndentifier];
    
//        [self.tableView registerClass:[NextStepTableViewCell class] forCellReuseIdentifier:nextStepReuseIndentifier];
//        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableview.tableFooterView= nil;
    _tableview.tableFooterView.backgroundColor = [UIColor whiteColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creattableview];
    
    [self getUserBankList];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self addRightNavBtn];
    
    bankCardArray = [[NSMutableArray alloc] init];
    
    self.title = @"银行卡管理";
    
    isFaild = NO;
   
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
- (void)getUserBankList
{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"加载ing..."];
    [[ZMServerAPIs shareZMServerAPIs] getUserBankListForWithdraw:NO Success:^(id response)
     {
         isFaild = NO;
         dispatch_async(dispatch_get_main_queue(), ^(){
            [HUDjz hide:YES afterDelay:1.0];
         if (!bankCardArray.count>0) {
             NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];
             if ([ZMTools isNullObject:tempBankCardArray]) {
                 CLog(@"银行卡数据为空");
                 return ;
             }
             [self packagingUserBankList:tempBankCardArray];
             [_tableview reloadData];
//             [self creattableview];
         }else{
             [bankCardArray removeAllObjects];
             NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];
             if ([ZMTools isNullObject:tempBankCardArray]) {
                 CLog(@"银行卡数据为空");
                 return ;
             }
             [self packagingUserBankList:tempBankCardArray];
             
             [_tableview reloadData];
         }
         });
         CLog(@"用户银行卡列表：success = %@", response);
         
         
     }
    failure:^(id response){
         CLog(@"用户银行卡列表：failed = %@", response);
        isFaild = YES;
        [_tableview reloadData];
    
         //银行卡清空
//         if(bankCardArray.count)
//         {
//             CLog(@"bankCardArray = %@", bankCardArray);
//             [bankCardArray removeAllObjects];
//             bankCardArray = [[NSMutableArray alloc] init];
//         }
        
         dispatch_async(dispatch_get_main_queue(), ^{
             [HUDjz setLabelText:@"网络异常"];
             [HUDjz hide:YES afterDelay:1.0];
         });
        
         
         //        {"message":"没有找到符合条件的数据","code":4003}
        
         if([[response objectForKey:@"code"] integerValue] == 4003)
         {
             CLog(@"%@", [response objectForKey:@"message"]);
         }
     }];

}
-(void)packagingUserBankList:(NSMutableArray *)userBankList
{
    [bankCardArray addObjectsFromArray:userBankList];
    dispatch_async(dispatch_get_main_queue(), ^{
//            [HUDjz hide:YES afterDelay:1.0];
            _tableview.scrollEnabled = NO;
            [xianelabel removeFromSuperview];
//            if(bankCardArray.count > 0){
//                if (!changelabel) {
//                    changelabel = [[UILabel alloc] init];
//                    changelabel.textAlignment = NSTextAlignmentCenter;
//                    [changelabel setFrame:CGRectMake(0,GTFixHeightFlaot(150) , WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN/8)];
//                    
//                    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"如需换卡请点击更换银行卡"];
//                    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str1.length-5,5)];
//                    changelabel.attributedText = str1;
//                    [self.view addSubview:changelabel];
//                    
//                    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//                    [button setFrame:CGRectMake(WIDTH_OF_SCREEN/2,GTFixHeightFlaot(150) , WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN/8)];
//                    [button addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:button];
//
//                }
//            }
        
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
        [_tableview reloadData];

        });
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isFaild) {
        return 0;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
        [tableHeader setBackgroundColor:[UIColor clearColor]];
        return tableHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (bankCardArray.count>0) {
        BankCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[BankCardInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    } else {
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
    return ceil(78 * Ratio_OF_WIDTH_FOR_IPHONE6);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (bankCardArray.count > 0) {
        return;
    }
    AddBankCardViewController * next = [[AddBankCardViewController alloc] init];
    [self.navigationController pushViewController: next animated:YES];
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

@end
