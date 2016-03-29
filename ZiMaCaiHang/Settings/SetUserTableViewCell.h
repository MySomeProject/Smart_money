//
//  SetUserTableViewCell.h
//  ZiMaCaiHang
//
//  Created by jxgg on 15/6/29.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIButton *cellExitBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftloginbtn;
@property (weak, nonatomic) IBOutlet UIButton *rightResignbtn;
@property (weak, nonatomic) IBOutlet UILabel *loginlabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UIButton *userButton;

@end
