//
//  ScrollMenu.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopMenuScrollView.h"

@interface ScrollMenu : UIView

//滚动菜单的回调
typedef void(^ScrollMenuChangeBlock)(NSInteger productIndex);
@property (nonatomic, copy) ScrollMenuChangeBlock scrollMenuChangeBlock;


@property (nonatomic, strong) IBOutlet TopMenuScrollView * menuScrollView;

@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;

-(IBAction)leftMoveAction:(UIButton *)sender;
-(IBAction)rightMoveAction:(UIButton *)sender;

-(void)scrollMenuToIndex:(NSInteger)index;

@end
