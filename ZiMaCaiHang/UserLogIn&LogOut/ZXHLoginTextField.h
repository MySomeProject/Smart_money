//
//  ZXHLoginTextField.h
//  ZMSD
//
//  Created by zima on 14-12-15.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXHLoginTextField : UIView
@property(nonatomic, strong) UIImage *leftImage;
@property(nonatomic, strong) NSString *placeholderText;

-(id)initWithFrame:(CGRect)frame withTarget:(id)tartget image:(UIImage *)leftImage placeholder:(NSString *)placeholderText;

@end
