//
//  AddBankTopCell.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankTopCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *leftClassTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *textField;
@property (nonatomic, weak) IBOutlet UIImageView *topLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLongLine;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameTrailingAlignment;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineRight;

@end
