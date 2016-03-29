//
//  NewProductCellView.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/9/9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "NewProductCellView.h"
#import "GTCommontHeader.h"
#import "CircleView.h"

@implementation NewProductCellView{
    UILabel* productTitle;
    UILabel* productMiaoshu;
    UILabel* ProfitType;
    UILabel* ProfitNum;
    UILabel* CangoLabel;
    NSString* intretStr;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
            self = [[NSBundle mainBundle] loadNibNamed:@"NewProductCellView" owner:self options:nil][0];
        [self setFrame:frame];
        [self ChangeFrame];
        [self creatCirCle];
        if (HEIGHT_OF_SCREEN == 480) {
            [self changeFor4S];
            
        }
        [self.NowBtn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    return self;
}
-(void)creatCirCle{
    UIView* view = [[UIView alloc] init];
    [view setFrame:CGRectMake(GTFixWidthFlaot(75),GTFixHeightFlaot(70),GTFixWidthFlaot(170),GTFixHeightFlaot(146))];
    view.clipsToBounds = YES;
    [self addSubview:view];
    
    CGRect frame = CGRectMake(0,0, GTFixWidthFlaot(170),GTFixWidthFlaot (170));
    if (HEIGHT_OF_SCREEN == 480) {
        [view setFrame:CGRectMake(100, 55, 120, 120)];
        frame = CGRectMake(0, 0, 120, 120);
    }
    CircleView* circleView1 = [[CircleView alloc] initWithFrame:frame andLine:5.0f];
    circleView1.strokeColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    circleView1.transform = CGAffineTransformRotate(self.transform, 45.0/180*M_PI+M_PI);

    circleView1.tag = 111;
    [circleView1 setStrokeEnd:0.75 animated:NO];
    [circleView1 setBackgroundColor:[UIColor clearColor]];
//    circleView1.transform = CGAffineTransformRotate(self.transform,53.13/180*M_PI+M_PI);
    [view addSubview:circleView1];
    
    CircleView* circleView2 = [[CircleView alloc] initWithFrame:frame andLine:5.0f];
    circleView2.strokeColor = [UIColor colorWithRed:227/255.0 green:99/255.0 blue:84/255.0 alpha:1];
    circleView2.tag = 666;
    [circleView2 setBackgroundColor:[UIColor clearColor]];
//    [circleView2 setStrokeEnd:(1+0.01)*0.71 animated:NO];
    [view addSubview:circleView2];
    
    circleView2.transform = CGAffineTransformRotate(self.transform, 45.0/180*M_PI+M_PI);

    
    //0.14* 2  = 0.28 
}

-(void)ChangeFrame{
    for (UIView* view in self.subviews){
        view.frame = GetFramByXib(view.frame);
        for (UIView* childview in view.subviews){
            childview.frame = GetFramByXib(childview.frame);
        }
    }
}
-(void)changeFor4S{
    self.ProductTitle.origin = CGPointMake(self.ProductTitle.left, self.ProductTitle.top-5);
    self.ProductDescription.origin =  CGPointMake(self.ProductDescription.left, self.ProductDescription.top-5);

    self.hqsyLabel.frame = CGRectMake(112, 70, self.hqsyLabel.width, self.hqsyLabel.height);
    
    self.ProductYield.frame = CGRectMake(75, 88, self.ProductYield.width,self.ProductYield.height);
    
    self.lineView.frame = CGRectMake(self.lineView.left+20, self.lineView.top-45,self.lineView.width-40 ,self.lineView.height);
    
    self.PurchaseAmount.frame = CGRectMake(self.PurchaseAmount.left, self.PurchaseAmount.top-53, self.PurchaseAmount.width,self.PurchaseAmount.height);
    
    self.NowBtn.frame = CGRectMake(self.NowBtn.left, self.NowBtn.top-70,self.NowBtn.width, self.NowBtn.height);
    
    for (int i = 0; i<3; i++) {
        UIImageView* img = (UIImageView*)[self viewWithTag:2000+i];
        UILabel* label = (UILabel*)[self viewWithTag:2010+i];

        img.frame = CGRectMake(img.left, img.top-81,img.width, img.height);
        label.frame = CGRectMake(label.left, label.top-81,label.width, label.height);
    }
}
-(void)setupProductInfo:(NSDictionary *)productInfo
{
    _productInfoDic = productInfo;
    CLog(@"productInfo = %@", productInfo);
    self.ProductTitle.font = [UIFont systemFontOfSize:GTFixHeightFlaot(18)];
    self.ProductDescription.font = [UIFont boldSystemFontOfSize:GTFixHeightFlaot(13)];
    self.hqsyLabel.font = [UIFont boldSystemFontOfSize:GTFixHeightFlaot(13)];
    self.ProductYield.font = [UIFont boldSystemFontOfSize:GTFixHeightFlaot(45)];
    self.PurchaseAmount.font = [UIFont boldSystemFontOfSize:GTFixHeightFlaot(12)];
    
    
    //是否可投
    NSString * statusStr = [_productInfoDic objectForKey:@"status"];
    CLog(@"%@",statusStr);
    if([statusStr isEqualToString:@"FINISHED"])
    {
        [_NowBtn setBackgroundImage:[UIImage imageNamed:@"jishu"] forState:UIControlStateNormal];
        [_NowBtn setTitle:@"" forState:UIControlStateNormal];
        
    }else{
        [_NowBtn setBackgroundImage:[UIImage imageNamed:@"woyaotouzi"] forState:UIControlStateNormal];
        [_NowBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    }

    if([[productInfo objectForKey:@"productType"] isEqualToString:@"MORE_DAY"])
    {
        self.ProductTitle.text = @"财行加";
        self.ProductDescription.text = @"尊贵体验，坐享收益";
        self.hqsyLabel.text = @"年化收益率";
        
        NSArray* lbary = @[@"超高收益",@"本息保障",@"资金安全"];
        NSArray* imary = @[@"icon small4",@"icon small1",@"xinshoubiao1"];
        
        for (int i = 0; i<3; i++) {
            UIImageView* img = (UIImageView*)[self viewWithTag:2000+i];
            [img setImage:[UIImage imageNamed:[imary objectAtIndex:i]]];
            UILabel* label = (UILabel*)[self viewWithTag:2010+i];
            [label setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(12)]];
            [label setText:[lbary objectAtIndex:i]];
        }
        
        float interetValue = [[_productInfoDic objectForKey:@"interest"] floatValue];
        NSString* intretStr = [NSString stringWithFormat:@"%.0f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
        if (HEIGHT_OF_SCREEN == 480) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,2)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(2,str2.length-2)];
        
//        NSString *str = [NSString stringWithFormat:@"%f",interetValue];
//        if ([str floatValue]==[str intValue]){
//            intretStr = [NSString stringWithFormat:@"%.0f%@",interetValue-5.0f,@"%+5%"];
//            
//        }else{
//            intretStr = [NSString stringWithFormat:@"%.1f%@",interetValue-5.0f,@"%+5%"];
//        }
//        
//        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
//        if (HEIGHT_OF_SCREEN == 480) {
//            if ([intretStr floatValue] > 10) {
//                [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,2)];
//            }else
//                [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,1)];
//        }
//        if ([intretStr floatValue] > 10) {
//            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(2,str2.length-2)];
//        }else
//            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(1,str2.length-1)];
        self.ProductYield.attributedText = str2;
        
        
        //起投
        
        NSString * minAmount = [NSString stringWithFormat:@"投资期限:%d天", [[productInfo objectForKey:@"numDay"] intValue]];
        self.PurchaseAmount.text = minAmount;

//        NSString* minAmount;
//        int numday = [[productInfo objectForKey:@"numDay"] intValue];
//        if (numday>0) {
//                minAmount =  [NSString stringWithFormat:@"投资期限:%d天", [[productInfo objectForKey:@"numDay"] intValue]];
//        }else{
//                minAmount =  [NSString stringWithFormat:@"投资期限:%d个月", [[productInfo objectForKey:@"month"] intValue]];
//        }
//        if ([[productInfo objectForKey:@"productType"] isEqualToString:@"YUEMANYING"]){
//                NSMutableString* str = [[NSMutableString alloc] initWithString:[ZMTools monthValueFromMonthType:[productInfo objectForKey:@"month"]]];
//                
//                minAmount= [NSString stringWithFormat:@"投资期限:%d个月", [str intValue]];
//            }
//        self.PurchaseAmount.text = minAmount;
    }
    else if([[productInfo objectForKey:@"productType"] isEqualToString:@"RIZIBAO"])
    {
        self.ProductTitle.text  = @"财行宝";
        self.ProductDescription.text = @"活期理财，存取灵活";
        self.hqsyLabel.text = @"年化收益率";
        NSArray* lbary = @[@"当日计息",@"本息保障",@"随时提取"];
        for (int i = 0; i<3; i++) {
            UILabel* label = (UILabel*)[self viewWithTag:2010+i];
            [label setText:[lbary objectAtIndex:i]];
            [label setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(12)]];
            
        }
        //收益
        float interetValue = [[_productInfoDic objectForKey:@"interest"] floatValue];
        NSString* intretStr = [NSString stringWithFormat:@"%.0f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
        if (HEIGHT_OF_SCREEN == 480) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,1)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(1,str2.length-1)];
        self.ProductYield.attributedText = str2;
        
        //起投
        NSString * minAmount = [NSString stringWithFormat:@"起购金额:%d元", [[productInfo objectForKey:@"minAmount"] intValue]];
        self.PurchaseAmount.text = minAmount;

    }
    else if ([[productInfo objectForKey:@"productType"] isEqualToString:@"YUEMANYING"])
    {
        self.ProductTitle.text = @"财月盈";
        self.ProductDescription.text = @"月度理财，尊享生活";
        self.hqsyLabel.text = @"年化收益率";
        
        NSArray* lbary = @[@"优质项目",@"本息保障",@"资金安全"];
        NSArray* imary = @[@"yzxm",@"icon small1",@"xinshoubiao1"];
        
        for (int i = 0; i<3; i++) {
            UIImageView* img = (UIImageView*)[self viewWithTag:2000+i];
            [img setImage:[UIImage imageNamed:[imary objectAtIndex:i]]];
            UILabel* label = (UILabel*)[self viewWithTag:2010+i];
            [label setText:[lbary objectAtIndex:i]];
            [label setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(12)]];

        }
        float interetValue = [[_productInfoDic objectForKey:@"interest"] floatValue];
        NSString* intretStr = [NSString stringWithFormat:@"%.1f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
        if (HEIGHT_OF_SCREEN == 480) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,3)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(3,str2.length-3)];
        self.ProductYield.attributedText = str2;
        //起投
//        NSString* minAmount;
//        int numday = [[productInfo objectForKey:@"numDay"] intValue];
//        if (numday>0) {
//            minAmount =  [NSString stringWithFormat:@"投资期限:%d天", [[productInfo objectForKey:@"numDay"] intValue]];
//        }else{
//            minAmount =  [NSString stringWithFormat:@"投资期限:%d个月", [[productInfo objectForKey:@"month"] intValue]];
//        }
//        if ([[productInfo objectForKey:@"productType"] isEqualToString:@"YUEMANYING"]){
//            NSMutableString* str = [[NSMutableString alloc] initWithString:[ZMTools monthValueFromMonthType:[productInfo objectForKey:@"month"]]];
//            
//            minAmount= [NSString stringWithFormat:@"投资期限:%d个月", [str intValue]];
//        }
        NSString * minAmount = [NSString stringWithFormat:@"起购金额:%d元", [[productInfo objectForKey:@"minAmount"] intValue]];
        self.PurchaseAmount.text = minAmount;
        
    }
    else if ([[productInfo objectForKey:@"productType"] isEqualToString:@"JIJIFENG"])
    {
        self.ProductTitle.text = @"财季盈";
        self.ProductDescription.text = @"季度理财，稳赚收益";
        self.hqsyLabel.text = @"年化收益率";
        
        NSArray* lbary = @[@"优质项目",@"本息保障",@"资金安全"];
        NSArray* imary = @[@"yzxm",@"icon small1",@"xinshoubiao1"];
        
        for (int i = 0; i<3; i++) {
            UIImageView* img = (UIImageView*)[self viewWithTag:2000+i];
            [img setImage:[UIImage imageNamed:[imary objectAtIndex:i]]];
            UILabel* label = (UILabel*)[self viewWithTag:2010+i];
            [label setText:[lbary objectAtIndex:i]];
            [label setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(12)]];
            
        }
        float interetValue = [[_productInfoDic objectForKey:@"interest"] floatValue];
        NSString* intretStr = [NSString stringWithFormat:@"%.0f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
        if (HEIGHT_OF_SCREEN == 480) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,2)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(2,str2.length-2)];
        self.ProductYield.attributedText = str2;
        //起投
        NSString * minAmount = [NSString stringWithFormat:@"起购金额:%d元", [[productInfo objectForKey:@"minAmount"] intValue]];
        self.PurchaseAmount.text = minAmount;
        
    }

    else if ([[productInfo objectForKey:@"productType"] isEqualToString:@"CAIXIANGYU"])
    {
        self.ProductTitle.text = @"财相遇";
        self.ProductDescription.text = @"新手体验，超高收益";
        self.hqsyLabel.text = @"年化收益率";
        
        NSArray* lbary = @[@"新手专供",@"本息保障",@"资金安全"];
        NSArray* imary = @[@"xinshou",@"icon small1",@"xinshoubiao1"];
        
        for (int i = 0; i<3; i++) {
            UIImageView* img = (UIImageView*)[self viewWithTag:2000+i];
            [img setImage:[UIImage imageNamed:[imary objectAtIndex:i]]];
            UILabel* label = (UILabel*)[self viewWithTag:2010+i];
            [label setText:[lbary objectAtIndex:i]];
            [label setFont:[UIFont systemFontOfSize:GTFixHeightFlaot(12)]];
            
        }
        float interetValue = [[_productInfoDic objectForKey:@"interest"] floatValue];
        NSString* intretStr = [NSString stringWithFormat:@"%.0f%@",interetValue,@"%"];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:intretStr];
        if (HEIGHT_OF_SCREEN == 480) {
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(38)] range:NSMakeRange(0,2)];
        }
        [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:GTFixHeightFlaot(20)] range:NSMakeRange(2,str2.length-2)];
        self.ProductYield.attributedText = str2;
        //起投
        
        NSString * minAmount = [NSString stringWithFormat:@"投资期限:%d天", [[productInfo objectForKey:@"numDay"] intValue]];
        self.PurchaseAmount.text = minAmount;

        
    }

    CircleView* circleView = (CircleView*)[self viewWithTag:666];
//    float stroketo = ((1.0 -([[productInfo objectForKey:@"availabeAmount"] floatValue] / [[productInfo objectForKey:@"amount"] floatValue])+0.01))*0.741;
    float stroketo = ([[productInfo objectForKey:@"finishedRatio"]floatValue])*0.01*0.741;
    
//    if (([[productInfo objectForKey:@"availabeAmount"] floatValue] / [[productInfo objectForKey:@"amount"] floatValue])>0.5) {
    if ([[productInfo objectForKey:@"finishedRatio"]floatValue]*0.01>0.5) {
    
//      stroketo  = ((1.0 -([[productInfo objectForKey:@"availabeAmount"] floatValue] / [[productInfo objectForKey:@"amount"] floatValue])))*0.741;
        stroketo  = [[productInfo objectForKey:@"finishedRatio"]floatValue]*0.01*0.741+0.01;
    }else{
//      stroketo = ((1.0 -([[productInfo objectForKey:@"availabeAmount"] floatValue] / [[productInfo objectForKey:@"amount"] floatValue])+0.01))*0.741;
        stroketo = ([[productInfo objectForKey:@"finishedRatio"]floatValue])*0.01*0.741;

        
    }
    [circleView setStrokeEnd:0 animated:NO];
    NSString* strostr = [NSString stringWithFormat:@"%.2f",stroketo];
    stroketo = [strostr floatValue];
    
    [circleView setStrokeEnd:stroketo animated:NO];

//    .progress = 1.0 -([[productInfo objectForKey:@"availabeAmount"] floatValue] / [[productInfo objectForKey:@"amount"] floatValue]);
}
-(void)go:(UIButton*)sender{
    self.investActionBlock(self.productInfoDic);
}

@end
