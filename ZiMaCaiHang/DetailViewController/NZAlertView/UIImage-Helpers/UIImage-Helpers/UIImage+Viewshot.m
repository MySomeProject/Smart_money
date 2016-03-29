//
//  UIImage+Viewshot.m
//  hhhh
//
//  Created by HAIXUN on 14-7-3.
//  Copyright (c) 2014年 NewRead. All rights reserved.
//

#import "UIImage+Viewshot.h"

@implementation UIImage (Viewshot)

+ (UIImage *)viewshot:(UIView *)targetView;
{
    CGSize imageSize = [targetView bounds].size;
//    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    } else {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
//        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        if(targetView)
        {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [targetView center].x, [targetView center].y);
            
            CGContextConcatCTM(context, [targetView transform]);
            
            CGContextTranslateCTM(context,
                                  -[targetView bounds].size.width * [[targetView layer] anchorPoint].x,
                                  -[targetView bounds].size.height * [[targetView layer] anchorPoint].y);
            
            [[targetView layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
