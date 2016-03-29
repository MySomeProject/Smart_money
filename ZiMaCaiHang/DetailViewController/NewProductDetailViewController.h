//
//  NewProductDetailViewController.h
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/24.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^UpdateHomePageAllDataAffterInvestSuccessBlock)();

@interface NewProductDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
@property (nonatomic, copy)NSString* titleStr;
@property (strong, nonatomic) NSDictionary *productInfoDic;   //单个产品信息（首页推荐项目\项目列表数据）
@property (strong, nonatomic) NSDictionary *productDetailInfoDic;   //详细产品信息
@property (nonatomic) NSArray *investRecordsArray;   //产品投资纪记录

@property (nonatomic, copy) UpdateHomePageAllDataAffterInvestSuccessBlock updateHomePageAllDataBlock;




@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *nianhuashouyi;
@property (weak, nonatomic) IBOutlet UILabel *qixian;
@property (weak, nonatomic) IBOutlet UILabel *wanchenglabel;
@property (weak, nonatomic) IBOutlet UIImageView *yellowCicle;
@property (weak, nonatomic) IBOutlet UIButton *leftbutton;
@property (weak, nonatomic) IBOutlet UIButton *midbutton;
@property (weak, nonatomic) IBOutlet UIButton *rightbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *childBgView;
@property (weak, nonatomic) IBOutlet UIView *midBg;
@property (weak, nonatomic) IBOutlet UIButton *touziButton;
@property (weak, nonatomic) IBOutlet UIView *touziVIew;
@property (weak, nonatomic) IBOutlet UILabel *querenNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuqishouyiLabel;
@property (weak, nonatomic) IBOutlet UIButton *delbutton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *keyongnumlabel;
@property (weak, nonatomic) IBOutlet UIButton *touziCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *zongeLabel;
@property (weak, nonatomic) IBOutlet UILabel *qitoulabel;
@property (weak, nonatomic) IBOutlet UILabel *tznumlabel;
@property (weak, nonatomic) IBOutlet UILabel *tzjllabel;
@property (weak, nonatomic) IBOutlet UITextField *tztextfield;
@property (weak, nonatomic) IBOutlet UILabel *satflabel;
@property (weak, nonatomic) IBOutlet UILabel *baozhangLabel;
@property (weak, nonatomic) IBOutlet UILabel *huanxilabel;
@property (weak, nonatomic) IBOutlet UILabel *jixilabel;
@property (weak, nonatomic) IBOutlet UIButton *userxieyiBtn;

@end
