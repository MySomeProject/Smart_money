//
//  NAmeview.m
//  ADDD
//
//  Created by 206 on 13-7-9.
//  Copyright (c) 2013年 吴丁虎. All rights reserved.
//

#import "NAmeview.h"
#import "UIImageView+WebCache.h"
#import "GTCommontHeader.h"
@implementation NAmeview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        buttonArray = [NSMutableArray array];
        selectedButtonArray = [NSMutableArray array];
        
        
        /**
         显示输入的密码（测试使用）
         */
        resulttext = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, 200, 40)];
        resulttext.textColor = [UIColor clearColor];
        [resulttext resignFirstResponder];
//        [self addSubview:resulttext];
        
        
        //按钮的宽高 72
        //按钮之间的距离
        float space_x = ([[UIScreen mainScreen]bounds].size.width - 62*3)/4;
        space_x = GTFixWidthFlaot(25);
        float space_y = GTFixHeightFlaot(space_x);
        
        //按钮形成的矩形所占据的长宽
        float square_w = 2 * space_x + 3 * 72;
        
        //第一排按钮距离屏幕上边界的距离
        float space_to_top = ([[UIScreen mainScreen]bounds].size.height - square_w) / 2;
        space_to_top =GTFixHeightFlaot(180+64);
        
        CLog(@"space_x = %f, window_w = %f", space_x, [[UIScreen mainScreen]bounds].size.width);
        midNumView = [[UIView alloc] initWithFrame:CGRectMake(0 ,GTFixHeightFlaot(180+64), WIDTH_OF_SCREEN,GTFixWidthFlaot(87*3))];
        midNumView.userInteractionEnabled= NO;  //用户交互

        [self addSubview:midNumView];
        for (int i=0; i<9; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setFrame:CGRectMake(GTFixHeightFlaot(42) + (i%3)*(space_x + GTFixWidthFlaot(62)),
                                         (i/3)*(GTFixHeightFlaot(space_y) + GTFixHeightFlaot(62)),
                                       GTFixWidthFlaot(62),
                                        GTFixWidthFlaot(62))];
            
            [button setBackgroundColor:[UIColor clearColor]];
            [button setBackgroundImage:[UIImage imageNamed:@"yuangkuang"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"xuanzhongkuang"] forState:UIControlStateSelected];
            button.userInteractionEnabled= NO;  //用户交互
            button.alpha = 0.9;
            button.tag = i+10000;
            [midNumView addSubview:button];
            [buttonArray addObject:button];
        }
        topNumView = [[UIView alloc] initWithFrame:CGRectMake(GTFixWidthFlaot(124) ,GTFixHeightFlaot(30+64), GTFixWidthFlaot(72),GTFixWidthFlaot(72))];
//        topNumView.backgroundColor = [UIColor redColor];
        [self addSubview:topNumView];
        for (int i=0; i<9; i++) {
            UIImageView *imge = [[UIImageView alloc] init];
            [imge setImage:[UIImage imageNamed:@"xiaokuang"]];
            [topNumView addSubview:imge];
            [imge setFrame:CGRectMake((i%3)*GTFixHeightFlaot(26), (i/3)*GTFixHeightFlaot(26), GTFixWidthFlaot(20), GTFixWidthFlaot(20))];
            [imge setTag:i+388];
            [topNumView addSubview:imge];
        }
        headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(GTFixWidthFlaot(124) ,GTFixHeightFlaot(41-10), GTFixWidthFlaot(72),GTFixWidthFlaot(72))];
        [self addSubview:headerImg];
        headerImg.layer.cornerRadius = GTFixWidthFlaot(36);
//        headerImg.transform = CGAffineTransformScale(self.transform, 0.95, 0.95);  //在原来基础上缩放

        headerImg.layer.masksToBounds = YES;
        
        NSString* imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"unlockUserImg"];
        NSURL *imageUrl = [NSURL URLWithString:imagePath];
                [headerImg sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxian"]];
        [self gotoAnimation];
        
        
    }
    return self;
}
-(void)gotoAnimation{
    [UIView animateWithDuration:.25 animations:^{
//        headerImg.transform = CGAffineTransformScale(self.transform, 1, 1);  //在原来基础上缩放
        headerImg.origin = CGPointMake(headerImg.left, headerImg.top+GTFixHeightFlaot(10));
    }];
}
-(void)isUnlock:(BOOL)unlock{
    if (unlock) {
        [topNumView setHidden:YES];
        [headerImg setHidden:NO];
        [midNumView setOrigin:CGPointMake(midNumView.left, headerImg.bottom+GTFixHeightFlaot(85))];
        if (HEIGHT_OF_SCREEN == 480) {
            [midNumView setOrigin:CGPointMake(midNumView.left, headerImg.bottom+GTFixHeightFlaot(70))];

        }
    }else{
        [topNumView setHidden:NO];
        [headerImg setHidden:YES];
        if (HEIGHT_OF_SCREEN == 480) {
            topNumView.origin = CGPointMake(topNumView.left, topNumView.top-80);
            midNumView.origin = CGPointMake(midNumView.left, midNumView.top-90);
        }
    }
}


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        buttonArray = [NSMutableArray array];
        selectedButtonArray = [NSMutableArray array];

        
        
        resulttext = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, 200, 40)];
        [resulttext resignFirstResponder];
        [self addSubview:resulttext];
        
        
        for (int i=0; i<9; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(26+(i%3)*98, 126+(i/3)*98, 72, 72)];
            
            [button setBackgroundColor:[UIColor clearColor]];
            
            [button setBackgroundImage:[UIImage imageNamed:@"normal_image"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"selected_image"] forState:UIControlStateSelected];
            button.userInteractionEnabled= NO;  //用户交互
            button.alpha = 0.9;
            button.tag = i+10000;
            [self addSubview:button];
            [buttonArray addObject:button];
        }
    }

    return self;
   
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint point= [[touches anyObject]locationInView:self];
    curentpoint = point;
    for (UIButton *thisbutton in buttonArray) {
        CGFloat xdiff = point.x - thisbutton.center.x;
        CGFloat ydiff = point.y-midNumView.top - thisbutton.center.y;
        //按钮点击成功
        if (fabsf(xdiff) <GTFixWidthFlaot(27) &&fabsf (ydiff) <GTFixHeightFlaot(27)){
            
            CLog(@"%ld", thisbutton.tag - 9999);
            
            UIImageView* img = (UIImageView*)[topNumView viewWithTag:388+thisbutton.tag-10000];
            [img setImage:[UIImage imageNamed:@"xiaokuang2"]];
            resulttext.text = [NSString stringWithFormat:@"%ld",thisbutton.tag-9999];
            resulttext.text = [resulttext.text stringByAppendingString:resulttext.text];
            
            if (!thisbutton.selected) {
                thisbutton.selected = YES;
                [selectedButtonArray  addObject:thisbutton];
            }
        }
    }
    [self setNeedsDisplay];
    [self addstring:NO];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIButton *thisButton in buttonArray) {
        [thisButton setSelected:NO];
    }
    for (int i = 0; i<9;i++) {
        UIImageView* img = (UIImageView*)[topNumView viewWithTag:388+i];
        [img setImage:[UIImage imageNamed:@"xiaokuang"]];

    }
    [selectedButtonArray removeAllObjects];
    [self setNeedsDisplay];
    
    [self addstring:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint begainpoint=[[touches anyObject]locationInView:self];
    begainpoint = [[touches anyObject]locationInView:self];

    for (UIButton *thisbutton in buttonArray) {
    
    CGFloat xdiff =begainpoint.x-thisbutton.center.x;
    CGFloat ydiff=begainpoint.y - thisbutton.center.y;
    
    if (fabsf(xdiff) <36 &&fabsf (ydiff) <36&&fabsf(xdiff)<0&&fabsf (ydiff)<0){
         if (!thisbutton.selected) {
                thisbutton.selected = YES;
                [selectedButtonArray  addObject:thisbutton];
         }
    }
}

    [self setNeedsDisplay];
    [self addstring:NO];
}


-(void)drawRect:(CGRect)rect{
  CGContextRef  contextref = UIGraphicsGetCurrentContext();
    UIButton *buttonn;
    UIButton *buttonn1;
    
    if (selectedButtonArray.count!=0) {
        buttonn = selectedButtonArray[0];
        
        [[UIColor  colorWithRed:235.0/255 green:150.0/255 blue:141.0/255 alpha:1.0]set];
        
        CGContextSetLineWidth(contextref, 3);
        CGContextMoveToPoint(contextref, buttonn.center.x, buttonn.center.y+midNumView.top);
        
        for (int t=1; t<selectedButtonArray.count; t++) {
            buttonn1 = selectedButtonArray[t];
            CGContextAddLineToPoint(contextref, buttonn1.center.x, buttonn1.center.y+midNumView.top);
           
        }
        CGContextAddLineToPoint(contextref, curentpoint.x, curentpoint.y); 
       
    }
     CGContextStrokePath(contextref);
}


-(void)addstring:(BOOL)isEnd{
    
    if (isEnd) {
        CLog(@"resulttext.text === %@", resulttext.text);
        if (_target && _action)
            [_target performSelector:_action withObject:resulttext.text];
    }
    
    
    UIButton *strbutton;
    NSString *string=@"";
    
    for (int t=0; t<selectedButtonArray.count; t++) {
        strbutton = selectedButtonArray[t];
         string= [string stringByAppendingFormat:@"%ld", strbutton.tag-9999];
        
    }

    resulttext.text = string;
}


- (void)setTarget:(id)target withAction:(SEL)action
{
    _target = target;
    _action = action;
}


@end
