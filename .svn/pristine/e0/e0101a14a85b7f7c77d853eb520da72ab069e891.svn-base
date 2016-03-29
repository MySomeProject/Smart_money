//
//  AssetRecordsTableViewCell.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/5/12.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetRecordsTableViewCell.h"

@implementation AssetRecordsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)ViewDidLoad
{
    CLog(@"1");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    NSString *mobile = [dataDic valueForKey:@"name"];
    NSNumber *amount = [dataDic valueForKey:@"amount"];
    NSString *assetTime = [dataDic valueForKey:@"bidDate"];
    if (![dataDic valueForKey:@"name"]) {
        mobile =[dataDic valueForKey:@"userNickName"];
    }
    
    if ([ZMTools isNullObject:mobile])
    {
        self.mobileLabel.text = @"***";
    }
    else
    {
        self.mobileLabel.text = [self replaceString:mobile atRange:NSMakeRange(4,5)];
    }
    if ([ZMTools isNullObject:amount])
    {
        self.amountLabel.text = @"0.00元";
    }
    else
    {
        self.amountLabel.text = [NSString stringWithFormat:@"%.2f元",[amount floatValue]];
    }
    if ([ZMTools isNullObject:assetTime])
    {
        self.assetTimeLabel.text = @"0000-00-00 00:00:00";
    }
    else
    {
        self.assetTimeLabel.text = assetTime;
    }
}

- (void)setRiZiBaoDataDic:(NSDictionary *)dataDic
{
    _riZiBaoDataDic = dataDic;
    
//    {"current_user_point_id":null,"userId":null,"product_phase_id":null,"amount":1.0,"userNickName":"136*****758","bidDate":"2015-05-28 13:54:48","couponIds":null}
    
    NSString *mobile = [dataDic valueForKey:@"userNickName"];
    NSNumber *amount = [dataDic valueForKey:@"amount"];
    NSString *assetTime = [dataDic valueForKey:@"bidDate"];
    
    if ([ZMTools isNullObject:mobile])
    {
        self.mobileLabel.text = @"***";
    }
    else
    {
        self.mobileLabel.text = [self replaceString:mobile atRange:NSMakeRange(4,5)];
    }
    if ([ZMTools isNullObject:amount])
    {
        self.amountLabel.text = @"0.00元";
    }
    else
    {
        self.amountLabel.text = [NSString stringWithFormat:@"%.2f元",[amount floatValue]];
    }
    if ([ZMTools isNullObject:assetTime])
    {
        self.assetTimeLabel.text = @"0000-00-00 00:00:00";
    }
    else
    {
        self.assetTimeLabel.text = assetTime;
    }
}


//将字符串后四位处理为****
- (NSString *)replaceString:(NSString *)string atRange:(NSRange)range
{
    if ([string length] > 8)
    {
        string = [string stringByReplacingCharactersInRange:range withString:@"*****"];
    }
    else
    {
        string = @"****";
    }
    return string;
}
@end
