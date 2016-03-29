//
//  ZMNikeNameSettingViewController.m
//  ZMSD
//
//  Created by zima on 14-12-24.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMNikeNameSettingViewController.h"

#import "HUD.h"

@interface ZMNikeNameSettingViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate>
{
    //昵称输入框
    UITextField *textField;
    
    NSMutableString *currentString;
    
    //The confirm action button
    UIButton *nextStepButton;
}
@end

@implementation ZMNikeNameSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"昵称设置";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //输入框tableView背板（可上下弹动）
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-2)
                                                                    style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 20)];
    [tableHeader setBackgroundColor:[UIColor whiteColor]];
    self.tableView.tableHeaderView = tableHeader;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //确认设置
    nextStepButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextStepButton setFrame:CGRectMake(20/2.0, 110, [UIScreen mainScreen].bounds.size.width-20, 44)];
    [nextStepButton setTitle:@"确 认" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    
    //默认情况下为非响应状态：
    nextStepButton.enabled = NO;
    [nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
    nextStepButton.layer.cornerRadius = 3.0;
    [nextStepButton addTarget:self action:@selector(confirmNikeNameAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.tableView addSubview:nextStepButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//确认昵称设置
-(void)confirmNikeNameAction:(UIButton *)button
{
#warning 判断昵称长度限制为16个字符
    
    if (currentString.length > 16)
    {
        [[HUD sharedHUDText] showForTime:2.5 WithText:@"昵称不能超过16个字符"];
        
        textField.text = [currentString substringToIndex:16];
        currentString = (NSMutableString *)[currentString substringToIndex:16];
        return;
    }
    
    
    [[ZMServerAPIs shareZMServerAPIs] setNikeName:currentString success:^(id response) {
        CLog(@"确认昵称设置 %@", response);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.nikeNameAuthenticationBlock(YES);   //昵称认证成功
            
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"成功" message:@"昵称设置成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alter.tag = 10001;
            [alter show];
        });
    } failure:^(id response) {
        CLog(@"失败昵称设置 %@", response);

        if(response == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常，请稍候再试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                alertView.tag = 10003;
                [alertView show];
            });
        }
        
        //{"data":{"message":"用户已经存在","result":2002},"code":1000}
        if ([[response objectForKey:@"code"] integerValue] == 1000 &&
            [[[response objectForKey:@"data"] objectForKey:@"result"] integerValue] == 2002)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此昵称已经存在，请更换昵称！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                alertView.tag = 10002;
                [alertView show];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *failMessage = @"昵称认证失败，请稍后再试";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:failMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                alertView.tag = 10002;
                [alertView show];
            });
        }
    }];
}


//检查是否有输入
- (void)checkButtonStatus:(BOOL)hasInput
{
    if(![textField.text isEqualToString:@""])
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
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"tableViewInLoginView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        
        //背板
        UIView *tempBackgroundView = [[UIView alloc] init];
        tempBackgroundView.frame = CGRectMake(SPACE20_WITH_BORDER, 0, [UIScreen mainScreen].bounds.size.width - 2*SPACE20_WITH_BORDER, 44);
        
        
        //标题
        //        UILabel *leftTitleLabel = [[UILabel alloc] init];
        //        leftTitleLabel.userInteractionEnabled = NO;
        //        leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        //        leftTitleLabel.frame = CGRectMake(0, 0, 80, 44);
        //        [leftTitleLabel setBackgroundColor:[UIColor redColor]];
        //        [leftTitleLabel setText:@"手机号码"];
        
        //手机图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (cell.contentView.frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"nikeName.png"]];
        
        
        //输入框
        textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(imageView.frame.size.width + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (imageView.frame.size.width + SPACE10_WITH_BORDER), 44);

        //        [textField setKeyboardType:UIKeyboardTypePhonePad];
        
        textField.textAlignment = NSTextAlignmentLeft;
        [textField setPlaceholder:@"请输入昵称"];
        [textField setBackgroundColor:[UIColor whiteColor]];
        textField.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkButtonStatus:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
        
        
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(-5, tempBackgroundView.frame.size.height-1, tempBackgroundView.frame.size.width+10, 0.5)];
        [lineLabel setBackgroundColor:[UIColor lightGrayColor]];
        
        
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:textField];
        [tempBackgroundView addSubview:lineLabel];
        [cell.contentView addSubview:tempBackgroundView];
        
        
        [tempBackgroundView setBackgroundColor:[UIColor clearColor]];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [textField setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
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
    if(10001 == alertView.tag)
    {
        switch (buttonIndex) {
            case 0:
            {
                CLog(@"好的");
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            default:
                break;
        }
    }
    
    if(10002 == alertView.tag)
    {
        switch (buttonIndex) {
            case 0:
            {
                CLog(@"好的");
                textField.text = @"";
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
