//
//  MineCenterHeaderCell6Plus.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-21.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "MineCenterHeaderCell6Plus.h"

@implementation MineCenterHeaderCell6Plus

- (void)awakeFromNib {
    // Initialization code
//    self.autoresizesSubviews = NO;
//    self.showBtn.selected = NO;
   
}
- (IBAction)showAllmount:(UIButton *)sender {
    sender.selected = !sender.selected;
    CLog(@"select = %d",sender.selected);
//    [self setNeedsLayout];
    if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
//         [self setNeedsLayout];
        [self.delegate refreshTableView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    [self setNeedsLayout];
    // Configure the view for the selected state
}
//- (void)layoutSubviews
//{
//    if(self.showBtn.selected == YES)
//    {
//        if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 150+90);
//            self.botomView.frame = CGRectMake(0, 150+90, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//        else if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 160+90);
//            self.botomView.frame = CGRectMake(0, 160+90, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//        else //iPhone 4S
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 110+60);
//            self.botomView.frame = CGRectMake(0, 110+60, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//    }
//    else
//    {
//        if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 150);
//            self.botomView.frame = CGRectMake(0, 150, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//        else if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 160);
//            self.botomView.frame = CGRectMake(0, 160, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//        else //iPhone 4S
//        {
//            self.headBcakView.frame = CGRectMake(0, 0, self.headBcakView.frame.size.width, 110);
//            self.botomView.frame = CGRectMake(0, 110, self.headBcakView.frame.size.width, self.botomView.frame.size.height);
//        }
//
//    }
//   
//    
//    NSLog(@" y = %f",self.botomView.frame.origin.y);
//    
//    NSLog(@" h = %f",self.headBcakView.frame.size.height);
//
//}

@end
