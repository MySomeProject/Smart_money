//
//  HUD.m
//  Space
//
//  Created by isaced on 14-5-27.
//  Copyright (c) 2014年 isaced. All rights reserved.
//

#import "HUD.h"
//#import "HTTPError.h"

#define kDefaultYOffset 0.f

#define kDefaultErrorMessage @"error!"

@implementation HUD


-(void)showTimeWithText:(NSString *)str{
    [self setLabelText:str];
    [self setYOffset:kDefaultYOffset];
    [self show:YES];
    [self hide:YES afterDelay:2];
}
//-(void)showTimeWithError:(HTTPError *)error{
//    if (error.isShow == YES) {
//        [self showTimeWithText:error.message];
//    }else{
//        [self showTimeWithText:kDefaultErrorMessage];
//    }
//}

-(void)showTimeWithText:(NSString *)str yOffset:(float)yOffset{
    [self setLabelText:str];
    [self setYOffset:yOffset];
    [self show:YES];
    [self hide:YES afterDelay:2];
}
//-(void)showTimeWithError:(HTTPError *)error yOffset:(float)yOffset{
//    if (error.isShow == YES) {
//        [self showTimeWithText:error.message yOffset:yOffset];
//    }else{
//        [self showTimeWithText:kDefaultErrorMessage yOffset:yOffset];
//    }
//}


- (void)showForTime:(NSTimeInterval)s WithText:(NSString *)str{
    [self setLabelText:str];
    [self setYOffset:kDefaultYOffset];
    [self show:YES];
    [self hide:YES afterDelay:s];
}

+ (instancetype)sharedHUD{
    static HUD *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _sharedClient = [[HUD alloc] initWithWindow:window];
      //  [_sharedClient setMode:MBProgressHUDModeText];
        [window addSubview:_sharedClient];
    });
    return _sharedClient;
}

+ (instancetype)sharedHUDText{
    static HUD *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _sharedClient = [[HUD alloc] initWithWindow:window];
        _sharedClient.mode = MBProgressHUDModeText;
//        _sharedClient.yOffset = kDefaultYOffset;
//        _sharedClient.labelFont = [UIFont systemFontOfSize:14.f];
//        _sharedClient.margin = 10;

        [window addSubview:_sharedClient];
    });
    return _sharedClient;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
