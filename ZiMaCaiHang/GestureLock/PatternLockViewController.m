//
//  PatternLockViewController.m
//  ZMSD
//
//  Created by zima on 14-12-2.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "PatternLockViewController.h"

@implementation PatternLockViewController
- (void)viewDidLoad{
    [self setTitle:@"手势键盘"];
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    
    //iPhone 4s
    if ([UIScreen mainScreen].bounds.size.height < 568 || [UIScreen mainScreen].bounds.size.height == 480)
    {
        frame = CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    }
    
    
    PatternLockView * lockView = [[PatternLockView alloc]initWithFrame:frame forSettingLock:YES];
    [lockView setTarget:self withAction:@selector(settingSucceed:)];
    [self.view addSubview:lockView];
}
-(void)returnBack{
    [self.navigationController popViewControllerAnimated:YES];
    self.hasPatternSettedBlock(NO);
}
/**
 *  设置成功的回调
 *
 *  @param isSucceed
 */
- (void)settingSucceed:(NSNumber *)isSucceed
{
    BOOL succeed = [isSucceed boolValue];
    
    CLog(@" ======= %@", succeed? @"成功": @"失败");
    
    /**
     *  是否设置成功
     */
    self.hasPatternSettedBlock(succeed);
    
    if (succeed) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
