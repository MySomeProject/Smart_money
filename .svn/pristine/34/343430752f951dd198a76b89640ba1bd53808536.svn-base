//
//  ZMConfirmViewController.m
//  ZMSD
//
//  Created by zima on 14-11-18.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMConfirmViewController.h"

#import "ZMFeatureView.h"

#import "ZXHMultiLineLabel.h"


#define Color_For_InvestmentButton     [UIColor colorWithRed:79.0/255 green:29.0/255 blue:90.0/255 alpha:1.0]
#define SPACE_OF_Y                     10

@interface ZMConfirmViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
{
    UITextField *inputAmountField;
    ZMFeatureView *anticipatedIncome;
    
    
    NSMutableString *currentString;
}
@end

@implementation ZMConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.title = @"输入投资金额";
    
    
    //输入框：
    inputAmountField = [[UITextField alloc]initWithFrame:CGRectMake(20, 64, WIDTH_OF_SCREEN - 2*20, 44)];
    [inputAmountField setTextAlignment:NSTextAlignmentCenter];
    [inputAmountField setPlaceholder:@"请输入投资金额"];
    [inputAmountField setBackgroundColor:[UIColor clearColor]];
    [inputAmountField setKeyboardType:UIKeyboardTypeDecimalPad];
    inputAmountField.delegate = self;
    
    
    //分割线：
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, inputAmountField.frame.origin.y + inputAmountField.frame.size.height,
                                                                  WIDTH_OF_SCREEN - 2*10,
                                                                  0.5)];
    [lineLabel setBackgroundColor:[UIColor grayColor]];
    
    
    
    //预计收益
    anticipatedIncome = [[ZMFeatureView alloc]initWith:FeatureTypeAnticipatedIncome data:@"0.00" font:[UIFont systemFontOfSize:15] frame:CGRectMake(10, lineLabel.frame.origin.y + lineLabel.frame.size.height, WIDTH_OF_SCREEN - 2*10, 30)];
    
    
    
    //描述
    NSString *infoString = @"该项目可以投资的金额是4,126,000元，起投金额为100元, 递增投资金额为100元。";
    
    //计算文字的显示高度
    float height = [ZXHMultiLineLabel heightForAttributedString:infoString withFont:[UIFont systemFontOfSize:16].fontName andFontSize:16 withSpecificWidth:WIDTH_OF_SCREEN - 2*10];
    
    ZXHMultiLineLabel *titleLabel = [[ZXHMultiLineLabel alloc] initWithFrame:CGRectMake(10,
                                                                                        anticipatedIncome.frame.origin.y + anticipatedIncome.frame.size.height + SPACE_OF_Y,
                                                                                        WIDTH_OF_SCREEN - 2*10, height)];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByCharWrapping;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor grayColor]];
    
    [titleLabel setText:infoString];
    
    
    
    
    
    
    //投资按钮
    
    UIButton *investmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [investmentButton setFrame:CGRectMake(20/2.0, titleLabel.frame.origin.y + titleLabel.frame.size.height + 2*SPACE_OF_Y, WIDTH_OF_SCREEN-20, 40)];
    [investmentButton setTitle:@"立即投资" forState:UIControlStateNormal];
    
    [investmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [investmentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [investmentButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [investmentButton setBackgroundColor:Color_For_InvestmentButton];
    [investmentButton addTarget:self action:@selector(investmentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    investmentButton.layer.cornerRadius = 3;
    
    
    
    
    [self.view addSubview:inputAmountField];
    [self.view addSubview:lineLabel];
    [self.view addSubview:anticipatedIncome];
    [self.view addSubview:titleLabel];
    [self.view addSubview:investmentButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  确认投资
 *
 *  @param button 确认按钮
 */
-(void)investmentAction:(UIButton *)button
{
    if([currentString isEqualToString:@""] || currentString == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请您输入抢投金额" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
    [inputAmountField resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认抢投？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UIAlertView delegate ------------------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            CLog(@"取消");
        }
            break;
        case 1:
        {
            CLog(@"确定");
        }
            break;
        case 2:
            
            break;
            
        default:
            break;
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
    
    [self anticipatedIncome:currentString];
    
    return YES;
}



/**
 *  根据投资金额，计算预计收益
 *
 *  @param currentInvestMoney 投资金额
 *
 *  @return  预计收益（已经转换成字符串）
 */

-(NSString *)anticipatedIncome:(NSString *)currentInvestMoney
{
    double income = currentInvestMoney.doubleValue * 0.17;
    [NSString stringWithFormat:@"%2f",income];
    CLog(@"%@", [NSString stringWithFormat:@"%.2f",income]);
    
    [anticipatedIncome setDataString:[NSString stringWithFormat:@"%.2f",income]];
    
    return [NSString stringWithFormat:@"%.2f",income];
}


@end
