//
//  iDearViewController.h
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/1.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface iDearViewController : BaseViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgimg;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;
@property (weak, nonatomic) IBOutlet UITextView *idearTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderlabel;

@end
