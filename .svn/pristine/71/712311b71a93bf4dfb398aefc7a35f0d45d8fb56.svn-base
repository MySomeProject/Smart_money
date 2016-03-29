//
//  BankProvinceTableViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankProvinceTableViewController.h"
#import "BankCityTableViewController.h"

@interface BankProvinceTableViewController ()
{
    NSMutableArray *_allProvinceArray;  //当前所有省份列表数据
    UILabel *noMessageLabel;            //无消息的提示
}
@end

@implementation BankProvinceTableViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addreturnBtn];
    
    _allProvinceArray = [[NSMutableArray alloc] init];
    
    //{
    //    code = 1000;
    //    data =     {
    //        provinces =         (
    //                             "\U5317\U4eac",
    //                             "\U5929\U6d25",
    //                             "\U4e0a\U6d77",
    //                             "\U5e7f\U897f\U58ee\U65cf",
    //                             "\U53f0\U6e7e\U7701"
    //                             );
    //    };
    //    message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
    //}
    
    [[ZMServerAPIs shareZMServerAPIs] bankProvinceListSuccess:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[response objectForKey:@"code"] integerValue] == 1000) {
                
                NSMutableArray *newPageProductArray = [[[response objectForKey:@"data"] objectForKey:@"provinces"] mutableCopy];
                
                if (newPageProductArray.count == 0) {
                    return;
                }
                else
                {
                    [_allProvinceArray addObjectsFromArray:newPageProductArray];
                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [noMessageLabel removeFromSuperview];
//                    });
                    
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
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [_allProvinceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48 * Ratio_OF_WIDTH_FOR_IPHONE6;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择省份－城市
    
    
    BankCityTableViewController * cityList = [[BankCityTableViewController alloc] init];
    
    cityList.isForGetCash = self.isForGetCash;
    cityList.proviceName = [_allProvinceArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:cityList animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
