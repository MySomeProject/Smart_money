//
//  GetCashViewIp4ViewController.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/6/5.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCashViewIp4ViewController : UIViewController<UIScrollViewDelegate>
{
    UIButton *_nextStepButton;
}
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxCashAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;
@property (weak, nonatomic) IBOutlet UITextField *branchBankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cityChoseButton;
@property (weak, nonatomic) IBOutlet UIImageView *bankLogo;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UIPickerView *bankPicker;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//获取已经选择到的城市信息
@property (nonatomic, strong) NSDictionary * selectedCityInfo;
-(void)setSelectedCityInfo:(NSDictionary *)cityInfo;
@end
