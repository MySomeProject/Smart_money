//
//  SingleSecretaryView.m
//  miXin
//
//  Created by HAIXUN on 10/11/14.
//  Copyright (c) 2014 HAIXUN. All rights reserved.
//

#import "SingleSecretaryView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation SingleSecretaryView

- (id)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        
        secretaryDic = info;
        
        
//        CLog(@"SingleSecretaryView info : %@", secretaryDic);
        
//        {
//            Id = 0;
//            bgimg = "bannerImg/20150506151850banner_1.png";
//            loanId = "-1";
//            orderIndex = 1;
//            picUrl = "http://static.zimacaihang.com/";
//            url = "active.htm";
//        }
        
        
        if ([info valueForKey:@"url"]) {
            
//            UrlString = @"https://www.zimacaihang.com/";
            
            UrlString = [info valueForKey:@"url"];
        }
        else
        {
            UrlString = @"http://www.baidu.com";
        }
        
//        bgimg = "bannerImg/20150506151850banner_1.png";
//        bgimg = "banner1.png";
        
        NSString *imageName = [[info valueForKey:@"bgimg"] substringToIndex:9];
        
        if (![imageName isEqualToString:@"bannerImg"]) {
            NSArray *tempArray = [[info valueForKey:@"bgimg"] componentsSeparatedByString:@"."];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[tempArray objectAtIndex:0] ofType:[tempArray objectAtIndex:1]];
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]]];
            
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [imageView setUserInteractionEnabled:YES];
            [imageView sd_setImageWithURL:[NSURL fileURLWithPath:filePath]
                         placeholderImage:image
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    
                                }];
        }
        else
        {
            //图片
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            
            [imageView setUserInteractionEnabled:YES];
            
            NSString *bannerStr = [NSString stringWithFormat:@"%@%@", [info valueForKey:@"picUrl"], [info valueForKey:@"bgimg"]];
            bannerStr = [bannerStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL* bannerUrl = [NSURL URLWithString:bannerStr];
            
            [imageView sd_setImageWithURL:bannerUrl placeholderImage:[UIImage imageNamed:@"BannerPl"]];
        }
        
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
        [imageView addGestureRecognizer:tap];
    }
    return self;
}


- (void)singleTap
{
    CLog(@"选中的banner ID   %ld", [[secretaryDic valueForKey:@"Id"] integerValue]);
    
    if ([self.delegate respondsToSelector:@selector(singleSecretaryTapped:)]) {
        [self.delegate singleSecretaryTapped:UrlString];
    }
}

@end
