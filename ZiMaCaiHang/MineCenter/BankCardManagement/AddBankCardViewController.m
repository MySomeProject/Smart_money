//
//  AddBankCardViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "AddBankInputCell.h"
#import "AddBankChoseInputCell.h"
#import "AddBankTopCell.h"
#import "FinancingTableViewController.h"

#import "BankProvinceTableViewController.h"
#import "RechargeViewController.h"
#import "BankSelectViewController.h"
#import "HUD.h"
#import "MobClick.h"

static NSString * reuseAddBankTopCell = @"reuseAddBankTopCell";
static NSString * reuseAddBankInputCell = @"reuseAddBankInputCell";
static NSString * reuseAddBankChoseInputCell = @"reuseAddBankChoseInputCell";

@interface AddBankCardViewController ()<UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    //昵称输入框
    UITextField *bankCardTextField;
    UITextField *reBankCardTextField;
    UITextField *branchBankNameTextField;

    UILabel *bankNameLabel;
    UILabel *bankCityLabel;
    
    NSMutableString *currentString;
    
    //The confirm action button
    UIButton *nextStepButton;
    
    //银行卡类型选择器
    UIPickerView *bankTypePickerView;
    
    NSMutableArray *_allBankNameArray;  //当前所有银行名称列表数据
    
    NSUInteger selectedBankInfoIndex;
    
    NSInteger bankTypeId;   //银行卡类型Id
}
@end

@implementation AddBankCardViewController
@synthesize selectedCityInfo = _selectedCityInfo;

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
    
    if (self.isRealName == YES) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent= YES;

    [MobClick beginLogPageView:@"添加银行卡"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"添加银行卡"];
}

-(void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN-64) style:UITableViewStylePlain];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addreturnBtn];
    [self creatTableView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标

        [self.tableView setOrigin:CGPointMake(self.tableView.left, self.tableView.top+64)];
    }
    self.title = @"添加银行卡";
    
    [self.tableView setBackgroundColor:Color_For_Main_LightGray];
    
    
    UINib *nib0 = [UINib nibWithNibName:@"AddBankTopCell" bundle:nil];
    [self.tableView registerNib:nib0 forCellReuseIdentifier:reuseAddBankTopCell];
    
    UINib *nib = [UINib nibWithNibName:@"AddBankInputCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseAddBankInputCell];
    
    UINib *nib2 = [UINib nibWithNibName:@"AddBankChoseInputCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:reuseAddBankChoseInputCell];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //确认设置
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextStepButton setFrame:CGRectMake(30, 20, WIDTH_OF_SCREEN - 60, 44)];
    [nextStepButton setTitle:@"确 认" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    
    //默认情况下为非响应状态：
    nextStepButton.enabled = NO;
    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    nextStepButton.layer.cornerRadius = 3.0;
    [nextStepButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.tableView addSubview:nextStepButton];
    
//    //通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(checkButtonStatus:)
//                                                 name:UITextFieldTextDidChangeNotification
//                                               object:nil];
//    
    
    //银行卡类型选择器
    CGRect pickerViewframe = CGRectMake(0, nextStepButton.bottom, WIDTH_OF_SCREEN, 150);
    bankTypePickerView = [[UIPickerView alloc] initWithFrame:pickerViewframe];
    bankTypePickerView.dataSource = self;
    bankTypePickerView.delegate = self;
//    [self.tableView addSubview:bankTypePickerView];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 214)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    if (HEIGHT_OF_SCREEN ==480) {
        bankTypePickerView.frame =  CGRectMake(0, 0, WIDTH_OF_SCREEN, 150);
        [nextStepButton setFrame:CGRectMake(30, bankTypePickerView.bottom, WIDTH_OF_SCREEN - 60, 44)];

    }
    [footerView addSubview:nextStepButton];
//    [footerView addSubview:bankTypePickerView];
    self.tableView.tableFooterView = footerView;
    
    
    //获取银行名称
    _allBankNameArray = [[NSMutableArray alloc] init];
    
    [[ZMServerAPIs shareZMServerAPIs] bankNameListSuccess:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            CLog(@"银行 ==== %@", response);
            
            if ([[response objectForKey:@"code"] integerValue] == 1000) {
                
                NSMutableArray *newPageProductArray = [[[response objectForKey:@"data"] objectForKey:@"banks"] mutableCopy];
                
                /*
                 {"message":"获取数据成功",
                 "data":
                 {
                    "banks":[
                            －{"id":1,"imgPath":"","code":"cmb","thirdPayType":"LOCAL","name":"招商银行","bankNumber":"03080000"},
                            －{"id":2,"imgPath":"","code":"icbc","thirdPayType":"LOCAL","name":"中国工商银行 ","bankNumber":"01020000"},
                            －{"id":3,"imgPath":"","code":"ccb","thirdPayType":"LOCAL","name":"中国建设银行","bankNumber":"01050000"},
                            －{"id":4,"imgPath":"","code":"abc","thirdPayType":"LOCAL","name":"中国农业银行","bankNumber":"01030000"},
                            －{"id":5,"imgPath":"","code":"cmbc","thirdPayType":"LOCAL","name":"中国民生银行","bankNumber":"03050000"},
                            － {"id":6,"imgPath":"","code":"spdb","thirdPayType":"LOCAL","name":"上海浦东发展银行","bankNumber":"03100000"},
                            －  {"id":7,"imgPath":"","code":"cgb","thirdPayType":"LOCAL","name":"广东发展银行","bankNumber":"03060000"},
                            － {"id":8,"imgPath":"","code":"cib","thirdPayType":"LOCAL","name":"兴业银行","bankNumber":"03090000"},
                            －  {"id":9,"imgPath":"","code":"ceb","thirdPayType":"LOCAL","name":"光大银行","bankNumber":"03030000"},
                            －{"id":10,"imgPath":"","code":"comm","thirdPayType":"LOCAL","name":"交通银行","bankNumber":""},
                            － {"id":11,"imgPath":"","code":"boc","thirdPayType":"LOCAL","name":"中国银行 ","bankNumber":"01040000"},
                            －  {"id":12,"imgPath":"","code":"citic","thirdPayType":"LOCAL","name":"中信银行","bankNumber":"03020000"},
                              {"id":13,"imgPath":"","code":"bos","thirdPayType":"LOCAL","name":"上海银行","bankNumber":""},
                            － {"id":14,"imgPath":"","code":"pingan","thirdPayType":"LOCAL","name":"平安银行 ","bankNumber":"03070000"},
                            －  {"id":15,"imgPath":"","code":"psbc","thirdPayType":"LOCAL","name":"邮政储蓄 ","bankNumber":"01000000"},
                            －  {"id":16,"imgPath":"","code":"hxb","thirdPayType":"LOCAL","name":"华夏银行","bankNumber":"03040000"}]},"code":1000}
                 */
                if (newPageProductArray.count == 0) {
                    return;
                }
                else
                {
                    [_allBankNameArray addObjectsFromArray:newPageProductArray];
                    
                    //重新刷新数据
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [bankTypePickerView reloadAllComponents];
                        
                        selectedBankInfoIndex = 0;
                        
                        NSArray *_array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
                        [self.tableView reloadRowsAtIndexPaths:_array withRowAnimation:UITableViewRowAnimationFade];
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
    // Dispose of any resources that can be recreated.
}

-(void)setSelectedCityInfo:(NSDictionary *)cityInfo
{
    CLog(@"cityInfo ==== %@", cityInfo);
    
    _selectedCityInfo = cityInfo;
    
    NSArray *_array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:_array withRowAnimation:UITableViewRowAnimationFade];
    });
}

/*
 * 确认按钮事件
 */
-(void)confirmAction:(UIButton *)button
{
//    {"id":1,"province":"北京","name":"北京"}
    
    NSInteger cityId = -1;
    if(_selectedCityInfo != nil)
    {
        cityId = [[_selectedCityInfo objectForKey:@"id"] integerValue];
    }
    else
    {
        cityId = -1;
    }
    
    CLog(@"卡一：%@, 卡二：%@, bankTypeId = %ld", bankCardTextField.text, reBankCardTextField.text, bankTypeId);
    
//    {"id":3,"imgPath":"","code":"ccb","thirdPayType":"LOCAL","name":"中国建设银行","bankNumber":"01050000"}
//    bankCardTextField.text  = @"6217003810010199811";
//    reBankCardTextField.text = @"6217003810010199811";
    
//    bankCardTextField.text  = @"6226222002173685";
//    reBankCardTextField.text = @"6226222002173685";
//    branchBankNameTextField.text = @"成都分行";
    
    
    //判断银行卡
    if(![bankCardTextField.text isEqualToString:reBankCardTextField.text])
    {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"银行卡号不一致"];
        return;
    }
    //是否是正确的银行卡
    BOOL isBankNumber = [ZMTools validateBankCardNumber:bankCardTextField.text];
    if (!isBankNumber) {
        [[HUD sharedHUDText] showForTime:2.0 WithText:@"银行卡号有误!"];
        return;
    }
    //判断银行支行地址
    
    
    [[ZMServerAPIs shareZMServerAPIs] addBankCardWithBankId:bankTypeId
                                              andCardNumber:bankCardTextField.text
                                              andBranchName:branchBankNameTextField.text
                                                  andCityId:cityId
      Success:^(id response) {
          
//          {"message":"绑定银行卡成功","code":1000}
          
          CLog(@"添加银行卡 成功＝ %@", response);
          
          dispatch_async(dispatch_get_main_queue(), ^{
              [[HUD sharedHUDText] showForTime:2.0 WithText:[response objectForKey:@"message"]];
              if(self.isRechange == YES)
              {
                  RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
//                  rechargeVC. = bankCardTextField.text;
//                  NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//                  [dict setValue:bankCardTextField.text forKey:@"cardNumber"];
                  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:bankCardTextField.text,@"cardNumber", nil];
                  rechargeVC.selectedBankInfo = dict;
                  [self.navigationController pushViewController:rechargeVC animated:YES];
              }
              else
              {
//                  [self.navigationController popViewControllerAnimated:YES];
                  FinancingTableViewController *next = [[FinancingTableViewController alloc] init];
                  
                  [self.navigationController pushViewController:next animated:YES];
                  
              }
              return;
          });
          
    } failure:^(id response) {
        CLog(@"添加银行卡 失败 ＝ %@", response);
        
//        {"message":"添加银行卡失败","code":2000}
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"网络异常，请稍候再试"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"好的", nil];
                [alert show];
                return;
            }
            else if ([[response objectForKey:@"code"] integerValue] == 2000) {
//                {"message":"请先进行实名认证","code":2000}
//                {"message":"请输入正确的银行卡号, 请勿使用信用卡.","code":2000}
//                {"message":"添加银行卡失败","code":2000}
                
//                [[HUD sharedHUDText] showForTime:2.0 WithText:[NSString stringWithFormat:@"%@", [response objectForKey:@"message"]]];
                
                if([[response objectForKey:@"message"] isEqualToString:@"请输入正确的银行卡号, 请勿使用信用卡."] == YES)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:[response objectForKey:@"message"]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"好的", nil];
                    [alert show];
                }
                
                else if([[response objectForKey:@"message"] isEqualToString:@"请先进行实名认证"] == YES)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:[response objectForKey:@"message"]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"好的", nil];
                    [alert show];
                }
                
                else if([[response objectForKey:@"message"] isEqualToString:@"该银行卡已经被绑定"] == YES)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:[response objectForKey:@"message"]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"好的", nil];
                    [alert show];
                }
                
                return;
            }
            else
            {
//                MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                ProgressHUD.mode = MBProgressHUDModeIndeterminate;
//                ProgressHUD.animationType = MBProgressHUDAnimationFade;
//                [ProgressHUD setLabelText:@"修改成功"];
//                [ProgressHUD hide:YES afterDelay:2.0];
                
                [[HUD sharedHUDText] showForTime:2.0 WithText:[NSString stringWithFormat:@"%@", [response objectForKey:@"message"]]];
                return;
            }
        });
    }];
}


//检查是否有输入
- (void)checkButtonStatus:(BOOL)hasInput
{
    if(![bankCardTextField.text isEqualToString:@""] &&
       ![reBankCardTextField.text isEqualToString:@""] &&
       ![branchBankNameTextField.text isEqualToString:@""] &&
       ![bankCityLabel.text isEqualToString:@""])
    {
        hasInput = YES;
    }
    else{
        hasInput = NO;
    }
    
    if (hasInput) {
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *classTitle;
    if (indexPath.row == 0)
    {
        AddBankTopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseAddBankTopCell forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[AddBankTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseAddBankTopCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(Ratio_OF_WIDTH_FOR_IPHONE6 == 1)
        {
            cell.bottomLineLeft.constant = 0;
            cell.bottomLineRight.constant = 0;
        }
        
        
        classTitle = @"开户名";
        cell.leftClassTitleLabel.text = classTitle;
        
        if ([ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname) {
            cell.userNameLabel.text = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
        }
        else
        {
            cell.userNameLabel.text = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.mobile;
        }
        
        cell.textField.text = @"";
        
        //银行卡标记位置
        CGSize size = [ZMTools calculateTheLabelSizeWithText:cell.textField.text font:cell.textField.font];
        
        cell.userNameTrailingAlignment.constant = size.width + 5;
        
        
        if(Ratio_OF_WIDTH_FOR_IPHONE6 == 1)
        {
            cell.bottomLineLeft.constant = 5;
            cell.bottomLineRight.constant = 5;
        }
        
        
        cell.topLine.hidden = NO;
        cell.bottomLine.hidden = NO;
        cell.bottomLongLine.hidden = YES;
        
        return cell;
    }
    if ((indexPath.row >0 && indexPath.row <= 4&&indexPath.row != 3)) {
        AddBankInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseAddBankInputCell forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[AddBankInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseAddBankInputCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(Ratio_OF_WIDTH_FOR_IPHONE6 == 1)
        {
            cell.bottomLineLeft.constant = 5;
            cell.bottomLineRight.constant = 5;
        }
        
        switch (indexPath.row) {
            case 1:
            {
                classTitle = @"银行卡号";
                cell.leftClassTitleLabel.text = classTitle;
                cell.bottomLine.hidden = NO;
                cell.topLine.hidden = YES;
                cell.bottomLongLine.hidden = YES;
                cell.textField.delegate = self;
                bankCardTextField = cell.textField;
                NSString *realName = @"";
                if ([ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname)
                {
                    realName = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.realname;
                }
                else
                {
                    realName = [ZMAdminUserStatusModel shareAdminUserStatusModel].adminuserBaseInfo.mobile;
                }

                bankCardTextField.placeholder = [NSString stringWithFormat:@"请输入%@的银行卡",realName];
                [bankCardTextField setKeyboardType:UIKeyboardTypeNumberPad];
            }
            break;
                
            case 2:
                classTitle = @"确认卡号";
                cell.leftClassTitleLabel.text = classTitle;
                cell.bottomLine.hidden = NO;
                cell.topLine.hidden = YES;
                cell.bottomLongLine.hidden = YES;
                cell.textField.delegate = self;
                reBankCardTextField = cell.textField;
                reBankCardTextField.placeholder = @"请确认银行卡";
                [reBankCardTextField setKeyboardType:UIKeyboardTypeNumberPad];
                break;
                
            case 4:
                classTitle = @"开户行";
                cell.leftClassTitleLabel.text = classTitle;
                cell.bottomLine.hidden = NO;
                cell.topLine.hidden = YES;
                cell.bottomLongLine.hidden = YES;
                cell.textField.delegate = self;
                
                branchBankNameTextField = cell.textField;
                branchBankNameTextField.placeholder = @"请选择开户银行";
                branchBankNameTextField.enabled = NO;
                break;
                
                
            default:
                break;
        }
        
        return cell;
    }
    else if(indexPath.row == 3 || indexPath.row ==6)
    {
        AddBankChoseInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseAddBankChoseInputCell forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[AddBankChoseInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseAddBankChoseInputCell];
        }
        
        if(Ratio_OF_WIDTH_FOR_IPHONE6 == 1)
        {
            cell.bottomLineLeft.constant = 5;
            cell.bottomLineRight.constant = 5;
        }
        
        if (indexPath.row ==6)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            classTitle = @"选择银行";
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = YES;
            
            bankNameLabel = cell.textField;
            
            //选定银行
            if (_allBankNameArray.count > 0) {
                NSDictionary * dic = [_allBankNameArray objectAtIndex:selectedBankInfoIndex];
                
                CLog(@"dic   ===    %@", dic);
                
                /*
                     bankNumber = 03080000;
                     code = cmb;
                     id = 1;
                     imgPath = "";
                     name = "\U62db\U5546\U94f6\U884c";
                     thirdPayType = LOCAL;
                 */
                
                bankNameLabel.text = [dic objectForKey:@"name"];
                
                bankTypeId = [[dic objectForKey:@"id"] integerValue];
                
                cell.bankIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]]];
            }
            else
            {
                bankNameLabel.text = @"";
            }
            
            //银行卡标记位置
            CGSize size = [ZMTools calculateTheLabelSizeWithText:bankNameLabel.text font:bankNameLabel.font];
            cell.bankIconTrailingAlignment.constant = size.width + 5;
            
//            cell.bankIcon.image = [UIImage imageNamed:@"bankIcon"];
            
            cell.leftClassTitleLabel.text = classTitle;
        }
        
        else if (indexPath.row == 3)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            classTitle = @"开户城市";
            cell.bottomLine.hidden = NO;
            cell.topLine.hidden = YES;
            cell.bottomLongLine.hidden = NO;
//            [cell.bottomLongLine setBackgroundColor:[UIColor redColor]];
            
            
            bankCityLabel = cell.textField;
            if(_selectedCityInfo != nil)
            {
                bankCityLabel.text = [_selectedCityInfo objectForKey:@"name"];
                cell.textField.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
            }
            else
            {
                bankCityLabel.text = @"请选择开户城市"; //没有值
                cell.textField.textColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1.0];
            }
            
            cell.bankIcon.hidden = YES;
            cell.leftClassTitleLabel.text = classTitle;
        }
        
        //刷新银行卡
        [self checkButtonStatus:nil];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ceil(48 * Ratio_OF_WIDTH_FOR_IPHONE6);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 0) {
        //hide the text input
        [self scrollViewWillBeginDragging:nil];
    }
    
    //选择省份－城市
    if (indexPath.row == 3) {
        
        //hide the text input
        [self scrollViewWillBeginDragging:nil];
        
        BankProvinceTableViewController * proviceList = [[BankProvinceTableViewController alloc] init];
        [self.navigationController pushViewController:proviceList animated:YES];
    }
    if (indexPath.row == 4) {
        if ([bankCardTextField.text isEqualToString:@""]) {
            [[HUD sharedHUDText] showForTime:2.0 WithText:@"请输入银行卡号"];

            return;
        }
        //判断银行卡
        if(![bankCardTextField.text isEqualToString:reBankCardTextField.text])
        {
            [[HUD sharedHUDText] showForTime:2.0 WithText:@"银行卡号不一致"];
            return;
        }

        if (![_selectedCityInfo objectForKey:@"cityCode"]) {
            [[HUD sharedHUDText] showForTime:2.0 WithText:@"请选择开卡城市"];
            
            return;
        }
        
        BankSelectViewController* bank = [[BankSelectViewController alloc] init];
        bank.cityCode = [_selectedCityInfo objectForKey:@"cityCode"];
        bank.cardNo = bankCardTextField.text;
//        bank.cardNo = @"6226220123455700";
        bank.block =  ^(NSString* name,NSString* backid)
        {
            branchBankNameTextField.textAlignment = NSTextAlignmentLeft;
            branchBankNameTextField.text =name;
            bankTypeId = [backid integerValue];
            [self checkButtonStatus:nil];

            
        };
//        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:bank];
//        [self presentViewController:bank animated:YES completion:nil];
        [self.navigationController pushViewController:bank animated:YES];
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


#pragma mark UIPickerView delegate ------------------------------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _allBankNameArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary * dic = [_allBankNameArray objectAtIndex:row];
    return [dic objectForKey:@"name"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    bankNumber = 03080000;
//    code = cmb;
//    id = 1;
//    imgPath = "";
//    name = "招商银行";
//    thirdPayType = LOCAL;
    
    selectedBankInfoIndex = row;
    NSArray *_array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [self.tableView reloadRowsAtIndexPaths:_array withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark  --------------------------- UIScrollView Delegate ------------------------------
/*
 * 上下滑动scroll 用于隐藏输入法
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [bankCardTextField resignFirstResponder];
    [reBankCardTextField resignFirstResponder];
    [branchBankNameTextField resignFirstResponder];
}
@end
