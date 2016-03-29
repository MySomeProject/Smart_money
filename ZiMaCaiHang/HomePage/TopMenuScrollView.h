//
//  TopMenuScrollView.h
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-16.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopMenuScrollViewDelegate <NSObject>
-(void)tapMenuButtonChange:(NSInteger)index;
@end

@interface TopMenuScrollView : UIScrollView

//typedef void(^TapMenuButtonChangeBlock)(NSInteger productIndex);
//@property (nonatomic, copy) TapMenuButtonChangeBlock tapMenuButtonChangeBlock;

@property (nonatomic, assign) id <TopMenuScrollViewDelegate> topMenuDelegate;

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger pageCount;
@end
