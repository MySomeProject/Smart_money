//
//  rizibaoTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  RizibaoTableViewCellDelegate<NSObject>

- (void)backToVC;

@end

@interface RizibaoTableViewCell : UITableViewCell<MBProgressHUDDelegate,UITextFieldDelegate>
{
    float totaldailyamount;
}
@property (nonatomic,strong) UIButton *nextStepButton;
@property (strong, nonatomic) IBOutlet UIView *cellContentView;
@property (strong, nonatomic) IBOutlet UITextField *moneyTextField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *rizibaoSyLabel;
@property (strong, nonatomic) IBOutlet UILabel *rizibaoAmountLabel;
@property (nonatomic,assign)id<RizibaoTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *upperLimitLabel;//单日上限提示


@property (nonatomic) CGFloat maxGetMoney;

@end
