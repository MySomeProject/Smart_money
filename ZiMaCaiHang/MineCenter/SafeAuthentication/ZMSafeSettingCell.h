//
//  ZMSafeSettingCell.h
//  ZMSD
//
//  Created by zima on 14-11-21.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSafeSettingCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *leftClassTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@property (nonatomic, weak) IBOutlet UIImageView *arrowIcon;
@property (nonatomic, weak) IBOutlet UIImageView *topLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLine;
@property (nonatomic, weak) IBOutlet UIImageView *bottomLongLine;
@end
