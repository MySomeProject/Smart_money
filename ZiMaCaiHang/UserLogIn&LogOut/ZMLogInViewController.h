//
//  ZMLogInViewController.h
//  ZMSD
//
//  Created by zima on 14-11-4.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZMLogInViewControllerDelegate <NSObject>
-(void)finishedLogin:(id)sender;
@end

@interface ZMLogInViewController : UIViewController
@property (assign, nonatomic) id<ZMLogInViewControllerDelegate>   delegate;
@property (assign, nonatomic) int loginOrRegisterType; //loginType 1, registerType 2
@end
