//
//  ZXHLoginTextField.m
//  ZMSD
//
//  Created by zima on 14-12-15.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZXHLoginTextField.h"
#import "UIViewExt.h"

@implementation ZXHLoginTextField
@synthesize leftImage = _leftImage;
@synthesize placeholderText = _placeholderText;


-(id)initWithFrame:(CGRect)frame withTarget:(id)tartget image:(UIImage *)leftImage placeholder:(NSString *)placeholderText;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背板
        UIView *tempBackgroundView = [[UIView alloc] init];
        [tempBackgroundView setBackgroundColor:[UIColor clearColor]];
        tempBackgroundView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        tempBackgroundView.layer.cornerRadius = 3.0;
        
        //人物图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (frame.size.height - 20)/2, 20, 20)];
        [imageView setImage:leftImage];
        
        //分割线
        UILabel *verticalLine = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, 0, 1, frame.size.height)];
//        [verticalLine setBackgroundColor:Color_For_Main_LightGray];
        [verticalLine setBackgroundColor:[UIColor clearColor]];
        
        //输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.tag = 100;
        textField.frame = CGRectMake(verticalLine.right + SPACE10_WITH_BORDER, 0, tempBackgroundView.bounds.size.width - (verticalLine.right + 2 * SPACE10_WITH_BORDER), frame.size.height);

        
        
        textField.textAlignment = NSTextAlignmentLeft;
        [textField setPlaceholder:placeholderText];
        textField.returnKeyType = UIReturnKeyDone;
        
        textField.enablesReturnKeyAutomatically = YES;
        
        textField.delegate = tartget;   //设置外部代理
        
        [tempBackgroundView addSubview:imageView];
        [tempBackgroundView addSubview:verticalLine];
        [tempBackgroundView addSubview:textField];
        [self addSubview:tempBackgroundView];
    }
    return self;
}


@end
