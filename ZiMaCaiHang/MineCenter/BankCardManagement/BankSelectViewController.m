//
//  BankSelectViewController.m
//  ZiMaCaiHang
//
//  Created by jxgg on 15/7/30.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BankSelectViewController.h"
#import "GTCommontHeader.h"
@interface BankSelectViewController (){
    UITableView* _tableview;
    NSMutableArray* banksAry;
    NSMutableArray*  suoyinCityList;
    NSMutableArray*  hotcityList;
    UISearchDisplayController* _displayC;
    NSMutableArray* _searchArray;
    NSString* nowBankId;
}

@end
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation BankSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择支行";
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:246.0f/255.0f alpha:1];
    
    
    if (Version>7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;//ios8 影响tableview坐标
    }
    self.navigationController.navigationBar.translucent= NO;

    
    self.serchbgView.frame = CGRectMake(GTFixWidthFlaot(15), 22, WIDTH_OF_SCREEN-GTFixWidthFlaot(15)*2,30);
    self.Serchbar.frame = CGRectMake(0, -7, WIDTH_OF_SCREEN-GTFixWidthFlaot(15)*2, 44);
    self.Serchbar.backgroundColor = [UIColor clearColor];
    self.serchbgView.layer.cornerRadius = 15;
    self.serchbgView.layer.masksToBounds = YES;
    
    
    
    banksAry = [[NSMutableArray alloc] init];
    suoyinCityList  = [[NSMutableArray alloc] init];
    hotcityList = [[NSMutableArray alloc] init];
//    self.navigationController.navigationBar.hidden = YES;
    [self creattableview];
    [self requestBancklist];
         }
-(void)requestBancklist{
    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HUDjz setLabelText:@"获取支行信息ing..."];
    
    [[ZMServerAPIs shareZMServerAPIs] getBankListWithCityCode:self.cityCode CardNum:self.cardNo  Success:^(id response) {
        CLog(@"发送用户反馈成功 OK ＝ %@", response);
        if ([[response objectForKey:@"code"] intValue]  == 1000) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [banksAry addObjectsFromArray:[response objectForKey:@"banklist"]];
                nowBankId =[response objectForKey:@"bankId"];
                [_tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                [HUDjz hide:YES afterDelay:1.0];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDjz setLabelText:[response objectForKey:@"mes"]];
                [HUDjz hide:YES afterDelay:1.0];
            });

        }
        
    } failure:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDjz setLabelText:@"获取支行信息失败"];
            [HUDjz hide:YES afterDelay:1.0];
        });
        
    }];

}
-(void)creattableview{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN-75-64) style:UITableViewStylePlain];
    //    _tableview.layer.cornerRadius= 6;
    //    _tableview.layer.masksToBounds = YES;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundView = nil;
    _tableview.tableHeaderView = nil;
    _tableview.tableFooterView = nil;
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.allowsSelection=YES;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.sectionIndexColor = [UIColor grayColor];
    _tableview.sectionIndexBackgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.89];
    //        _tableview.tableHeaderView=nil;
    //        _tableview.tableFooterView= nil;
    //    _tableview.tableFooterView.backgroundColor = [UIColor whiteColor];
//    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableview];
    
    self.Serchbar.delegate = self;
    _displayC = [[UISearchDisplayController alloc] initWithSearchBar:self.Serchbar contentsController:self];

    //搜索控制器中有一个tableView
    //必须要设置代理
    _displayC.searchResultsDelegate = self;
    //谁提供数据源
    _displayC.searchResultsDataSource = self;
    //都是给这个_displayC指向对象中的tableView设置的
    
    //创建一个保存显示结果的数据源数组
    _searchArray = [[NSMutableArray alloc] init];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    
    return YES;
};
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.searchBarStyle = UISearchBarStyleDefault;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView != _tableview) {
        static NSString *cellIde = @"topcell";
        UITableViewCell *cellH = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cellH == nil) {
            cellH = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WIDTH_OF_SCREEN, 20)];
            label.font = [UIFont systemFontOfSize:13.2f];
            label.tag = 166;
            [cellH.contentView addSubview:label];
            
//            UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 35, WIDTH_OF_SCREEN-20, 1)];
//            lineview.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:1];
//            lineview.tag = 188;
//            cellH.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cellH.contentView addSubview:lineview];
        }
        UILabel* label =(UILabel*)[cellH.contentView viewWithTag:166];
        label.text = [[_searchArray objectAtIndex:indexPath.row] objectForKey:@"brabank_name"];
        return cellH;
    }else {
            static NSString *cellIde = @"topcell";
            UITableViewCell *cellH = [tableView dequeueReusableCellWithIdentifier:cellIde];
            if (cellH == nil) {
                cellH = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WIDTH_OF_SCREEN, 20)];
                label.font = [UIFont systemFontOfSize:13.2f];
                label.tag = 166;
                [cellH.contentView addSubview:label];
                
                
//                UIView* lineviewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 1)];
//                lineviewtop.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:1];
//                lineviewtop.tag = 187;
//                [cellH.contentView addSubview:lineviewtop];
//                
//                UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 35, WIDTH_OF_SCREEN-20, 1)];
//                lineview.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:229.0f/255.0f alpha:1];
//                lineview.tag = 188;
//                cellH.selectionStyle = UITableViewCellSelectionStyleNone;
//                [cellH.contentView addSubview:lineview];
            }
        
            UILabel* label =(UILabel*)[cellH.contentView viewWithTag:166];
            label.text = [[banksAry objectAtIndex:indexPath.row] objectForKey:@"brabank_name"];
            return cellH;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView != _tableview) {
        //prcptcd
        [[_searchArray objectAtIndex:indexPath.row] objectForKey:@"prcptcd"];
        [[_searchArray objectAtIndex:indexPath.row] objectForKey:@"brabank_name"];
        self.block([[_searchArray objectAtIndex:indexPath.row] objectForKey:@"brabank_name"],nowBankId);

        [self.navigationController popViewControllerAnimated:YES];
    }else{
        self.block([[banksAry objectAtIndex:indexPath.row] objectForKey:@"brabank_name"],nowBankId);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView != _tableview) {
        //表示搜索控制器的tableView
        //一旦向searchBar中输入数据 那么 就会一直刷新(reloadData)搜索控制器的tableView
        
        //第一步要把之前_searchArray数组中元素 清空
        //然后来遍历_dataArray 数组中有没有 包含搜索条中输入内容
        /*for (NSMutableArray *subArray in _dataArray) {
         //遍历subArray
         for (UserItem *item in subArray) {
         //看从数据源数组中能不能找到_searchBar的内容
         NSRange range = [item.name rangeOfString:_searchBar.text];
         if (range.location != NSNotFound) {
         //增加到_searchArray数据源中
         [_searchArray addObject:item];
         }
         
         }
         }*/
        [_searchArray removeAllObjects];
        NSMutableArray * allcityarray = [[NSMutableArray alloc] init];
        
        [allcityarray addObjectsFromArray:banksAry];
        for (NSDictionary * nowcitydic in  allcityarray ) {
            NSRange range = [[nowcitydic objectForKey:@"brabank_name"] rangeOfString:self.Serchbar.text];
            if (range.location != NSNotFound) {
                [_searchArray addObject:nowcitydic];
            }
        }
        return _searchArray.count;
    }
    return banksAry.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
