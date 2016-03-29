//
//  SecretaryScrollCellView.h
//  miXin
//
//  Created by HAIXUN on 10/11/14.
//  Copyright (c) 2014 HAIXUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSecretaryView.h"
#import "HXWebViewController.h"

@protocol SecretaryScrollCellViewDelegate <NSObject>

-(void)openSecretaryDetailsWithUrl:(NSString *)url;

@end

@interface SecretaryScrollCellView : UIView<UIScrollViewDelegate, SingleSecretaryViewDelegate>
{
    NSInteger pageNumber; //页码
    NSInteger currentPage; //当前页码
    UIScrollView * secretaryScrollView;
    UIPageControl * pageControl;
    
//    NSMutableArray * secretaryArray; //临时的所有的小秘数据
    NSMutableArray * staticAdsArray;   //所有Ad banner数据
    
    NSTimer *autoSlideTimer;
}


@property(assign, nonatomic) id <SecretaryScrollCellViewDelegate>  delegate;

@end
