//
//  HXImageEdtingViewController.h
//  miXin
//
//  Created by HAIXUN on 14-5-29.
//  Copyright (c) 2014年 HAIXUN. All rights reserved.
//


@protocol getCLipImage <NSObject>

-(void)getClipImage:(UIImage *)image inVC:(UIViewController*)vc;

@end
@interface HXImageEdtingViewController : UIViewController
@property(assign,nonatomic) id<getCLipImage>clipDelegate;
@property (strong, nonatomic)  UIScrollView *imageScroll;
@property(strong,nonatomic) UIImage *getImage;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic)  UIImageView *bgMaskView;

@end
