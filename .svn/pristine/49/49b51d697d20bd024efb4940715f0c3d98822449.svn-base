//
//  ModifyPasswordController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "ZMSafeSettingsViewController.h"
#import "NewProductDetailViewController.h"

#import "ZMSafeInputCell.h"
//#import "ZMSafeSettingsViewController.h"


@interface ModifyPasswordController ()<UITextFieldDelegate>
{
    //昵称输入框
    UITextField *oldPWDTextField;
    UITextField *newPWDTextField;
    UITextField *rePWDTextField;
    
    NSMutableString *currentString;
    
    //The confirm action button
    UIButton *nextStepButton;
}
@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addreturnBtn];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatTableView];
    
    self.title = @"修改登录密码";
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
        [self.tableView setOrigin:CGPointMake(self.tableView.left, self.tableView.top+64)];
    }

    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 15)];
    [tableHeader setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = tableHeader;
    [self.tableView setBackgroundColor:Color_For_Main_LightGray];
    
    //注册nib
    UINib *nib = [UINib nibWithNibName:@"ZMSafeInputCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //确认设置
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextStepButton setFrame:CGRectMake(30, 30 + 3*(ceil(50 * Ratio_OF_WIDTH_FOR_IPHONE6)), WIDTH_OF_SCREEN - 60, 44)];
    [nextStepButton setTitle:@"确 定" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    //默认情况下为非响应状态：
    nextStepButton.enabled = NO;
    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    nextStepButton.layer.cornerRadius = 3.0;
    [nextStepButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:nextStepButton];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkButtonStatus:)
                                                 name:UITextFieldTextDidChangeNotification
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


-(void)confirmAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    NSString *oldPassword = oldPWDTextField.text;
    NSString *newPassword = newPWDTextField.text;
    NSString *reNewPassword = rePWDTextField.text;
    [oldPWDTextField resignFirstResponder];
    [newPWDTextField resignFirstResponder];
    [rePWDTextField resignFirstResponder];
    oldPWDTextField.delegate = nil;
    newPWDTextField.delegate = nil;
    rePWDTextField.delegate = nil;
    
    
    if ([newPassword isEqualToString:reNewPassword])
    {
        if([newPassword length] < 6 || [newPassword length] > 16)
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码长度为6-16位,请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alter.delegate = self;
            [alter show];
            return;
        }
        MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        ProgressHUD.delegate = self;
        ProgressHUD.mode = MBProgressHUDModeIndeterminate;
        [ProgressHUD setLabelText:@"请稍等..."];
        [[ZMServerAPIs shareZMServerAPIs] alterUserOldPassword:oldPassword toNewPassword:newPassword Success:^(id response){
            CLog(@"success");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [ProgressHUD setLabelText:@"密码修改成功"];
                [ProgressHUD hide:YES afterDelay:0.8];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                return;
            });
        }
        failure:^(id response){
            CLog(@"failed");
            dispatch_async(dispatch_get_main_queue(), ^{
                ProgressHUD.labelText = @"";
                [ProgressHUD hide:YES afterDelay:0];
                NSString *errorMessage = [response valueForKey:@"message"];
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alter show];
            });
        }];
    }
    else
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"两次密码不一致,请重新输入。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alter show];
    }
}


//检查是否有输入
- (void)checkButtonStatus:(BOOL)hasInput
{
    if(![oldPWDTextField.text isEqualToString:@""]&&![newPWDTextField.text isEqualToString:@""]&&![rePWDTextField.text isEqualToString:@""])
    {
        hasInput = YES;
    }
    else
    {
        hasInput = NO;
    }
    
    if (hasInput)
    {
        nextStepButton.enabled = YES;
        [nextStepButton setBackgroundColor:Color_of_Red];
    }
    else
    {
        nextStepButton.enabled = NO;
        [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark - alertView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义的cell(纯代码书写)
    static NSString * reuseIndentifier = @"reuseIdentifier";
    ZMSafeInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ZMSafeInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *classTitle;
    switch (indexPath.row) {
        case 0:
            classTitle = @"原密码";
            
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = NO;
            cell.bottomLongLine.hidden = YES;
            
            cell.textField.delegate = self;
            oldPWDTextField = cell.textField;
//            [oldPWDTextField becomeFirstResponder];
            break;
            
        case 1:
            classTitle = @"登录密码";
            
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = YES;
            
            newPWDTextField = cell.textField;
            break;
            
        case 2:
            classTitle = @"确认密码";
            cell.bottomLine.hidden = YES;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = NO;
            
            cell.textField.delegate = self;
            rePWDTextField = cell.textField;
            break;
            
        default:
            break;
    }
    
    cell.leftClassTitleLabel.text = classTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ceil(50 * Ratio_OF_WIDTH_FOR_IPHONE6);
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


#pragma mark UITextField delegate ------------------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    CLog(@"ShouldBegin ===  %@", textField.text);
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    CLog(@"DidBegin ===  %@", textField.text);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CLog(@"ShouldEnd ===  %@", textField.text);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CLog(@"DidEnd ===  %@", textField.text);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *tempString = [NSMutableString stringWithString: textField.text];
    
//    NSLog(@"zxhzhxhzhxhzhxhzhxh    %@, %@, %d", textField.text, string, range.location);
    
    if([string isEqualToString:@""] && range.location != 0)
    {
        [tempString deleteCharactersInRange:NSMakeRange(range.location, 1)];
    }
    else if ([string isEqualToString:@""] && range.location == 0)
    {
        if ([textField.text length] > 0)
        {
            [tempString deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    else
    {
        [tempString insertString:string atIndex:range.location];
    }
    
//    NSLog(@"zxhzhxhzhxhzhxhzhxhAAA    %@", tempString);
    
    currentString = tempString;
    
    return YES;
}



#pragma mark UIAlertView delegate ------------------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(10002 == alertView.tag)
    {
        switch (buttonIndex) {
            case 0:
            {
                CLog(@"好的");
//                textField.text = @"";
                nextStepButton.enabled = NO;
                
                [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
                
            }
                break;
                
            default:
                break;
        }
    }
    
    if(10003 == alertView.tag)
    {
        switch (buttonIndex) {
            case 0:
            {
                CLog(@"好的");
                //                [self.navigationController popToRootViewControllerAnimated:YES];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
}

@end
