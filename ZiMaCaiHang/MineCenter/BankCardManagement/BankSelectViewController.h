//
//  BankSelectViewController.h
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BaseViewController.h"

@interface BankSelectViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
typedef void (^changeBankBlock)(NSString* name,NSString * bankid); //block方法2 第一步typedef一个block；

@property(nonatomic,copy)changeBankBlock block; //block方法2 copy一个block执行nscopy协议
@property (nonatomic,copy) NSString * cityCode;
@property (nonatomic,copy) NSString * cardNo;
@property (weak, nonatomic) IBOutlet UISearchBar *Serchbar;
@property (weak, nonatomic) IBOutlet UIView *serchbgView;

@end
