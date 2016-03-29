//
//  CustomInvestCell.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/8/15.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "CustomInvestCell.h"
#import "AppDelegate.h"
#import "GTCommontHeader.h"

@implementation CustomInvestCell
{
    AppDelegate *_appdelegate;
    BOOL _canMoney;
}
- (void)awakeFromNib {
    [AppDelegate storyBoradAutoLay:self];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)setProductInfoDic:(NSDictionary *)singleInfo
{
    //让字体跟着屏幕的大小进行变化
    [self fontWithLable:self.investLable fontSize:16];
    [self fontWithLable:self.canInvestMoney fontSize:11];
    [self fontWithLable:self.productNameLable fontSize:14];
    [self fontWithLable:self.moneyNumLable fontSize:16];
    [self fontWithLable:self.cycleTime fontSize:16];
    
    
    //是否可投
    _canMoney = [self ifCanInvestWithStatus:singleInfo[@"loanStatus"]];
    //产品类型名
    self.productTypeLable.layer.masksToBounds = YES;
    self.productTypeLable.layer.cornerRadius = 5;
    NSString *productType = [[ZMServerAPIs shareZMServerAPIs] getLoanCNNameByLoanTypeName:[singleInfo objectForKey:@"productType"]];
    self.productTypeLable.text = productType;
//    CLog(@"%@",self.productTypeLable.text);
    self.productTypeLable.font = [UIFont systemFontOfSize:14*_appdelegate.autoSizeScaleX];
    //产品名字
    self.productNameLable.text = [self nameWithProductType:singleInfo[@"productType"] andLoanId:singleInfo[@"loanId"]];
    //利率
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[self interestWithProductType:[singleInfo[@"interest"] doubleValue]andProductType:singleInfo[@"productType"]]];
//    NSString *str1 = [NSString stringWithFormat:@"%@",singleInfo[@"interest"]];
    
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(0,str1.length-1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(13)] range:NSMakeRange(str1.length-1,1)];
    self.investLable.attributedText = str1;
//    self.investLable.text = str1;
    
    
//    self.investLable.text = [self interestWithProductType:[singleInfo[@"interest"] doubleValue]andProductType:singleInfo[@"productType"]];
    //投资天数
    self.cycleTime.text = [self dateWithDayNum:singleInfo[@"dayNum"] andLoanMonths:singleInfo[@"loanMonthsValue"]];
    
    //投资的总金额
    self.moneyNumLable.text = [self amountWithMoeny:singleInfo[@"contactAmount"]];
    //剩余金额
    self.canInvestMoney.text = [self canInvestMoney:singleInfo[@"contactAmount"] andFinishedAmount:singleInfo[@"finishedAmount"]];
    
    //还款方式
    
    self.backMoneyStyle.text = [self repaymentType:singleInfo[@"repaymentType"]];
    
    //进度条
    self.progressView.showText = @NO;
    self.progressView.borderRadius = @2;
    self.progressView.animate = @NO;
    self.progressView.type = LDProgressSolid;
    self.progressView.progress = [[singleInfo objectForKey:@"finishedRatio"] floatValue] / 100.0f;
    if(_canMoney == YES)
    {
        self.progressView.hidden = NO;
    }
    else
    {
        self.progressView.hidden = YES;
    }
    //新手图片显示
    self.LoanImg.image = [UIImage imageNamed:[self NewLoanImageName:singleInfo[@"productType"]]];
    //投资按钮
    [self investBtnMake:self.investBtn];
    
    
}
//根据不同的类型显示不同的名称
- (NSString *)nameWithProductType:(NSString *)productType andLoanId:(NSString *)loanid
{
    if([productType isEqualToString:@"YUEMANYING"])
    {
        return [NSString stringWithFormat:@"财月盈%@",loanid];
    }
    else if ([productType isEqualToString:@"MORE_DAY"])
    {
        return [NSString stringWithFormat:@"财行加%@",loanid];
    }else if ([productType isEqualToString:@"JIJIFENG"])
    {
        return [NSString stringWithFormat:@"财季盈%@",loanid];
    }else if ([productType isEqualToString:@"CAIXIANGYU"])
    {
        return [NSString stringWithFormat:@"财相遇%@",loanid];
    }else if ([productType isEqualToString:@"RIZIBAO"])
    {
        return [NSString stringWithFormat:@"财行宝%@",loanid];
    }
    else
    {
        return @"理财产品一期";
    }
}
//根据不同产品显示不同利率
- (NSString *)interestWithProductType:(double)interest andProductType:(NSString *)productType
{
//    if([productType isEqualToString:@"MORE_DAY"])
//    {
//        NSString *str = [NSString stringWithFormat:@"%.1f",interest];
//        if ([str floatValue]==[str intValue]){
//            return [NSString stringWithFormat:@"%.0f%%+%.0f%%",interest-5.0,5.0];
//            
//        }else{
//            return [NSString stringWithFormat:@"%.1f%%+%.0f%%",interest-5.0,5.0];
//        }
//    }else
    if ([productType isEqualToString:@"YUEMANYING"])
    {
        return [NSString stringWithFormat:@"%.1f%%",interest];
    }
    else
    {
        return [NSString stringWithFormat:@"%.0f%%",interest];
    }
}
//根据不同的产品显示不同的周期
- (NSString *)dateWithDayNum:(NSString *)dayNum andLoanMonths:(NSString *)monthsValue
{
    if([ZMTools isNullObject:dayNum]==NO)
    {
        if([dayNum intValue]>0)
        {
            return [NSString stringWithFormat:@"%d 天",[dayNum intValue]];
        }
        else
        {
            return [NSString stringWithFormat:@"%ld 天",(long)[monthsValue integerValue]*30];
        }
        
    }
    else
    {
        return [NSString stringWithFormat:@"%ld 天",(long)[monthsValue integerValue]*30];
    }
}
//总金额 或者 可投金额 (起投万元时候可以调用)
- (NSString *)amountWithMoeny:(NSString *)money
{
    if([money intValue]%10000>0)
    {
        return [NSString stringWithFormat:@"%.2f万",[money doubleValue]/10000];
    }
    else
    {
        return [NSString stringWithFormat:@"%.0f万",[money doubleValue]/10000];
    }
}
//判断是否可以进行投资
- (BOOL)ifCanInvestWithStatus:(NSString *)statusStr
{
    _canMoney = NO;
    if([statusStr isEqualToString:@"PUBLISHED"] ||  //紫定盈
       [statusStr isEqualToString:@"OPEN"])         //紫贷宝类型
    {
        _canMoney = YES;
    }
    return _canMoney;
}

//可投金额
- (NSString *)canInvestMoney:(NSNumber *)contanct andFinishedAmount:(NSNumber *)finishedAmount
{
    long long canInvest = [contanct longLongValue] - [finishedAmount longLongValue];
    if(canInvest>0)
    {
        return   [ZMTools moneyStandardFormatByString:[NSString stringWithFormat:@"%lld", canInvest] withDollarSign:@"¥"];
    }
    else
    {
        return @"可投:￥0.00";
    }
}
//还款方式
- (NSString *)repaymentType:(NSString *)repaymentType
{
    if( [ZMTools isNullObject:repaymentType] == NO &&  [repaymentType isEqualToString:@"AVERAGE_CAPITAL_PLUS_INTEREST"])
    {
        return  @"等额本息";
    }
    else if ([ZMTools isNullObject:repaymentType] == NO&&[repaymentType isEqualToString:@"PWRIOD_REPAYS_CAPTITAL"])
    {
        return  @"按月付息,到期还本";
    }
    else
    {
        return  @"到期一次性还本付息";
    }
}
//新手标的图片
-  (NSString *)NewLoanImageName:(NSString *)productType
{
    if([productType isEqualToString:@"CAIXIANGYU"])
    {
        if(_canMoney == YES)
        {
            return @"理财超市_5";
        }
        else
        {
            return @"licaijihua";
        }
    }
    return @"";
}
- (void)investBtnMake:(UIButton *)sender
{
    if(_canMoney == YES)
    {
        [sender setTitle:@"投资" forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"理财超市_4"] forState:UIControlStateNormal];
        sender.enabled = YES;
    }
    else
    {
        sender.enabled = NO;
        sender.backgroundColor = [ZMTools ColorWith16Hexadecimal:@"c5c4c4"];
        sender.layer.masksToBounds = YES;
        sender.layer.cornerRadius = 10;
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [sender setTitle:@"已结束" forState:UIControlStateNormal];
        
        _canInvestMoney.text = @"剩余 0.00";
        
    }
}
- (void)fontWithLable:(UILabel *)lable fontSize:(CGFloat)font
{
    lable.font = [UIFont systemFontOfSize:font *_appdelegate.autoSizeScaleX];
}

@end
