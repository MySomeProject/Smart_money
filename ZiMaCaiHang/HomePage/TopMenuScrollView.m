//
//  TopMenuScrollView.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-16.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "TopMenuScrollView.h"

@interface TopMenuScrollView ()<UIScrollViewDelegate>
{
    NSArray * productCategoryArray;    
    float _width;
    float _heihgt;
}
@end

@implementation TopMenuScrollView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CLog(@"ScrollMenu === %@", NSStringFromCGRect(self.frame));

        self.userInteractionEnabled = YES;
        
        self.directionalLockEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.currentIndex = -1;  //默认指示第一个
//        productCategoryArray = @[@"日紫宝", @"月满盈", @"季季丰", @"双季鑫", @"年年红"];
        productCategoryArray = @[@"新手产品", @"日紫宝", @"月满盈", @"季季丰", @"双季鑫", @"年年红"];
        self.pageCount = productCategoryArray.count;
        
        [self setupViews];
    }
    return self;
}

/*
 * 添加
 */
#define kTabBarTextFontName      @"Helvetica"

-(void)setupViews
{
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
    
    
    //按钮的宽度
    float _button_width = _width / 3;
    
    for (int i = 0; i < [productCategoryArray count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(_button_width * i, 0, _button_width, _heihgt)];
        [btn setTitle:productCategoryArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1000;
        
        //文字超过三个字的
        NSString * productNameString = productCategoryArray[i];
        if(productNameString.length > 3)
        {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, -8)];
            [btn.titleLabel setFont:[UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize - 2]];
        }

        
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    [self setContentSize:CGSizeMake(_button_width * [productCategoryArray count], _heihgt)];
}


-(void)actionbtn:(UIButton *)button
{
    CLog(@"被点击的按钮是：%@, index = %d", productCategoryArray[button.tag - 1000], button.tag - 1000);
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:button];
    [self performSelector:@selector(todoSomething:) withObject:button afterDelay:0.3f];
}

- (void)todoSomething:(UIButton *)button
{
    //在这里做按钮的想做的事情。
    if([self.topMenuDelegate respondsToSelector:@selector(tapMenuButtonChange:)])
    {
        [self.topMenuDelegate tapMenuButtonChange:(button.tag - 1000)];
    }
}


@end
