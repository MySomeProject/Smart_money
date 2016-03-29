//
//  ZMTools.m
//  ZMSD
//
//  Created by zima on 14-11-14.
//  Copyright (c) 2014年 zima. All rights reserved.
//

#import "ZMTools.h"

@implementation ZMTools

//去掉字符中的非法HTML元素
+ (NSString *)replaceContentHTMLFlag:(NSString *)content
{
    NSString *rightContent = content;
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
    rightContent = [rightContent stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
    return rightContent;
}

+ (NSString *)bankIdFromCardType:(NSString *)bankType;
{
//    {"message":"获取数据成功","data":{"banks":[
    
    /*
        {"id":1,"imgPath":"","code":"cmb","thirdPayType":"LOCAL","name":"招商银行","bankNumber":"03080000"},
        {"id":2,"imgPath":"","code":"icbc","thirdPayType":"LOCAL","name":"中国工商银行 ","bankNumber":"01020000"},
        {"id":3,"imgPath":"","code":"ccb","thirdPayType":"LOCAL","name":"中国建设银行","bankNumber":"01050000"},
        {"id":4,"imgPath":"","code":"abc","thirdPayType":"LOCAL","name":"中国农业银行","bankNumber":"01030000"},
        {"id":5,"imgPath":"","code":"cmbc","thirdPayType":"LOCAL","name":"中国民生银行","bankNumber":"03050000"},
        {"id":6,"imgPath":"","code":"spdb","thirdPayType":"LOCAL","name":"上海浦东发展银行","bankNumber":"03100000"},
        {"id":7,"imgPath":"","code":"cgb","thirdPayType":"LOCAL","name":"广东发展银行","bankNumber":"03060000"},
        {"id":8,"imgPath":"","code":"cib","thirdPayType":"LOCAL","name":"兴业银行","bankNumber":"03090000"},
        {"id":9,"imgPath":"","code":"ceb","thirdPayType":"LOCAL","name":"光大银行","bankNumber":"03030000"},
        {"id":10,"imgPath":"","code":"comm","thirdPayType":"LOCAL","name":"交通银行","bankNumber":""},
        {"id":11,"imgPath":"","code":"boc","thirdPayType":"LOCAL","name":"中国银行 ","bankNumber":"01040000"},
        {"id":12,"imgPath":"","code":"citic","thirdPayType":"LOCAL","name":"中信银行","bankNumber":"03020000"},
        {"id":13,"imgPath":"","code":"bos","thirdPayType":"LOCAL","name":"上海银行","bankNumber":""},
        {"id":14,"imgPath":"","code":"pingan","thirdPayType":"LOCAL","name":"平安银行 ","bankNumber":"03070000"},
        {"id":15,"imgPath":"","code":"psbc","thirdPayType":"LOCAL","name":"邮政储蓄 ","bankNumber":"01000000"},
        {"id":16,"imgPath":"","code":"hxb","thirdPayType":"LOCAL","name":"华夏银行","bankNumber":"03040000"}]}
*/

    return nil;
}

+(UIBarButtonItem *)item:(NSString *)imageName target:(id)taget select:(SEL)action
{
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 25);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bar;
    
}

+ (NSString *)monthValueFromMonthType:(NSString *)monthType
{
    if(monthType.length<4)
    {
        return @"";
    }
    else
    {
    NSString *startString = [monthType substringToIndex:4];

    if ([startString isEqualToString:@"DAY_"])
    {
        return [monthType substringFromIndex:4];
    }
    else
    {
        startString = [monthType substringToIndex:7];

        if([startString isEqualToString:@"MONTHS_"])
        {
            return [monthType substringFromIndex:7];
        }
    }
    
    return @"";
    }
}

+(BOOL)isNullObject:(id)object {
    if([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//实名*星号隐藏
+ (NSString *)hideRealName:(NSString *)realName
{
    if([realName isEqualToString:@""] == YES || realName == nil)
    {
        return realName;
    }
    
    NSUInteger nameLength = [realName length];
    NSString *startString = [realName substringWithRange: NSMakeRange(0, nameLength-1)];
    NSString *stringNum = [NSString stringWithFormat:@"%@*", startString];
    return stringNum;
}

//字符*星号隐藏
+ (NSString *)hideString:(NSString *)string
{
    if([string isEqualToString:@""] == YES || string == nil)
    {
        return string;
    }
    
    NSUInteger stringLength = [string length];
    if (stringLength > 6)
    {
        stringLength = 6;
    }
    NSString *startString = [string substringWithRange: NSMakeRange(0, stringLength)];
    NSString *stringNum = [NSString stringWithFormat:@"%@*", startString];
    return stringNum;
}

//银行卡号*星号隐藏
+ (NSString *)hideBankCardNumber:(NSString *)bankCardNum
{
    NSString *startString = [bankCardNum substringToIndex:4];
    NSString *endString = [bankCardNum substringWithRange:NSMakeRange(bankCardNum.length - 4, 4)];
    NSString *stringNum = [NSString stringWithFormat:@"%@********%@", startString, endString];
    return stringNum;
}





+ (BOOL)isPureIntNumber:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

//"leaveTime":778177000
+ (NSString *)twoDigit:(int)number
{
    if (number >= 0 && number < 10)
    {
       return [NSString stringWithFormat:@"0%i", number];
    }
    else
        return [NSString stringWithFormat:@"%i", number];
}

+ (NSString *)theCountdownTime:(long)time
{
    NSString * dateContent = nil;

    int days = ((int)time)/(3600*24);  //天
    int hours = ((int)time)%(3600*24)/3600;  //小时
    int minutes = ((int)time)%(3600*24)%3600/60;  //分
    int seconds = ((int)time)%(3600*24)%3600%60;  //秒
    
    
    
    if (days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0)
//        dateContent=@"0天00时00分00秒";
        dateContent=@"0天00:00:00";
    else
//        dateContent=[[NSString alloc] initWithFormat:@"%i天%i时%i分%i秒",days,hours,minutes,seconds];
        
        dateContent=[[NSString alloc] initWithFormat:@"%@天%@:%@:%@",[ZMTools twoDigit:days],
                     [ZMTools twoDigit:hours],
                     [ZMTools twoDigit:minutes],
                     [ZMTools twoDigit:seconds]];

    return dateContent;
}

//剩余0天00小时00分00秒
+ (NSString *)theUnitCountdownTime:(long)time
{
    NSString * dateContent = nil;
    
    int days = ((int)time)/(3600*24);  //天
    int hours = ((int)time)%(3600*24)/3600;  //小时
    int minutes = ((int)time)%(3600*24)%3600/60;  //分
    int seconds = ((int)time)%(3600*24)%3600%60;  //秒
    
    
    
    if (days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0)
                dateContent=@"剩余0天0小时0分0秒";
//        dateContent=@"0天00:00:00";
    else
        //        dateContent=[[NSString alloc] initWithFormat:@"%i天%i时%i分%i秒",days,hours,minutes,seconds];
        
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    
//        dateContent=[[NSString alloc] initWithFormat:@"剩余%@天%@小时%@分%@秒",[ZMTools twoDigit:days],
//                     [ZMTools twoDigit:hours],
//                     [ZMTools twoDigit:minutes],
//                     [ZMTools twoDigit:seconds]];
    
    return dateContent;
}



+(CGSize)calculateTheLabelSizeWithText:(NSString *)text font:(UIFont *)font
{
    CGSize size = CGSizeMake(WIDTH_OF_SCREEN, 20000.0f);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize contentLabelSize = [text boundingRectWithSize:size
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                             attributes:tdic
                                                                context:nil].size;
    //向上取整
    contentLabelSize = CGSizeMake(ceilf(contentLabelSize.width), ceilf(contentLabelSize.height));
    return contentLabelSize;
}




+ (NSString *) transformCurrentTime:(NSDate*) compareDate
{
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld个月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    
    
    return  result;
    
}


+(NSString *)transformCurrentDateString:(NSString*)compareDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:compareDateString];
    
    return [ZMTools transformCurrentTime: destDate];
}





#pragma 超过多少天使用正常的日期
+(NSString *) transformToCustomStringWithDate:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
    
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    
//改写 start
    else if((temp = temp/24) <7){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    //大于一周的，仍旧采用正常的日期格式
    else if(temp > 7){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        result = [dateFormatter stringFromDate: compareDate];
    }
//改写 end
    
    
    
    
//    else if((temp = temp/24) <30){
//        
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//        
//    }
//    else if((temp = temp/30) <12){
//        
//        result = [NSString stringWithFormat:@"%ld个月前",temp];
//        
//    }
//    
//    else{
//        
//        temp = temp/12;
//        
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//        
//    }
    
    return  result;
}

/**
 *
 *
 *  @param dateString
 *
 *  @return 返回新的通俗时间
 */
+(NSDate *)transformToDateWithDateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:dateString];
}



//yyyy-MM-dd HH:mm:ss -> yyyy-MM-dd
+(NSString *)formattingDateString:(NSString*)fromServerDateString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:fromServerDateString];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *openData = [formatter stringFromDate:date];
    return openData;
}


#pragma mark ====16进制的颜色转换========

+ (UIColor *)ColorWith16Hexadecimal:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}


//将万以上的数据变成万为单位的数据（万以上的数字）
+ (NSString *) moneyTenThousandUnitsValue:(double)digitalData
{
    float calculatedData = digitalData;
    
    if(calculatedData / 10000.0 >= 1.0)
    {
        digitalData = digitalData / 10000.0;
    }
    
    NSString *digitalString = [NSString stringWithFormat:@"%f", digitalData];
    
    
    NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    [formater setMinimumFractionDigits:0]; //去掉两位小数
    //    [formater setMinimumFractionDigits:2]; //不去掉两位小数
    [formater setMaximumFractionDigits:2];
    formater.currencyGroupingSeparator = @"*";
    
    
    NSString *str = [formater stringFromNumber:[NSNumber numberWithDouble:[[formater numberFromString:digitalString] doubleValue]]];
    
    if (calculatedData > 10000.0) {
        return [NSString stringWithFormat:@"%@", str];;
    }
    else
    {
        return str;
    }
}



//将万以上的数据变成万为单位的数据
+ (NSString *) moneyStandardMillionUnits:(double)digitalData
{
    float calculatedData = digitalData;
    
    if(calculatedData / 10000.0 > 1.0)
    {
        digitalData = digitalData / 10000.0;
    }
    
    NSString *digitalString = [NSString stringWithFormat:@"%f", digitalData];
    
    
    NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    [formater setMinimumFractionDigits:0]; //去掉两位小数
//    [formater setMinimumFractionDigits:2]; //不去掉两位小数
    [formater setMaximumFractionDigits:2];
    formater.currencyGroupingSeparator = @"*";
    
    
    NSString *str = [formater stringFromNumber:[NSNumber numberWithDouble:[[formater numberFromString:digitalString] doubleValue]]];
    
    if (calculatedData >= 10000.0) {
        return [NSString stringWithFormat:@"%@万", str];;
    }
    else
    {
        return str;
    }
}


/**
 *  格式化金钱
 *
 *  @param digitalString
 *
 *  @return 标准格式的货币金额表现形式
 */
+ (NSString *) moneyStandardFormatByString:(NSString *)digitalString
{
    //转格式：原来：13123453.23转为：13，123，453.23
    NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    [formater setMinimumFractionDigits:2];
    [formater setMaximumFractionDigits:2];
    formater.currencyGroupingSeparator = @"*";
    
    return [formater stringFromNumber:[NSNumber numberWithDouble:[[formater numberFromString:digitalString] doubleValue]]];
}

+ (NSString *) moneyStandardFormatByString:(NSString *)digitalString withDollarSign:(NSString *)sign
{
    //转格式：原来：13123453.23转为：13，123，453.23
    NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    [formater setMinimumFractionDigits:2];
    [formater setMaximumFractionDigits:2];
    formater.currencyGroupingSeparator = @"*";
    digitalString = [digitalString stringByReplacingOccurrencesOfString:sign withString:@""];
    digitalString = [formater stringFromNumber:[NSNumber numberWithDouble:[[formater numberFromString:digitalString] doubleValue]]];
    return [NSString stringWithFormat:@"%@%@",sign,digitalString];
}

+ (NSString *) moneyStandardFormatByData:(double)digitalData;
{
    NSString *digitalString = [NSString stringWithFormat:@"%f", digitalData];
    
    //转格式：原来：13123453.23转为：13，123，453.23
    NSNumberFormatter *formater = [[NSNumberFormatter alloc]init];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    [formater setMinimumFractionDigits:2];
    [formater setMaximumFractionDigits:2];
    formater.currencyGroupingSeparator = @"*";
    
    return [formater stringFromNumber:[NSNumber numberWithDouble:[[formater numberFromString:digitalString] doubleValue]]];
}


+(BOOL)isHomeNumber:(NSString *)number{
    
    NSString *phoneRegex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:number];
}

+(BOOL)isPhoneNumber:(NSString *)number{
    //1[3458]([0-9]){9}
    //    NSString *phoneRegex1 = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}

//身份证
+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
    
    /*
    if (![bankCardPredicate evaluateWithObject:bankCardNumber]) {
        return NO;
    }
    
// * accountNum : 存放银行卡帐号的字符串
// * strLen : 银行卡帐号的字符串长度
// * return  0 成功
// *        -1 帐号出错
    
    const char * accountNum = [bankCardNumber cStringUsingEncoding:NSUTF8StringEncoding];
    
    int strLen = (int)bankCardNumber.length;
    
    CLog(@"strLen = %d", strLen);

        int iRet = 0;
        int i = 0;
        int mark = 0;
        int temp = 0;
        
        while( i < strLen - 1 )
        {
            CLog(@"accountNum[%d] = %d", i, accountNum[i]);
            
            mark += accountNum[i];
            i++;
            temp = accountNum[i] * 2;
            i++;
            mark = temp / 10 + temp % 10;
        }
        if( accountNum[strLen - 1] != (10 - mark % 10) )
        {
            iRet = -1;
        }
    
    
    
    if (iRet == -1) {
        CLog(@"银行卡号 出错");
    }
    else if(iRet == 0)
    {
        CLog(@"银行卡号 正确");
    }
    else
    {
        CLog(@"银行卡号 不正确");
    }
    
        return iRet;
    */
}

+(BOOL)validateCreditCardNumber:(NSString *)cardNo
{
    int sum = 0;
    int len = [cardNo length];
    int i = 0;
    
    while (i < len) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(len - 1 - i, 1)];
        int tmpVal = [tmpString intValue];
        if (i % 2 != 0) {
            tmpVal *= 2;
            if(tmpVal>=10) {
                tmpVal -= 9;
            }
        }
        sum += tmpVal;
        i++;
    }
    
    if((sum % 10) == 0)
        return YES;
    else
        return NO;
}


/*
+(BOOL)validateCreditCardNumber:(NSString *)value
{
    BOOL result = TRUE;
    NSInteger length = [value length];
    if (length >= 13)
    {
        result = [IdentifierValidator isValidNumber:value];
        if (result)
        {
            NSInteger twoDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 2)] integerValue];
            NSInteger threeDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 3)] integerValue];
            NSInteger fourDigitBeginValue = [[value substringWithRange:NSMakeRange(0, 4)] integerValue];
            //Diner's Club
            if (((threeDigitBeginValue >= 300 && threeDigitBeginValue <= 305)||
                 fourDigitBeginValue == 3095||twoDigitBeginValue==36||twoDigitBeginValue==38) && (14 != length))
            {
                result = FALSE;
            }
            //VISA
            else if([value isStartWithString:@"4"] && !(13 == length||16 == length))
            {
                result = FALSE;
            }
            //MasterCard
            else if((twoDigitBeginValue >= 51||twoDigitBeginValue <= 55) && (16 != length))
            {
                result = FALSE;
            }
            //American Express
            else if(([value isStartWithString:@"34"]||[value isStartWithString:@"37"]) && (15 != length))
            {
                result = FALSE;
            }
            //Discover
            else if([value isStartWithString:@"6011"] && (16 != length))
            {
                result = FALSE;
            }
            else
            {
                NSInteger begin = [[value substringWithRange:NSMakeRange(0, 6)] integerValue];
                //CUP
                if ((begin >= 622126 && begin <= 622925) && (16 != length))
                {
                    result = FALSE;
                }
                //other
                else
                {
                    result = TRUE;
                }
            }
        }
        if (result)
        {
            NSInteger digitValue;
            NSInteger checkSum = 0;
            NSInteger index = 0;
            NSInteger leftIndex;
            //even length, odd index
            if (0 == length%2)
            {
                index = 0;
                leftIndex = 1;
            }
            //odd length, even index
            else
            {
                index = 1;
                leftIndex = 0;
            }
            while (index < length)
            {
                digitValue = [[value substringWithRange:NSMakeRange(index, 1)] integerValue];
                digitValue = digitValue*2;
                if (digitValue >= 10)
                {
                    checkSum += digitValue/10 + digitValue%10;
                }
                else
                {
                    checkSum += digitValue;
                }
                digitValue = [[value substringWithRange:NSMakeRange(leftIndex, 1)] integerValue];
                checkSum += digitValue;
                index += 2;
                leftIndex += 2;
            }
            result = (0 == checkSum%10) ? TRUE:FALSE;
        }
    }
    else
    {
        result = FALSE;
    }
    return result;
}
*/

@end
