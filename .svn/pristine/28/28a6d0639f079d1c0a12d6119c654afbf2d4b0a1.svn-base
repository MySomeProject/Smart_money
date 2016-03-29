//
//  ZMInvestFinishedViewController.m
//  ZMSD
//
//  Created by zima on 15-1-17.
//  Copyright (c) 2015年 zima. All rights reserved.
//

#import "ZMInvestFinishedViewController.h"

#import "UIColor+StyleColor.h"
#import "UIImage+Blur.h"
#import "UIImage+Screenshot.h"

#import "UIViewExt.h"

static float const kAlertDuration = 5.f;
static float const kAnimateDuration = .6f;
static float const kBlurParameter = .6f;

@interface ZMInvestFinishedViewController ()
{
    UIImageView *notiImageView;
    UILabel *notiTextLabel;
    UIView *groupView;
    UIButton *returnButton;
}
@property (strong, nonatomic) UIImageView *backgroundImageView;
@end

@implementation ZMInvestFinishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame1 = [[UIScreen mainScreen] bounds];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:frame1];
    [self.backgroundImageView setBackgroundColor:[UIColor whiteColor]];
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    groupView = [[UIView alloc]initWithFrame:CGRectMake((WIDTH_OF_SCREEN - 260)/2, (frame.size.height-200)/2-40, 260, 260)];
    groupView.layer.cornerRadius = 6.0;
    [self.view addSubview:groupView];
    
    //note image
    notiImageView = [[UIImageView alloc] initWithFrame:CGRectMake((groupView.width - 60)/2, SPACE10_WITH_BORDER, 60, 60)];
    if (self.isSucceed) {
        notiImageView.image = [UIImage imageNamed:@"investSuccess.png"];
    }
    else
    {
        notiImageView.image = [UIImage imageNamed:@"investFailed.png"];
    }
    [groupView addSubview:notiImageView];
    
    
    notiTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, notiImageView.bottom + SPACE10_WITH_BORDER,
                                                             groupView.width,
                                                             60)];
    [notiTextLabel setTextAlignment:NSTextAlignmentCenter];
    [notiTextLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [notiTextLabel setTextColor:COLOR_BLACK_FOR_TEXT];
    [notiTextLabel setTextColor:[UIColor whiteColor]];
    if (self.isSucceed) {
        [notiTextLabel setText:@"恭喜您投资成功"];
    }
    else
    {
        [notiTextLabel setText:@"投资失败"];
    }
    [groupView addSubview:notiTextLabel];
    
    
    /**
     *  返回按钮
     */
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitleColor:Color_For_Main_Red forState:UIControlStateNormal];
    returnButton.layer.cornerRadius = 5.0;
    [returnButton setFrame:CGRectMake(0,
                                      notiTextLabel.bottom + SPACE10_WITH_BORDER,
                                      groupView.width,
                                      40)];
    
    if (self.isSucceed) {
        [returnButton setTitle:@"返回查看" forState:UIControlStateNormal];
    }
    else
    {
        [returnButton setTitle:@"返回重新投资" forState:UIControlStateNormal];
    }
    [returnButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [groupView addSubview:returnButton];
    
    /*
     *点击屏幕退出
     */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    
//    [groupView setBackgroundColor:[UIColor whiteColor]];
      [notiTextLabel setTextColor:COLOR_BLACK_FOR_TEXT];
//    [returnButton setBackgroundColor:[UIColor whiteColor]];
    
    
    
    //无玻璃效果
//    [notiTextLabel setTextColor:[UIColor whiteColor]];
//    [self loadingBlurry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)loadingBlurry
{
    UIImage *viewshot = [UIImage screenshot];
    
    
    NSString *path1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/4444.png"];
    [UIImagePNGRepresentation(viewshot) writeToFile:path1 atomically:YES];
    
    NSData *imageData = UIImageJPEGRepresentation(viewshot, 0.0001);
    UIImage *blurredSnapshot = [[UIImage imageWithData:imageData] blurredImage:kBlurParameter];
    
    
    self.backgroundImageView.image = blurredSnapshot;
    
    self.backgroundImageView.alpha = 0.0;
    
    groupView.alpha = 0.0;
    
    [self.view insertSubview:groupView aboveSubview:self.backgroundImageView];
    
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.backgroundImageView.alpha = 1.0;
        groupView.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
        }
    }];
    
    
    [UIView animateWithDuration:1 animations:^{
        
        groupView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
        }
    }];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}


@end
