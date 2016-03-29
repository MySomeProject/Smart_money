//
//  ZMSafeInputCell.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSafeInputCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *leftClassTitleLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIImageView *topLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLongLine;
@end
