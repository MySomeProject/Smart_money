//
//  PatternLockView.h
//  ZMSD
//
//  Created by zima on 14-12-2.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAmeview.h"

#define k_PatternPassword    @"Pattern_Password_Key"

typedef void(^ForgetPatternPasswordBlock)(void);

@interface PatternLockView : UIImageView <UIAlertViewDelegate>
{
    id _target;
    SEL _action;
}
@property (nonatomic, strong)NAmeview *nameView;
@property (nonatomic, strong)UIButton *forgottenPWDButton;
//@property (nonatomic,strong)UIButton *ChooseFTUButton;
@property (nonatomic, assign)BOOL isSettingLock;

@property (nonatomic, strong)UILabel *topInfoLabel;

@property (nonatomic, strong)NSString *tempPassword;
@property (nonatomic, assign)NSInteger settingNumberOfTimes;
@property (nonatomic, strong)ForgetPatternPasswordBlock forgetPatternPasswordBlock;

/**
 *  @param frame
 *  @param settingLock 是否是设置手势密码，settingLock == NO表示解锁，YES表示设置密码
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame forSettingLock:(BOOL) settingLock;

//成功的回调
- (void)setTarget:(id)target withAction:(SEL)action;

//删除手势密码
+(void)deletePatternPassword;
@end
