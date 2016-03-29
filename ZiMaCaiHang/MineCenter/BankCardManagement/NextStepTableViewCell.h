//
//  NextStepTableViewCell.h
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextStepTableViewCell : UITableViewCell
{
    UIButton *_nextStepButton;
}
@property (nonatomic,strong) UIButton *nextStepButton;


@property (nonatomic,strong) __block void (^showRechargeBlock)();
- (void)isHiddenNextButton:(BOOL)isHidden;
@end
