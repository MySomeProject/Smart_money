//
//  ModifyUserInfoViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ModifyUserInfoViewController.h"

@interface ModifyUserInfoViewController ()<UIScrollViewDelegate>
{
    NSArray *_commonArray;  //当前所有银行名称列表数据
    NSUInteger selectedBankInfoIndex;
}
@end

@implementation ModifyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setTitle:@"关闭" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(closedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(savingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
    [tempView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:tempView];
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    //获取银行名称
    _commonArray = [[NSMutableArray alloc] init];
    selectedBankInfoIndex = 0;
}

-(void)closedButtonPressed:(UIButton *)closedButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)savingButtonPressed:(UIButton *)closedButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - (static cells) Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.row == 5) {//学历
        _commonArray = @[@{@"MIDDLESCHOOL":@"高中或以下"}, @{@"COLLEGE":@"大专"}, @{@"UNDERGRADUATE":@"本科"}, @{@"GRADUATE":@"研究生或以上"}];
        
        [self.delegate didSelectedUserInfoCell:_commonArray];
    }
    if (indexPath.row == 6) {//院校+
        
    }
    else if (indexPath.row == 7)//婚姻
    {
        _commonArray = @[@{@"MARRIED":@"已婚"}, @{@"UNMARRIED":@"未婚"}, @{@"DIVORCE":@"离异"}, @{@"LOST":@"丧偶"}];
        
        [self.delegate didSelectedUserInfoCell:_commonArray];
    }
    else if (indexPath.row == 8)//居住地址+
    {
        
    }
    else if (indexPath.row == 9)//行业
    {
        _commonArray = @[@{@"MANUFACTURE":@"制造业"}, @{@"IT":@"IT"}, @{@"GOVERNMENT":@"政府机构"}, @{@"MEDIAADVERTISIING":@"媒体/广告"},@{@"RETAIL":@"零售/批发"}, @{@"EDUCATION":@"教育/培训"}, @{@"UTILITIES":@"公共事业"}, @{@"TRANSPORTATION":@"交通运输业"},@{@"ESTATE":@"房地产业"}, @{@"ENERGY":@"能源业"}, @{@"FINANCIAL":@"金融/法律"}, @{@"CATERING":@"餐饮/旅馆业"},@{@"MEDICAL":@"医疗/卫生/保健"}, @{@"BUILDING":@"建筑工程"}, @{@"FARM":@"农业"}, @{@"ENTERTAINMENT":@"娱乐服务业"},@{@"SPORTS":@"体育/艺术"}, @{@"COMMUNITY":@"公益组织"}, @{@"OTHER":@"其它"}];
        
        [self.delegate didSelectedUserInfoCell:_commonArray];
    }
    else if (indexPath.row == 10)//公司规模
    {
        _commonArray = @[@{@"LESSTHANTEN":@"10人以下"}, @{@"TENTOONEHAN":@"10-100人"}, @{@"ONEHANTOFIVEHAN":@"100-500人"}, @{@"GREATTHANFIVEHAN":@"500人以上"}];
        
        [self.delegate didSelectedUserInfoCell:_commonArray];
    }
    else if (indexPath.row == 11)//职位+
    {
        
    }
    else if (indexPath.row == 12)//月收入
    {
        _commonArray = @[@{@"LESSTHANONE":@"1000元以下"}, @{@"ONETOTWO":@"1001-2000元"}, @{@"TWOTOFIVE":@"2000-5000元"}, @{@"FIVETOONE":@"5000-10000元"}, @{@"ONETOTWOHUAN":@"10000-20000元"}, @{@"TWOTOFIVEHUAN":@"20000-50000元"}, @{@"GREATTHANFIVE":@"50000元以上"}];
        
        [self.delegate didSelectedUserInfoCell:_commonArray];
    }
}



#pragma mark--滑动代理delegate

//上下滑动scroll 用于隐藏输入法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    CLog(@"scrollViewWillBeginDragging");
//    [nameTextField resignFirstResponder];
//    [identityTextField resignFirstResponder];
    
    [self.delegate hidePickerView:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}




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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
