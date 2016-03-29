//
//  GetCashViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "GetCashViewController.h"
#import "HUD.h"
#import "MobClick.h"
#import "BankProvinceTableViewController.h"
#import "GetCashSuccessViewController.h"
@interface GetCashViewController ()<UITextFieldDelegate>
{
    float fees;  //手续费

    double maxCashAmount; //最大提现金额
    
    NSMutableArray  *userBankArray;
    
    NSDictionary *selectedBankInfo;
    
    NSString * currentString;   //提现金额
    
    NSInteger cityId;   //城市编号
}
@end

@implementation GetCashViewController
@synthesize selectedCityInfo = _selectedCityInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =  [ZMTools item:@"DetailBackButton" target:self select:@selector(backVC)];
    //提现成功，需要刷新用户数据
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCurrentAmount)
                                                 name:UPDATE_USER_ASSERT_SUCCESS_NOTIFICATION_NAME
                                               object:nil];
    
    //临时关闭提示
    [self.tipsLabel setHidden:YES];
    /*
    每天最多提现次数为三次。
    财行家严禁信用卡充值、套现等行为，一经发现将予以处罚，包括但不限于：限制收款、冻结账户、永久停止服务，并会影响银行征信记录。
    提现前请您知晓，请确保提现银行账号的开户人姓名、身份证与财行家实名认证姓名、身份证一致，否则无法实现正常提现。
    提现到账时间：
    1、申请提现的受理时间为周一至周五9：00——18：00，节假日暂不受理。
    2、申请提现的处理时长为1~3个工作日，遇节假日顺延。
     */
    

    
    
    //提现手续费：
    fees  = 0.0;
    
    userBankArray = [NSMutableArray array];//[NSArray arrayWithObjects:@"工商银行",@"农业银行",@"交通银行", nil];
    
    [self.bankPicker setDelegate:self];
    [self.bankPicker setDataSource:self];
    
    //实际名称
    NSString *realNameStr = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
    if (realNameStr) {
        self.realNameLabel.text = realNameStr; //[ZMTools hideRealName:realNameStr];
    }
    
    //账户余额(可用余额)
    self.availableAmountLabel.text = [ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints];
    CLog(@"%@",[ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints]);
    //最大提现金额
    maxCashAmount = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints-fees;
    self.maxCashAmountLabel.text = [ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints-fees];
    CLog(@"%f",[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints - fees);

    
    //提现金额输入框
    [self.amountLabel setKeyboardType:UIKeyboardTypeDecimalPad];
//    UIKeyboardTypeNumberPad
    self.amountLabel.delegate = self;
    
    [self createButton];
    
    
    UITapGestureRecognizer *tapHideInputGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideInputBoard)];
    [self.view addGestureRecognizer:tapHideInputGesture];
    
    UIPanGestureRecognizer *panHideInputGestrue = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hideInputBoard)];
    [self.view addGestureRecognizer:panHideInputGestrue];
    
    //禁止编辑，仅展示
    self.bankCityLabel.hidden = NO;
    self.bankCityLabel.enabled = NO;
    self.bankCityLabel.textColor = [UIColor lightGrayColor];
    self.bankCityLabel.placeholder = @"请选择开户城市";
//    self.bankCityLabel.userInteractionEnabled = NO;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self                                                 action:@selector(pushProvinceAndCityList)];
//    [self.realNameLabel addGestureRecognizer:tapGesture];
//    [self.view addGestureRecognizer:tapHideInputGesture];
    
    self.cityChoseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.cityChoseButton setTitle:@"" forState:UIControlStateNormal];
    [self.cityChoseButton.titleLabel setFont: [UIFont systemFontOfSize:14.0]];
    [self.cityChoseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.cityChoseButton addTarget:self action:@selector(pushProvinceAndCityList) forControlEvents:UIControlEventTouchUpInside];
    
    
    //获取用户银行卡列表
    [self getUserBankList];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"提现"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"提现"];
}
- (void)backVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 * 银行卡所属省份和城市
 */
-(void)pushProvinceAndCityList
{
    BankProvinceTableViewController * proviceList = [[BankProvinceTableViewController alloc] init];
    proviceList.isForGetCash = YES;
    [self.navigationController pushViewController:proviceList animated:YES];
}

-(void)setSelectedCityInfo:(NSDictionary *)cityInfo
{
    CLog(@"cityInfo ==== %@", cityInfo);
//    {"id":1,"province":"北京","name":"北京"}
    
    _selectedCityInfo = cityInfo;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cityId = -1;
        if(_selectedCityInfo != nil)
        {
            cityId = [[_selectedCityInfo objectForKey:@"id"] integerValue];
        }
        else
        {
            cityId = -1;
        }
        
        self.bankCityLabel.text = [_selectedCityInfo objectForKey:@"name"];
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createButton
{
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_nextStepButton setFrame:CGRectMake(35, 470, WIDTH_OF_SCREEN - 70, 43)];
    [_nextStepButton setTitle:@"确定" forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_nextStepButton setBackgroundColor:Color_of_Red];
    [_nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    //默认情况下为非响应状态：
    _nextStepButton.layer.cornerRadius = 3.0;
        [_nextStepButton addTarget:self action:@selector(getCashAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepButton];
}

/*
 *  开始提现
 */
- (void)getCashAction:(UIButton *)sender
{
    NSString *amout = self.amountLabel.text;
    double amountNumber = [amout doubleValue];
    if (maxCashAmount < amountNumber) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"超出最大提现金额"];
        return;
    }
    else if (amountNumber <= 0) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"提现金额必须大于0元"];
        return;
    }
    else if (amountNumber == 0) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"提现金额不能为负数"];
        return;
    }
    
    if (selectedBankInfo == nil) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"请选择银行卡"];
        return;
    }
    
    //支行名称
    NSString * branchName = self.branchBankNameTextField.text;
    if ([branchName isEqualToString:@""] == YES) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"请输入正确的支行名称"];
        return;
    }
    
    //支行所属城市
    if(cityId == -1 || [self.bankCityLabel.text isEqualToString:@""])
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"请选择正确的开户城市"];
        return;
    }
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"提现申请中..."];
    
    //default = 1;
    //id = 229;
    
//    申请提现 接收到的数据：{"message":"提现申请成功","code":2000}
//    提现申请 failed {
//        code = 2000;
//        message = "\U63d0\U73b0\U7533\U8bf7\U6210\U529f";
//    }
    
    NSInteger usrBankId =  [[selectedBankInfo objectForKey:@"id"] integerValue];
    
    [[ZMServerAPIs shareZMServerAPIs] getCashWithAmount:[amout doubleValue] andUserBankId:usrBankId  branchName:branchName cityId:cityId Success:^(id response)
    {
        CLog(@"提现申请 success %@", response);
        dispatch_async(dispatch_get_main_queue(), ^(){
            progressHUD.tag = 2001;
            [progressHUD setLabelText:@"提现申请成功"];
            [progressHUD hide:YES afterDelay:0.5];
            [self updateAdminUserInfo];
            GetCashSuccessViewController *getCashVC = [[GetCashSuccessViewController alloc]init];
            
            getCashVC.title = @"提现成功";
            [self.navigationController pushViewController:getCashVC animated:YES];
            
            
        });
    }
    failure:^(id response)
    {
        CLog(@"提现申请 failed %@", response);
        dispatch_async(dispatch_get_main_queue(), ^(){
            progressHUD.tag = 2001;
            
            if ([[response objectForKey:@"code"] integerValue] == 2000) {
                [progressHUD setLabelText:@"提现申请成功"];
            }
            else
            {
                [progressHUD setLabelText:@"提现申请失败"];
            }
            [progressHUD hide:YES afterDelay:2.0];
        });

    }];
}


/*
 * 刷新账户余额，以及最大可提现金额
 */
-(void)updateCurrentAmount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //账户余额(可用余额)
        self.availableAmountLabel.text = [ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints];
        CLog(@"%@",[ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints]);
        //最大提现金额
        maxCashAmount = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints - fees;
        self.maxCashAmountLabel.text = [ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints-fees];
        CLog(@"%f",[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints - fees);
        
//        //账户余额(可用余额)
//        self.availableAmountLabel.text = [ZMTools moneyStandardFormatByData:[ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints];
//        
//        //最大提现金额
//        maxCashAmount = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminUserAccountInfo.availablePoints - fees;
//        self.maxCashAmountLabel.text = [ZMTools moneyStandardFormatByData: maxCashAmount];
    });
}


/*
 *  更新用户信息
 */
- (void)updateAdminUserInfo
{
    NSString * loginKey = [[ZMAdminUserStatusModel shareAdminUserStatusModel] getLoginKey];
    
    //是否已经登录
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn] &&
       loginKey != nil)
    {
//        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserBaseInfo];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAssert];
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] updateUserAccount];
    }
}
/*
 * 获取用户用行卡列表
 */
-(void)packagingUserBankList:(NSMutableArray *)userBankList
{
    userBankArray = userBankList;
    
    dispatch_async(dispatch_get_main_queue(), ^(){
//        [self.tableView reloadData];
    });
}
/*
 * 获取用户银行卡列表
 */
- (void)getUserBankList
{
    [[ZMServerAPIs shareZMServerAPIs] getUserBankListForWithdraw:YES Success:^(id response)
     {
         /*
          cardName = "\U4e2d\U56fd\U6c11\U751f\U94f6\U884c";
          cardNumber = 6226222002173685;
          default = 1;
          id = 229;
          imgPath = "";
          */
         
         /*
          获取用户银行卡列表 接收到的数据：{"message":"没有找到符合条件的数据","code":1000}
          */
         
         CLog(@"提现用户的银行卡列表： %@", response);
         
         dispatch_async(dispatch_get_main_queue(), ^(){
             
             //用户没有银行卡，或者没有查询出银行卡
             if([[response objectForKey:@"message"] isEqualToString:@"没有找到符合条件的数据"])
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                 message:@"您还没有添加银行卡"
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
                 [alert show];
                 
                 return;
             }
             
             NSMutableArray *tempBankCardArray = [[response objectForKey:@"data"] objectForKey:@"userBanks"];
             if ([ZMTools isNullObject:tempBankCardArray]) {
                 self.bankPicker.hidden = YES;
                 CLog(@"银行卡数据为空");
                 return ;
             }
             
             if ([tempBankCardArray count] == 0) {
                 CLog(@"没有银行卡");
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                 message:@"您还没有添加银行卡"
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
                 [alert show];
                 return ;
             }
             
             userBankArray = tempBankCardArray;
             self.bankPicker.hidden = NO;
             
             
             
//         });
//         dispatch_async(dispatch_get_main_queue(), ^(){
             
             
             

             selectedBankInfo = [userBankArray objectAtIndex:0];
             
             /*
              
             //银行卡标记
             self.bankLogo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [selectedBankInfo objectForKey:@"cardName"]]];
             
             //银行名称
             
             //银行卡
             NSString *bankCardNum = [selectedBankInfo objectForKey:@"cardNumber"];
             bankCardNum = [bankCardNum substringWithRange:NSMakeRange(bankCardNum.length - 4, 4)];
             self.bankName.text = [NSString stringWithFormat:@"尾号%@", bankCardNum];
//             self.bankName.text = [selectedBankInfo objectForKey:@"cardName"];
             
             
             //银行卡标记位置
             CGSize size = [ZMTools calculateTheLabelSizeWithText:self.bankName.text font:self.bankName.font];
             self.bankIconTrailingAlignment.constant = size.width + 5;

              */
             
             [self getSelectedBankInfo:selectedBankInfo];
             
             //刷新
             [self.bankPicker reloadAllComponents];
             
         });
     }failure:^(id response){
         CLog(@"用户提现的银行卡列表：failed = %@", response);
                                                             
         //银行卡清空
         if(userBankArray)
         {
             CLog(@"bankCardArray = %@", userBankArray);
             [userBankArray removeAllObjects];
             userBankArray = [[NSMutableArray alloc] init];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
//             [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
         });
         
         
         //        {"message":"没有找到符合条件的数据","code":4003}
         
         if([[response objectForKey:@"code"] integerValue] == 4003)
         {
             CLog(@"%@", [response objectForKey:@"message"]);
         }
     }];
}


-(void)getSelectedBankInfo:(NSDictionary *)bankInfo
{
    selectedBankInfo = bankInfo;
    
    //开户支行名称
    if ([selectedBankInfo objectForKey:@"branchName"] == nil ||
        [ZMTools isNullObject:[selectedBankInfo objectForKey:@"branchName"]] == YES) {
        self.branchBankNameTextField.text = @"";
    }
    else
    {
        self.branchBankNameTextField.text = [selectedBankInfo objectForKey:@"branchName"];
    }
//    city =                 {
//        cityCode = "";
//        id = 490;
//        name = "\U6210\U90fd";
//        province = "\U56db\U5ddd\U7701";
//        provinceCode = "";
//    };
    
//    city = "<null>";
    
    if ([ZMTools isNullObject:[selectedBankInfo objectForKey:@"city"]] == YES) {
        self.bankCityLabel.text = @"";
        cityId = -1;
    }
    else
    {
        NSString *cityName = [[selectedBankInfo objectForKey:@"city"] objectForKey:@"name"];
        if ([ZMTools isNullObject:cityName] == YES) {
            self.bankCityLabel.text = @"";
            cityId = -1;
        }
        else
        {
            //支行所属城市
            cityId = [[[selectedBankInfo objectForKey:@"city"] objectForKey:@"id"] integerValue];
            self.bankCityLabel.text = [[selectedBankInfo objectForKey:@"city"] objectForKey:@"name"];
            self.bankCityLabel.textColor = [UIColor blackColor];
        }
    }
    
    
    
    //银行卡标记
    self.bankLogo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [selectedBankInfo objectForKey:@"cardName"]]];
    
    //银行名称
//    NSString *bankCardNum = [selectedBankInfo objectForKey:@"cardNumber"];
//    bankCardNum = [bankCardNum substringWithRange:NSMakeRange(bankCardNum.length - 4, 4)];
    
    NSMutableString *bankCardNum = [[NSMutableString alloc] initWithString:[selectedBankInfo objectForKey:@"cardNumber"]];
    [bankCardNum replaceCharactersInRange:NSMakeRange(4, 11) withString:@"***********"];
    self.bankName.text = [NSString stringWithFormat:@"%@", bankCardNum];
    self.bankName.textColor = [UIColor grayColor];
//    self.bankName.text = [selectedBankInfo objectForKey:@"cardName"];
    
    //银行卡标记位置
    CGSize size = [ZMTools calculateTheLabelSizeWithText:self.bankName.text font:self.bankName.font];
    self.bankIconTrailingAlignment.constant = size.width + 5;
}



#pragma mark - picker view delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [userBankArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    //银行名称 和 卡后四位
    NSDictionary *singleBankInfo = [userBankArray objectAtIndex:row];
    NSString *bankCardNum = [singleBankInfo objectForKey:@"cardNumber"];
    bankCardNum = [bankCardNum substringWithRange:NSMakeRange(bankCardNum.length - 4, 4)];
    return [[singleBankInfo objectForKey:@"cardName"] stringByAppendingString:bankCardNum];
    
//    NSDictionary *singleBankInfo = [userBankArray objectAtIndex:row];
//    return [singleBankInfo objectForKey:@"cardName"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CLog(@"selected row %d",row);
    if(userBankArray.count==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请正确绑定银行卡" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSDictionary *singleBankInfo = [userBankArray objectAtIndex:row];
        [self getSelectedBankInfo:singleBankInfo];
    }
}



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
    
    currentString = tempString;
    
    return YES;
}

#pragma mark UIScrollView delegate ------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self hideInputBoard];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * 隐藏输入法
 */
-(void)hideInputBoard
{
    [self.amountLabel resignFirstResponder];
    [self.branchBankNameTextField resignFirstResponder];
}


@end
