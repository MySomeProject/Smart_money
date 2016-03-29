//
//  HXQuestionTableViewCell.m
//  miXin
//
//  Created by gitBurning on 14-7-18.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import "HXQuestionTableViewCell.h"
#define kQuestionHegiht 100
#define kLineJuLi 0
#define kContentHeight 90
#define kMiddleLineDis 40

#import "UIViewExt.h"

@implementation HXQuestionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    if (self) {
        // Initialization code
        self.backgroundView = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - 10)];
        [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.backgroundView];
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,
                                                                     10,
                                                                    WIDTH_OF_SCREEN - 60,
                                                                     30)];
        
        CLog(@"WIDTH_OF_SCREEN === %f, self.width = %f", WIDTH_OF_SCREEN, self.width);
        
        self.questionLabel.font = [UIFont systemFontOfSize:19];
        self.questionLabel.textColor=  [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
        
        
        //右侧指示箭头
        self.indicaterArrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.questionLabel.width - 10,20, 15, 15)];
        self.indicaterArrow.image = [UIImage imageNamed:@"setting_more_normal"];
        [self.questionLabel addSubview:_indicaterArrow];
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.questionLabel.frame.origin.x, self.questionLabel.frame.origin.y + self.questionLabel.frame.size.height + 2, 300, 30)];
        [self.descriptionLabel setTextColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0]];
        [self.descriptionLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.descriptionLabel];
        
        //解答
        self.answerLabel=[[UILabel alloc] initWithFrame:CGRectMake(_questionLabel.left,
//                                                                   _questionLabel.top+_questionLabel.height,
                                                                   _descriptionLabel.bottom,
                                                                   WIDTH_OF_SCREEN - 2* _questionLabel.left,
                                                                   0
                                                                   )];
        self.middleLine = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleLineDis,  80, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [self.middleLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.middleLine setHidden:YES];
        [self addSubview:self.middleLine];
        self.topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [self.topLine setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:self.topLine];
        
        self.answerLabel.font = [UIFont systemFontOfSize:14];
        self.answerLabel.textColor=[UIColor lightGrayColor];
        self.answerLabel.numberOfLines=0;
        self.answerLabel.hidden = YES;
        self.answerLabel.lineBreakMode = NSLineBreakByCharWrapping|NSLineBreakByWordWrapping;
        
        self.bottomLine=[[UILabel alloc] initWithFrame:CGRectMake(0,100, WIDTH_OF_SCREEN - _answerLabel.left, 0.5)];
        self.bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.questionLabel];
        [self addSubview:self.answerLabel];
        [self addSubview:self.bottomLine];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 13, 200, 25)];
        [self.timeLabel setTextColor:[UIColor colorWithRed:161/255.0 green:161/255.0 blue:161/255.0 alpha:1.0]];
        [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:self.timeLabel];
        
        self.isReadedLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 0, 30, 30)];
        [self.isReadedLabel setTextColor:Color_of_Red];
        [self.isReadedLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:self.isReadedLabel];
    
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    self.questionLabel.text = [dataDic valueForKey:@"title"];
    self.timeLabel.text = [dataDic valueForKey:@"createTime"];
    self.descriptionLabel.text = @"紫马财行欢迎您!";
    self.answerLabel.text = [self replaceContentSign:[dataDic valueForKey:@"content"]];
    self.isReadedLabel.text = [[dataDic valueForKey:@"read"] integerValue]==1?@"已读":@"未读";
    if ([self.isReadedLabel.text isEqualToString:@"已读"])
    {
        [self.questionLabel setTextColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0]];
        [self.isReadedLabel setTextColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0]];
    }
    else
    {
        [self.questionLabel setTextColor:[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0]];
        [self.isReadedLabel setTextColor:Color_of_Red];
    }
}

- (NSString *)replaceContentSign:(NSString *)content
{
    NSString *rightContent = content;
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return rightContent;
}

-(void)layoutSubviews{
    CLog(@"wocaonima%g",self.frame.size.height);
    if ([[self.dataDic valueForKey:@"isSelected"] boolValue]) {
        self.answerLabel.hidden = NO;
        CGRect newAnswer=self.answerLabel.frame;
        newAnswer.origin.y=87;
        newAnswer.size.height=[[self.dataDic valueForKey:@"messageContentHeight"] floatValue];
        self.answerLabel.frame=newAnswer;
        [self.middleLine setHidden:NO];
        self.indicaterArrow.image = [UIImage imageNamed:@"setting_more_selected"];
    }
    else{
        self.answerLabel.hidden = YES;
        CGRect newAnswer=self.answerLabel.frame;
        newAnswer.size.height=0;
        self.answerLabel.frame = newAnswer;
        [self.middleLine setHidden:YES];
        self.indicaterArrow.image = [UIImage imageNamed:@"setting_more_normal"];
    }
    [self.backgroundView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.frame.size.height - 10)];
    [self.bottomLine setFrame:CGRectMake(0, self.frame.size.height - 10, [UIScreen mainScreen].bounds.size.width, 0.5)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
