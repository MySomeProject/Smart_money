//
//  AboutUsViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsModel.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)];
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone5s
    {
        [self.scrollView setContentSize:CGSizeMake(WIDTH_OF_SCREEN, 2534)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
    {
        [self.scrollView setContentSize:CGSizeMake(WIDTH_OF_SCREEN, 2812)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
    {
        [self.scrollView setContentSize:CGSizeMake(WIDTH_OF_SCREEN, 3004)];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LookFirstInfoClick:(id)sender {
    self.firstViewButton.selected = !self.firstViewButton.isSelected;
    if (self.firstViewButton.selected)
    {
        [self.firstBeforeLabel setHidden:YES];
        [self.firstAfterLabel setHidden:NO];
        CGFloat height = self.firstAfterLabel.frame.origin.y + self.firstAfterLabel.frame.size.height + self.firstViewButton.height + 10;
        CGFloat secondY = self.firstView.frame.origin.y + height;
        [UIView animateWithDuration:0.2 animations:^(){
            [self.firstViewButton setFrame:CGRectMake(self.firstViewButton.frame.origin.x, self.firstAfterLabel.frame.origin.y + self.firstAfterLabel.frame.size.height + 4, self.firstViewButton.frame.size.width, self.firstViewButton.frame.size.height)];
            [self.firstView setFrame:CGRectMake(self.firstView.frame.origin.x, self.firstView.frame.origin.y, self.firstView.frame.size.width, height)];
            [self.secondView setFrame:CGRectMake(self.secondView.frame.origin.x, secondY, self.secondView.frame.size.width, self.secondView.frame.size.height)];
            [self.thirdView setFrame:CGRectMake(self.thirdView.frame.origin.x, secondY + self.secondView.frame.size.height, self.thirdView.frame.size.width, self.thirdView.frame.size.height)];
            [self.lastView setFrame:CGRectMake(self.lastView.frame.origin.x, secondY + self.secondView.frame.size.height + self.thirdView.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height)];
        }];
    }
    else
    {
        [self.firstBeforeLabel setHidden:NO];
        [self.firstAfterLabel setHidden:YES];
        CGFloat height = self.firstBeforeLabel.frame.origin.y + self.firstBeforeLabel.frame.size.height + self.firstViewButton.height + 10;
        CGFloat secondY = self.firstView.frame.origin.y + height;
        [UIView animateWithDuration:0.2 animations:^(){
            [self.firstViewButton setFrame:CGRectMake(self.firstViewButton.frame.origin.x, self.firstBeforeLabel.frame.origin.y + self.firstBeforeLabel.frame.size.height, self.firstViewButton.frame.size.width, self.firstViewButton.frame.size.height)];
            [self.firstView setFrame:CGRectMake(self.firstView.frame.origin.x, self.firstView.frame.origin.y, self.firstView.frame.size.width, height)];
            [self.secondView setFrame:CGRectMake(self.secondView.frame.origin.x, secondY, self.secondView.frame.size.width, self.secondView.frame.size.height)];
            [self.thirdView setFrame:CGRectMake(self.thirdView.frame.origin.x, secondY + self.secondView.frame.size.height, self.thirdView.frame.size.width, self.thirdView.frame.size.height)];
            [self.lastView setFrame:CGRectMake(self.lastView.frame.origin.x, secondY + self.secondView.frame.size.height + self.thirdView.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height)];
        }];
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.lastView.frame.size.height + self.lastView.frame.origin.y)];
}

- (IBAction)lookSecondInfoClick:(id)sender {
    self.secondViewButton.selected = !self.secondViewButton.isSelected;
    CGRect secondRect = self.secondView.frame;
    CGRect thirdRect = self.thirdView.frame;
    CGRect lastRect = self.lastView.frame;
    if (self.secondViewButton.selected)
    {
        [self.secondBeforeLabel setHidden:YES];
        [self.secondAfterLabel setHidden:NO];
        secondRect.size.height += 10;
        thirdRect.origin.y += 10;
        lastRect.origin.y += 10;
        [UIView animateWithDuration:0.2 animations:^()
        {
            [self.secondView setFrame:secondRect];
            [self.secondViewButton setFrame:CGRectMake(self.secondViewButton.frame.origin.x, self.secondAfterLabel.frame.origin.y + self.secondAfterLabel.frame.size.height - 5, self.secondViewButton.frame.size.width, self.secondViewButton.frame.size.height)];
            [self.secondView setFrame:secondRect];
            [self.thirdView setFrame:thirdRect];
            [self.lastView setFrame:lastRect];
        }];
    }
    else
    {
        [self.secondBeforeLabel setHidden:NO];
        [self.secondAfterLabel setHidden:YES];
        secondRect.size.height -= 10;
        thirdRect.origin.y -= 10;
        lastRect.origin.y -= 10;
        [UIView animateWithDuration:0.2 animations:^()
         {
             [self.secondViewButton setFrame:CGRectMake(self.secondViewButton.frame.origin.x, self.secondBeforeLabel.frame.origin.y + self.secondBeforeLabel.frame.size.height - 5, self.secondViewButton.frame.size.width, self.secondViewButton.frame.size.height)];
             [self.secondView setFrame:secondRect];
             [self.thirdView setFrame:thirdRect];
             [self.lastView setFrame:lastRect];
         }];
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.lastView.frame.size.height + self.lastView.frame.origin.y)];
}

- (IBAction)lookThirdInfoClick:(id)sender {
    self.thirdViewButton.selected = !self.thirdViewButton.isSelected;
    if (self.thirdViewButton.selected)
    {
        [self.thirdBeforeLabel setHidden:YES];
        [self.thirdAfterLabel setHidden:NO];
        CGFloat height = self.thirdAfterLabel.frame.origin.y + self.thirdAfterLabel.frame.size.height + self.thirdViewButton.height + 20;
        CGFloat lastY = self.thirdView.frame.origin.y + height;
        [UIView animateWithDuration:0.2 animations:^(){
            [self.thirdViewButton setFrame:CGRectMake(self.thirdViewButton.frame.origin.x, self.thirdAfterLabel.frame.origin.y + self.thirdAfterLabel.frame.size.height + 4, self.thirdViewButton.frame.size.width, self.thirdViewButton.frame.size.height)];
            [self.thirdView setFrame:CGRectMake(self.thirdView.frame.origin.x, self.thirdView.frame.origin.y, self.thirdView.frame.size.width, height)];
            [self.lastView setFrame:CGRectMake(self.lastView.frame.origin.x, lastY, self.lastView.frame.size.width, self.lastView.frame.size.height)];
        }];
    }
    else
    {
        [self.thirdBeforeLabel setHidden:NO];
        [self.thirdAfterLabel setHidden:YES];
        CGFloat height = self.thirdBeforeLabel.frame.origin.y + self.thirdBeforeLabel.frame.size.height + self.thirdViewButton.height + 20;
        CGFloat lastY = self.thirdView.frame.origin.y + height;
        [UIView animateWithDuration:0.2 animations:^(){
            [self.thirdViewButton setFrame:CGRectMake(self.thirdViewButton.frame.origin.x, self.thirdBeforeLabel.frame.origin.y + self.thirdBeforeLabel.frame.size.height + 4, self.thirdViewButton.frame.size.width, self.thirdViewButton.frame.size.height)];
            [self.thirdView setFrame:CGRectMake(self.thirdView.frame.origin.x, self.thirdView.frame.origin.y, self.thirdView.frame.size.width, height)];
            [self.lastView setFrame:CGRectMake(self.lastView.frame.origin.x, lastY, self.lastView.frame.size.width, self.lastView.frame.size.height)];
        }];
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.lastView.frame.size.height + self.lastView.frame.origin.y)];
}
@end
