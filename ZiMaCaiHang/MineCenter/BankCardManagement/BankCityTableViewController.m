//
//  BankCityTableViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankCityTableViewController.h"
#import "AddBankCardViewController.h"
#import "GetCashViewController.h"
#import "GetCashViewIp4ViewController.h"

@interface BankCityTableViewController ()
{
    NSMutableArray *_allProvinceArray;  //当前所有省份列表数据
    UILabel *noMessageLabel;            //无消息的提示
}
@end

@implementation BankCityTableViewController
-(void)addreturnBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 25);
    [btn setImage:[UIImage imageNamed:@"DetailBackButton"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = returnItem;}
-(void)returnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addreturnBtn];
    _allProvinceArray = [[NSMutableArray alloc] init];
    
    
    [[ZMServerAPIs shareZMServerAPIs] bankCityListWithProvice:self.proviceName Success:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[response objectForKey:@"code"] integerValue] == 1000) {
                
                NSMutableArray *newPageProductArray = [[[response objectForKey:@"data"] objectForKey:@"cities"] mutableCopy];
                
                if (newPageProductArray.count == 0) {
                    return;
                }
                else
                {
//                    CLog(@"城市列表 = %@", newPageProductArray);
                    [_allProvinceArray addObjectsFromArray:newPageProductArray];
                    
                    //重新刷新数据
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    });
                }
            }
        });
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[response objectForKey:@"code"] integerValue] != 1000) {
                
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _allProvinceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"provinceId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSDictionary *singleCity = [_allProvinceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [singleCity objectForKey:@"name"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48 * Ratio_OF_WIDTH_FOR_IPHONE6;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *singleCity = [_allProvinceArray objectAtIndex:indexPath.row];
    CLog(@"%@ %@", [singleCity objectForKey:@"province"], [singleCity objectForKey:@"name"]);
    CLog(@"viewControllers = %@", [self.navigationController viewControllers]);
    
    for(id vc in self.navigationController.viewControllers)
    {
        if(self.isForGetCash)
        {
            if([vc isKindOfClass:[GetCashViewController class]])
            {
                [((GetCashViewController *)vc) setSelectedCityInfo:singleCity];
                [self.navigationController popToViewController:vc animated:YES];
            }
            if([vc isKindOfClass:[GetCashViewIp4ViewController class]])
            {
                [((GetCashViewIp4ViewController *)vc) setSelectedCityInfo:singleCity];
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        else
        {
            if([vc isKindOfClass:[AddBankCardViewController class]])
            {
                [((AddBankCardViewController *)vc) setSelectedCityInfo:singleCity];
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }

    //选择省份－城市
//    BankCityTableViewController * cityList = [[BankCityTableViewController alloc] init];
//    
//    cityList.proviceName = [_allProvinceArray objectAtIndex:indexPath.row];
//    
//    [self.navigationController pushViewController:cityList animated:YES];
}


@end
