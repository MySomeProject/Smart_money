//
//  SingleSecretaryView.h
//  miXin
//
//  Created by HAIXUN on 10/11/14.
//  Copyright (c) 2014 HAIXUN. All rights reserved.
//

#import <UIKit/UIKit.h>
//自定义可设置字间距和行间距的Label
#import "ZXHMultiLineLabel.h"

@protocol SingleSecretaryViewDelegate <NSObject>

-(void)singleSecretaryTapped:(NSString *)UrlString;

@end

@interface SingleSecretaryView : UIView
{
    UIImageView *imageView;
    
    UIView * titleLabelBackground;
    ZXHMultiLineLabel * titleLabel;
    
    UILabel * subTitleLabel;
    NSDictionary * secretaryDic;
    
    NSString * UrlString;  //url string
}

@property (assign, nonatomic) id <SingleSecretaryViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)info;

@end
