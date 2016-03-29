//
//  PatternLockView.m
//  ZMSD
//
//  Created by zima on 14-12-2.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "PatternLockView.h"
#import "HUD.h"
#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "GTCommontHeader.h"
#import "AudioToolbox/AudioToolbox.h"
//#import "ZMLogInViewForPattern.h"
#define COUNT_NUM_SS @"CountNumOfSS" //存储手势密码次数防止，退出程序后仍然能重置输入手势密码次数；

@implementation PatternLockView

- (void)lockEntered:(NSString*)key {
    
    CLog(@"key: %@", key);
    
    if([key isEqualToString:@""]) ///没有值，表示没有设置成功
    {
        return;
    }
    
    if ([key length] < 3) {
        [[HUD sharedHUDText] showForTime:1.5 WithText:@"密码至少三位!"];
        return;
    }
    
    if(self.isSettingLock) //设置手势锁
    {
        [self setTopNotiInfo:@"请输入手势密码"];
        
        if (self.settingNumberOfTimes == -1) {  //第一次输入
            self.settingNumberOfTimes = 1;
            _tempPassword = key;
            
            [self setTopNotiInfo:@"请再次绘制解锁图案"];
        }
        else if(self.settingNumberOfTimes == 1) //第二次输入
        {
            //判断两次是否相同
            if ([key isEqualToString:_tempPassword])
            {
                /**
                 *  手势密码设置成功
                 */
                [self savePassword:_tempPassword]; //保存密码
                
                self.tempPassword = nil;
                self.settingNumberOfTimes = -1;
                [self setTopNotiInfo:@"设置成功"];
                
                
                if (_target && _action)
                    [_target performSelector:_action withObject:[NSNumber numberWithBool:YES]];
                
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"好的", nil];
                [alertView show];
            }
            //两次不同，重新设置
            else
            {
                [self setTopNotiInfo:@"两次绘制不一致，请重新绘制"];
                self.settingNumberOfTimes = -1;
            }
        }
    }
    
    else{//解锁
        if ([key isEqualToString:[self getPassword]])
        {
            self.alpha= 0.75;
            [UIView animateWithDuration:.15 animations:^{
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.15f, 1.15f);
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",5] forKey:COUNT_NUM_SS];

            //移除进入主界面
        }
        else
        {
            int touchcount = [[[NSUserDefaults standardUserDefaults] objectForKey:COUNT_NUM_SS] intValue];
            if (touchcount > 0) {
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

                [self shakeAnimationForView:self.topInfoLabel];
                self.topInfoLabel.text = [NSString stringWithFormat:@"密码错误，您还可以再输入%d次",touchcount];
                touchcount = touchcount - 1;
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",touchcount] forKey:COUNT_NUM_SS];
    
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",5] forKey:COUNT_NUM_SS];
#warning 输入次数过多跳转到登录界面
                [self forgottenPWDButtonAction:nil];
            }
        }
    }
}

-(void)shakeAnimationForView:(UIView*)view{
    CALayer* viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x +15, position.y );
    CGPoint y = CGPointMake(position.x -15, position.y );
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setFromValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

/**
 *  成功（或失败）的回调
 *
 */
- (void)setTarget:(id)target withAction:(SEL)action
{
    _target = target;
    _action = action;
}

- (void)setTopNotiInfo:(NSString *)infoString
{
    self.topInfoLabel.text = [NSString stringWithFormat:@"%@", infoString];
}

- (id)initWithFrame:(CGRect)frame forSettingLock:(BOOL) settingLock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.isSettingLock = settingLock;

        CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:frame];

        //1 可以使用背景图片
//                backgroundView.image = [UIImage imageNamed:@"lockBackgroundImage.png"];
        
        //2 使用颜色背景
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
//        [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0/255.0
//                                                           green:82.0/255.0
//                                                            blue:66.0/255.0
//                                                           alpha:1.0]];
        [self addSubview:backgroundView];
        

        
        _nameView = [[NAmeview alloc]initWithFrame:frame];
        [_nameView setBackgroundColor:[UIColor clearColor]];
        [self addSubview: _nameView];
        
        [_nameView setTarget:self withAction:@selector(lockEntered:)];
        
        
        
        //忘记密码层
        //按钮的宽高 72
        //按钮之间的距离
        float space_x = ([[UIScreen mainScreen]bounds].size.width - 72*3)/4;
//        float space_y = space_x;
        
        //按钮形成的矩形所占据的长宽
        float square_w = 2 * space_x + 3 * 72;
        
        //第一排按钮距离屏幕上边界的距离
        float space_to_top = ([[UIScreen mainScreen]bounds].size.height - square_w) / 2;
        
        CGRect lebelRect = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 300)/2,
                                       space_to_top - space_x - 40, 300, 40);
        lebelRect = CGRectMake(0, GTFixHeightFlaot(126+64), WIDTH_OF_SCREEN, 30);
        self.topInfoLabel = [[UILabel alloc]initWithFrame:lebelRect];
        [self.topInfoLabel setBackgroundColor:[UIColor clearColor]];
        self.topInfoLabel.textAlignment = NSTextAlignmentCenter;
        [self.topInfoLabel setTextColor:[ZMTools ColorWith16Hexadecimal:@"5e5e5e"]];
        [self.topInfoLabel setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(16)]];
        self.topInfoLabel.alpha = 0;

        [self addSubview:self.topInfoLabel];
        
        if (self.isSettingLock) {
            [_nameView isUnlock:NO];
            self.topInfoLabel.alpha = 1;

            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",5] forKey:COUNT_NUM_SS];


            //提示语句
            [self.topInfoLabel setBackgroundColor:[UIColor clearColor]];
            self.topInfoLabel.text = [NSString stringWithFormat:@"请绘制解锁图案"];
            if (HEIGHT_OF_SCREEN == 480) {
                [self.topInfoLabel setOrigin:CGPointMake(self.topInfoLabel.left,self.topInfoLabel.top-80)];
            }
            
            
            self.settingNumberOfTimes = -1;
        }
        
        if(!self.isSettingLock)
        {
            //欢迎语句
            [_nameView isUnlock:YES];
       
            NSString *welcomeWord = [NSString stringWithFormat:@"%@,欢迎您回来",             [[NSUserDefaults standardUserDefaults]objectForKey:@"unlockUserName"]];

            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"unlockUserName"]) {
                welcomeWord = @"欢迎您回来";
            }
            

            [self.topInfoLabel setBackgroundColor:[UIColor clearColor]];
//            self.topInfoLabel.text = [NSString stringWithFormat:@"请录入手势密码"];
            self.topInfoLabel.text = [NSString stringWithFormat:@"%@", welcomeWord];
            [self.topInfoLabel setOrigin:CGPointMake(self.topInfoLabel.left,GTFixHeightFlaot(135))];
            [UIView animateWithDuration:5.0f animations:^{
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:.25 animations:^{
                    self.topInfoLabel.alpha = 1;
                }];
            }];
            
            
            self.settingNumberOfTimes = 5;
            
            CGRect buttonRect = CGRectMake([[UIScreen mainScreen]bounds].size.width - 100 - space_x,
                                           space_to_top + square_w + space_x, 140, 40);
            
            self.forgottenPWDButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.forgottenPWDButton setFrame:buttonRect];
            [self.forgottenPWDButton setTitle:@"忘记手势密码？" forState:UIControlStateNormal];
            [self.forgottenPWDButton setTitleColor:[ZMTools ColorWith16Hexadecimal:@"e32e1d"] forState:UIControlStateNormal];
            [self.forgottenPWDButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [self.forgottenPWDButton.titleLabel setFont:[UIFont boldSystemFontOfSize:GTFixHeightFlaot(12)]];
            [self.forgottenPWDButton addTarget:self action:@selector(forgottenPWDButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.forgottenPWDButton.center = CGPointMake(WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN-GTFixHeightFlaot(40));
            if (HEIGHT_OF_SCREEN == 480) {
                self.forgottenPWDButton.center = CGPointMake(WIDTH_OF_SCREEN/2, HEIGHT_OF_SCREEN-GTFixHeightFlaot(30));
            }
            [self addSubview:self.forgottenPWDButton];

            //初始化上下文对象
            LAContext *context = [[LAContext alloc] init];
            NSError *error = nil;
            context.localizedFallbackTitle = @"手势解锁";
            //使用canEvaluatePolicy 判断设备支持状态
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                CLog(@"Touch ID is available.");
                //支持指纹验证
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"录入指纹解锁", nil) reply:^(BOOL success, NSError *error) {
                    
                    if (success) {
                        CLog(@"aaaaaaa");
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [UIView animateWithDuration:.15 animations:^{
                                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.15f, 1.15f);
                                self.alpha = 0;
                            } completion:^(BOOL finished) {
                                [self removeFromSuperview];
                            }];
                            
                        }];
                        
                    } else{
                        
                        CLog(@"%@",error.localizedDescription);
                        switch (error.code) {
                            case LAErrorSystemCancel:{
                                //切换到其他app，系统取消验证Touch ID
                                
                                CLog(@"Authentication was cancelled by the systerm");
                                break;
                            }
                            case LAErrorUserCancel:{
                                //用户取消验证Touch ID
                                
                                CLog(@"Authentication was canselfcelled by the user");
                                break;
                            }
                            case LAErrorUserFallback:{
                                //用户选择输入密码
                                
                                CLog(@"User selected to enter custom password");
                                //用户选择输入密码，切换主线程处理
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                }];
                                break;
                            }
                                
                            default:{
                                
                                //其他情况，切换主线程处理
                                
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                }];
                                break;
                            }
                                
                        }
                        /*
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not the device owner!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                         [alert show];*/
                        
                    }
                }];
                
            } else{
                //不支持指纹识别
                
                
                switch (error.code) {
                    case LAErrorTouchIDNotEnrolled:{
                        
                        CLog(@"TouchID is not enrolled");
                        break;
                    }
                    case LAErrorPasscodeNotSet:{
                        
                        CLog(@"A passcode has not been set");
                        break;
                    }
                    default:{
                        
                        CLog(@"TouchID not available");
                        break;
                    }
                        
                }
                
                
            }
            
            

            
/*
            CGRect button2Rect = CGRectMake(10, space_to_top + square_w + space_x, 140, 40);
            self.ChooseFTUButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.ChooseFTUButton setFrame:button2Rect];
            [self.ChooseFTUButton setTitle:@"选择指纹解锁" forState:UIControlStateNormal];
            [self.ChooseFTUButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.ChooseFTUButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [self.ChooseFTUButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
            [self.ChooseFTUButton addTarget:self action:@selector(ChooseFTUButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.ChooseFTUButton];
 */
        
        }
    }
    return self;
}

#if 0
-(void)ChooseFTUButtonClick:(UIButton *)btn{
    CLog(@".......");
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        CLog(@"Touch ID is available.");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"Are you the device owner?", nil) reply:^(BOOL success, NSError *error) {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was a problem verifying your identity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                return ;
            }
            if (success) {
                dispatch_async(dispatch_get_main_queue(),^{
                    
                
                
                });
                
                /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You are the device owner!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];*/
                
            } else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not the device owner!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }];
        
    } else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot authenticate using TouchID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

#endif

#pragma mark   ------------------- save and get password  -----------------------

-(void)savePassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:k_PatternPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:k_PatternPassword];
}

-(void)deletePassword
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_PatternPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)deletePatternPassword
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_PatternPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  跳转到登录界面
 *
 *  @param button
 */
-(void)forgottenPWDButtonAction:(UIButton *)button
{
    CLog(@"忘记密码");
//    [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    
//    ZMLogInViewForPattern *loginView = [[ZMLogInViewForPattern alloc]initWithFrame:self.bounds withTarget:self];
//    [self addSubview:loginView];
    
    [self deletePassword];
    
    self.forgetPatternPasswordBlock();
}


@end
