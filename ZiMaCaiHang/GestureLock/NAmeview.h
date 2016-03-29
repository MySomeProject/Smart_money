//
//  NAmeview.h
//  ADDD
//
//  Created by 206 on 13-7-9.
//  Copyright (c) 2013年 吴丁虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAmeview : UIView{

    NSMutableArray *buttonArray;
    NSMutableArray *selectedButtonArray;
    CGPoint curentpoint;
    UITextField *resulttext;
    UIView* midNumView;
    UIView* topNumView;
    UIImageView* headerImg;
    id _target;
    SEL _action;
}

- (void)setTarget:(id)target withAction:(SEL)action;
-(void)isUnlock:(BOOL)unlock;

@end
