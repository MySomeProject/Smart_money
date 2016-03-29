//
//  ScrollMenu.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "ScrollMenu.h"

#import "TopMenuScrollView.h"

@interface ScrollMenu ()<UIScrollViewDelegate, TopMenuScrollViewDelegate>
{
    NSArray * productCategoryArray;
    UIView * lineFlag;
    float _width;
    float _heihgt;
}
@end

@implementation ScrollMenu
@synthesize menuScrollView = _menuScrollView;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.menuScrollView.delegate = self;
            self.menuScrollView.topMenuDelegate = self;
            
            
            self.userInteractionEnabled = YES;
            self.menuScrollView.userInteractionEnabled = YES;
            
            
            //第一次启动，首页默认显示位置
            float _button_width = _width / 3;
            [_menuScrollView setContentOffset:CGPointMake(_button_width * -1, 0) animated:YES];
            _menuScrollView.currentIndex = -1;
            [self hideButton:self.leftButton];
            
        });
        
        if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone5s
        {
            _width = 200.0f;
            _heihgt = 60.0f;
        }
        else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
        {
            _width = 234.0f;
            _heihgt = 70.0f;
        }
        else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
        {
            _width = 258.0f;
            _heihgt = 77.0f;
        }
        
//        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [tempBtn setTitle:@"紫马贷" forState:UIControlStateNormal];
        
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:17.0f];
        CGSize size = [ZMTools calculateTheLabelSizeWithText:@"紫马贷" font:font];
        lineFlag = [[UIView alloc]init];
        lineFlag.frame = CGRectMake((WIDTH_OF_SCREEN - size.width)/2.0, _heihgt - size.height + 4, size.width, 2);
        [lineFlag setBackgroundColor:Color_of_Purple];
        [self addSubview:lineFlag];
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


-(IBAction)leftMoveAction:(UIButton *)sender
{
    [self showButton:self.rightButton];
    
    if(_menuScrollView.currentIndex < 0)
    {
        return;
    }
    else if (_menuScrollView.currentIndex >= 0 &&
             _menuScrollView.currentIndex <= _menuScrollView.pageCount - 1) {
        
        _menuScrollView.currentIndex = _menuScrollView.currentIndex - 1;
        if(_menuScrollView.currentIndex < 0)
        {
            [self hideButton:sender];
        }
        CLog(@"leftMoveAction index: %ld, pageCount: %ld", _menuScrollView.currentIndex, _menuScrollView.pageCount);
        
        NSInteger index = _menuScrollView.currentIndex;
        
        /*
         *  改变当前选中项
         */
        [self changingIndex:index];
        
        //按钮的宽度
        float _button_width = _width / 3;
        
        [_menuScrollView setContentOffset:CGPointMake(_button_width * index, 0) animated:YES];
    }
}

-(IBAction)rightMoveAction:(UIButton *)sender
{
    [self showButton:self.leftButton];
    
    if(_menuScrollView.currentIndex >= _menuScrollView.pageCount - 2)
    {
        return;
    }
    else if (_menuScrollView.currentIndex < _menuScrollView.pageCount - 2) {
        _menuScrollView.currentIndex = _menuScrollView.currentIndex + 1;
        
        if (_menuScrollView.currentIndex == _menuScrollView.pageCount - 2) {
            [self hideButton:sender];
        }
        
        CLog(@"rightMoveAction index: %ld, pageCount: %ld",
              _menuScrollView.currentIndex,
              _menuScrollView.pageCount);
        
        NSInteger index = _menuScrollView.currentIndex;

        /*
         *  改变当前选中项
         */
        [self changingIndex:index];
        
        //按钮的宽度
        float _button_width = _width / 3;
        
        [_menuScrollView setContentOffset:CGPointMake(_button_width * index, 0) animated:YES];
    }
}

//联动设置scrollMenu的位置
-(void)scrollMenuToIndex:(NSInteger)index
{
//    CLog(@"定部菜单滚动到：%ld", index);
    
    index = index - 1;
    _menuScrollView.currentIndex = index;
    
    CLog(@"定部菜单滚动到：%ld", index);
    //按钮的宽度
    float _button_width = _width / 3;
    
    [_menuScrollView setContentOffset:CGPointMake(_button_width * index, 0) animated:YES];
    
    
    
    
    
    if(_menuScrollView.currentIndex < 0)//最左边选中
    {
        [self hideButton:self.leftButton];
    }
    
    if(_menuScrollView.currentIndex >= 0 && _menuScrollView.currentIndex < _menuScrollView.pageCount - 2)//中间
    {
        [self showButton:self.leftButton];
        [self showButton:self.rightButton];
    }
    
    if (_menuScrollView.currentIndex == _menuScrollView.pageCount - 2)//最右边选中
    {
        [self hideButton:self.rightButton];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CLog(@"zhzhzhzhhzhzhzhh 怎么会滚动？？？");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CLog(@"WillBeginD %f", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CLog(@"DidEndDragging %f", scrollView.contentOffset.x);
    
    //按钮的宽度
    float _button_width = _width/3;
    
    int index =  scrollView.contentOffset.x / _button_width;
    float leave = scrollView.contentOffset.x - _button_width * index;
    
    if(leave <= _button_width/2.0)
    {
        _menuScrollView.currentIndex = index;
        [scrollView setContentOffset:CGPointMake(_button_width * index, 0) animated:YES];
    }
    else if(leave > _button_width/2.0)
    {
        _menuScrollView.currentIndex = index + 1;
        [scrollView setContentOffset:CGPointMake(_button_width * (index + 1), 0) animated:YES];
    }
    
    /*
     *  改变当前选中项
     */
    [self changingIndex:_menuScrollView.currentIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //按钮的宽度
    float _button_width = _width/3;
    
    int index =  scrollView.contentOffset.x / _button_width;
    float leave = scrollView.contentOffset.x - _button_width * index;
    
    if(leave <= _button_width/2.0)
    {
        _menuScrollView.currentIndex = index;
        [scrollView setContentOffset:CGPointMake(_button_width * index, 0) animated:YES];
    }
    else if(leave > _button_width/2.0)
    {
        _menuScrollView.currentIndex = index + 1;
        [scrollView setContentOffset:CGPointMake(_button_width * (index + 1), 0) animated:YES];
    }
    
    /*
     *  改变当前选中项
     */
    [self changingIndex:_menuScrollView.currentIndex];
}

-(void)tapMenuButtonChange:(NSInteger)productIndex
{
    CLog(@"MMMM productIndex == %ld, currentIndex = %ld", productIndex, _menuScrollView.currentIndex);

    NSInteger tempIndex = _menuScrollView.currentIndex + 1;
    if(tempIndex > productIndex)
    {
       [self leftMoveAction:nil];
    }
    else if (tempIndex == productIndex)
    {
        return;
    }
    else if (tempIndex < productIndex)
    {
        [self rightMoveAction:nil];
    }
}


/*
 * 隐藏按钮
 */
-(void)hideButton:(UIButton *)button
{
    dispatch_async(dispatch_get_main_queue(), ^{
       button.hidden = YES;
    });
}
/*
 * 显示按钮
 */
-(void)showButton:(UIButton *)button
{
    dispatch_async(dispatch_get_main_queue(), ^{
        button.hidden = NO;
    });
}


/*
 *  改变当前选中项
 */
-(void)changingIndex:(NSInteger)currentIndex
{
    self.scrollMenuChangeBlock(currentIndex);
}


@end
