//
//  NewProductCellView.h
//  ZiMaCaiHang
//
//  Created by jxgg on 15/9/9.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^InvestActionBlock)(id singleProduct);
@interface NewProductCellView : UIView
@property(nonatomic ,copy) InvestActionBlock investActionBlock;
@property (strong, nonatomic) NSDictionary * productInfoDic; //产品信息（用于首页推荐项目）
@property (weak, nonatomic) IBOutlet UILabel *ProductDescription;
@property (weak, nonatomic) IBOutlet UILabel *TipOne;
@property (weak, nonatomic) IBOutlet UILabel *TipTwo;
@property (weak, nonatomic) IBOutlet UILabel *TipThree;
@property (weak, nonatomic) IBOutlet UIButton *NowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *TipImage1;
@property (weak, nonatomic) IBOutlet UIImageView *TipImage2;
@property (weak, nonatomic) IBOutlet UIImageView *TipImage3;
@property (weak, nonatomic) IBOutlet UILabel *ProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *ProductYield;
@property (weak, nonatomic) IBOutlet UILabel *PurchaseAmount;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *hqsyLabel;
-(id)initWithFrame:(CGRect)frame;
-(void)setupProductInfo:(NSDictionary *)productInfo;
@end
