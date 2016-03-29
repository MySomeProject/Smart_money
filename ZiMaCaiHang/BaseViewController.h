//
//  BaseViewController.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-3.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMNavigationController.h"

@interface BaseViewController : ZMNavigationController
//@interface BaseViewController : UIViewController

@property(strong,nonatomic) UIScrollView *tablesScrollView;
@property(assign,nonatomic) NSInteger currentIndex;   //当前序号

@end
