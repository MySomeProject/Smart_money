//
//  GetCashViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCashViewController : UIViewController<MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    UIButton *_nextStepButton;
}

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableAmountLabel; //账户余额
@property (weak, nonatomic) IBOutlet UILabel *maxCashAmountLabel;   //最大可提现金额

@property (weak, nonatomic) IBOutlet UITextField *amountLabel;//实际提现金额
@property (weak, nonatomic) IBOutlet UITextField *branchBankNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *cityChoseButton;     //城市选择按钮
@property (weak, nonatomic) IBOutlet UITextField *bankCityLabel;    //银行所属城市

@property (weak, nonatomic) IBOutlet UILabel *cityTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankIconTrailingAlignment;
@property (weak, nonatomic) IBOutlet UIImageView *bankLogo;
@property (weak, nonatomic) IBOutlet UILabel *bankName;

@property (weak, nonatomic) IBOutlet UIPickerView *bankPicker;


@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;   //提现累计提示（已经临时做隐藏）

//@property (nonatomic) NSMutableArray  *userBankArray;

//获取已经选择到的城市信息
@property (nonatomic, strong) NSDictionary * selectedCityInfo;
-(void)setSelectedCityInfo:(NSDictionary *)cityInfo;
@end
