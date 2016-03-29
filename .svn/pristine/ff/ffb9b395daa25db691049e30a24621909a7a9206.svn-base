//
//  HUD.h
//  Space
//
//  Created by isaced on 14-5-27.
//  Copyright (c) 2014年 isaced. All rights reserved.
//

#import "MBProgressHUD.h"

@class HTTPError;

@interface HUD : MBProgressHUD

/**
 *  Singleton
 */
+ (instancetype)sharedHUD;


/**
 *  Singleton HUD With Text
 */
+ (instancetype)sharedHUDText;


// -----  For Text HUD -----

/**
 *  Show For Default time
 */
- (void) showTimeWithText:(NSString *)str;
- (void) showTimeWithError:(HTTPError *)error;

/**
 *  Show For Default time With
 */
- (void) showTimeWithText:(NSString *)str yOffset:(float)yOffset;
- (void) showTimeWithError:(HTTPError *)error yOffset:(float)yOffset;

/**
 *  Show For How second
 */
- (void)showForTime:(NSTimeInterval)s WithText:(NSString *)str;

// -----  For Text HUD -----

@end
