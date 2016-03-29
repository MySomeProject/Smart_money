//
//  AModifyUserInfoViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AModifyUserInfoViewController.h"
#import "ModifyUserInfoViewController.h"

@interface AModifyUserInfoViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, ModifyUserInfoListDelegate>
{
    NSArray *_commonArray;
    NSUInteger selectedBankInfoIndex;
    
    //类型选择器
    UIPickerView *typePickerView;
}
@end

@implementation AModifyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
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
    
    
    //银行卡类型选择器
    CGRect pickerViewframe = CGRectMake(0, HEIGHT_OF_SCREEN, WIDTH_OF_SCREEN, 300);
    typePickerView = [[UIPickerView alloc] initWithFrame:pickerViewframe];
    typePickerView.dataSource = self;
    typePickerView.delegate = self;
    [typePickerView setBackgroundColor:[UIColor grayColor]];
    
    [typePickerView setHidden:NO];
    
    [self.view addSubview:typePickerView];
    
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


#pragma mark UIPickerView delegate ------------------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _commonArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary * singleDic = [_commonArray objectAtIndex:row];
    return [[singleDic allValues] objectAtIndex:0];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *singleDic = [_commonArray objectAtIndex:row];
    NSString *keyName = [[singleDic allKeys] objectAtIndex:0];
    NSString *valueName = [[singleDic allValues] objectAtIndex:0];
    
    CLog(@"valueName : %@, valueName : %@", keyName, valueName);
    
    
//    selectedBankInfoIndex = row;
//    NSArray *_array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
//    [self.tableView reloadRowsAtIndexPaths:_array withRowAnimation:UITableViewRowAnimationFade];
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

-(void)hidePickerView:(id)sender
{
    if (self.VSpaceBGView.constant == 200)//需要隐藏
    {
        self.VSpaceBGView.constant = 200;
        
        CGRect pickerViewframe = CGRectMake(0, HEIGHT_OF_SCREEN - 200, WIDTH_OF_SCREEN, 300);
        typePickerView.frame = pickerViewframe;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.VSpaceBGView.constant = 0;
            
            CGRect pickerViewframe = CGRectMake(0, HEIGHT_OF_SCREEN, WIDTH_OF_SCREEN, 300);
            typePickerView.frame = pickerViewframe;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)didSelectedUserInfoCell:(id)chosenData
{
    if (self.VSpaceBGView.constant == 0)//需要显示
    {
        self.VSpaceBGView.constant = 0;
        
        CGRect pickerViewframe = CGRectMake(0, HEIGHT_OF_SCREEN, WIDTH_OF_SCREEN, 300);
        typePickerView.frame = pickerViewframe;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.VSpaceBGView.constant = 200;
            
            CGRect pickerViewframe = CGRectMake(0, HEIGHT_OF_SCREEN - 200, WIDTH_OF_SCREEN, 300);
            typePickerView.frame = pickerViewframe;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    /*
     * 刷新pickerView数据
     */
    _commonArray = (NSArray *)chosenData;
    [typePickerView reloadAllComponents];
    [typePickerView setHidden:NO];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"EmbedSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[ModifyUserInfoViewController class]]) {
            self.embedUserInfoListVC = (ModifyUserInfoViewController *)segue.destinationViewController;
            
            self.embedUserInfoListVC.delegate = self;
        }
    }
}


@end
