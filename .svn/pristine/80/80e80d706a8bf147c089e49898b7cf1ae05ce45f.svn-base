//
//  ModifyUserInfoViewController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModifyUserInfoListDelegate<NSObject>
-(void)didSelectedUserInfoCell:(id)chosenData;
-(void)hidePickerView:(id)sender;
@end

@interface ModifyUserInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *EducationLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *MaritalLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *IndustryLabel;
@property (weak, nonatomic) IBOutlet UILabel *companySizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@property (assign, nonatomic) id <ModifyUserInfoListDelegate> delegate;
@end
