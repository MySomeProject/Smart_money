//
//  HXQuestionTableViewCell.h
//  miXin
//
//  Created by gitBurning on 14-7-18.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXChangJianQuestion.h"

typedef void(^lookAnswer)(UILabel*label,questions *aQuestion);

@interface HXQuestionTableViewCell : UITableViewCell
@property(strong,nonatomic) UILabel *questionLabel;
@property(strong,nonatomic) UILabel *descriptionLabel;
@property(strong,nonatomic) UILabel *timeLabel;
@property(strong,nonatomic) UILabel *isReadedLabel;
@property(strong,nonatomic) UIImageView *indicaterArrow;
@property(strong,nonatomic) UILabel *answerLabel;
@property(strong,nonatomic) UILabel *middleLine;
//@property(strong,nonatomic) UILabel *answerLabel2;

@property(strong,nonatomic) UILabel *bottomLine;
@property(strong,nonatomic) UILabel *topLine;
@property(strong,nonatomic) UILabel *backgroundView;
@property(strong,nonatomic) questions *curentQuestion;
@property (nonatomic) NSDictionary *dataDic;
@end
