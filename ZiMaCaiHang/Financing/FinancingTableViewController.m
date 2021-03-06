//
//  FinancingTableViewController.m
//  ZiMaCaiHang
//
//  Created by zhangxh on 15-4-15.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "FinancingTableViewController.h"
#import "NewProductDetailViewController.h"
//刷新
#import "MJRefresh.h"       //上下拉刷新控制
#import "AppDelegate.h"
#import "CustomInvestCell.h"
#import "Reachability.h"

//#import "AllDetailViewController.h"

@interface FinancingTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray *allLoadedProductArray;
@end
@implementation FinancingTableViewController
{
    AppDelegate *_appdelegate;
    int currentPage; // 1 获取最新的数据，消除已经加载的数据；大于1，获取旧的数据。
    UILabel *noMessageLabel;
    NSDictionary * _productInfoDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate storyBoradAutoLay:self.view];
    //产品信息数组
    _allLoadedProductArray = [[NSMutableArray alloc]init];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headUpdata)];
    
    //上拉加载

    [self.tableView addLegendFooterWithRefreshingBlock:^{
        currentPage = currentPage+1;
        [self rqeuestData:currentPage];
    }];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"跑步%zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"跑步%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    
    //去掉table view的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = YES;
    noMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (HEIGHT_OF_SCREEN-50)/2 - 100, WIDTH_OF_SCREEN, 50)];
    noMessageLabel.text = @"暂无符合条件的产品";
    noMessageLabel.textColor = [UIColor lightGrayColor];
    noMessageLabel.font = [UIFont boldSystemFontOfSize:25];
    noMessageLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    noMessageLabel.shadowOffset = CGSizeMake(1.0f, 2.0f);
    [noMessageLabel setTextAlignment:NSTextAlignmentCenter];
    [self.tableView addSubview:noMessageLabel];
    
    
    [self rqeuestData:currentPage];

}


-(void)viewDidLayerOut
{
    UILabel *label = (UILabel *)[self.view viewWithTag:300];
    label.layer.cornerRadius = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.tableView headerBeginRefreshing];
    [self.tableView.header beginRefreshing];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView.header endRefreshing];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"show" object:nil];
}

#pragma mark - 刷新
- (void)headUpdata
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        currentPage = 1;
        [self rqeuestData:currentPage];
        
//    });
}
#pragma mark - 加载
- (void)footerUpdata
{
    currentPage = currentPage+1;
    [self rqeuestData:currentPage];
}
#pragma mark - 网络请求
- (void)rqeuestData:(int)page
{
//    MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [HUDjz setLabelText:@"加载ing..."];
    [self.view sendSubviewToBack:self.tableView];
    
    
    __weak typeof(self) weakSelf = self;
    
    [[ZMServerAPIs shareZMServerAPIs]getProductListByCategoryType:@"ALL" Page:page RowCount:10 Success:^(id response) {
        
        if(page==1)
        {
            if(weakSelf.allLoadedProductArray.count>0)
            {
                [weakSelf.allLoadedProductArray removeAllObjects];
            }
        }
        
            CLog(@"紫贷宝列表 = response = %@", response);
            NSArray *dataArr =  [[response objectForKey:@"data"] objectForKey:@"productList"];
            for(NSDictionary *dict in dataArr)
            {
                
                if (![[dict objectForKey:@"productType"] isEqualToString:@"JIJIFENG"] && ![[dict objectForKey:@"productType"] isEqualToString:@"MORE_DAY"] && ![[dict objectForKey:@"productType"] isEqualToString:@"YUEMANYING"] && ![[dict objectForKey:@"productType"] isEqualToString:@"CAIXIANGYU"]&& ![[dict objectForKey:@"productType"]  isEqualToString:@"RIZIBAO"]) {
                    
                }else{
                [weakSelf.allLoadedProductArray addObject:dict];
                }
                
//                [weakSelf.allLoadedProductArray addObject:dict];
            }
        
        
        
            if (weakSelf.allLoadedProductArray.count == 0) {
                return;
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{

                    [noMessageLabel removeFromSuperview];
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.header endRefreshing];
                    [weakSelf.tableView.footer endRefreshing];
                });
            }
    } failure:^(id response) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
//        MyAlertView(@"网络异常，请检查网络！");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD *HUDjz = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];

            [HUDjz setLabelText:@"请检查网络"];
            [HUDjz hide:YES afterDelay:0.8];
        });
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allLoadedProductArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseCellIndentifier5 = @"CustomInvestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier5];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CustomInvestCell" owner:nil options:nil] lastObject];
    }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.allLoadedProductArray.count>0)
        {
        _productInfoDic = [self.allLoadedProductArray objectAtIndex:indexPath.row];
       
        [(CustomInvestCell *)cell setProductInfoDic:_productInfoDic];
    }
    CustomInvestCell *cuCell = (CustomInvestCell *)cell;

    [cuCell.investBtn addTarget:self action:@selector(investBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cuCell.investBtn.tag = indexPath.row+50;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 123*_appdelegate.autoSizeScaleY;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.allLoadedProductArray count] > 0) {
         NSDictionary * singleInfo = [self.allLoadedProductArray objectAtIndex:indexPath.row];
        [self pushToDetailVC:singleInfo];
        return;
    }
}
- (void)pushToDetailVC:(NSDictionary *)dict
{
   
    CLog(@"项目详情——singleInfo = %@", dict);
    NewProductDetailViewController* newDetail = [[NewProductDetailViewController alloc] init];
    if([[dict valueForKey:@"productType"] isEqualToString:@"RIZIBAO"])
        newDetail.titleStr = @"财行宝";
    if([[dict valueForKey:@"productType"] isEqualToString:@"MORE_DAY"])
        newDetail.titleStr = @"财行加";
    if([[dict valueForKey:@"productType"] isEqualToString:@"YUEMANYING"])
        newDetail.titleStr = @"财月盈";
    if([[dict valueForKey:@"productType"] isEqualToString:@"JIJIFENG"])
        newDetail.titleStr = @"财季盈";
    if([[dict valueForKey:@"productType"] isEqualToString:@"CAIXIANGYU"])
        newDetail.titleStr = @"财相遇";
    if([[dict valueForKey:@"productType"] isEqualToString:@"DAY_NUM"])
        newDetail.titleStr = @"财";
    [newDetail setValue:dict forKey:@"productInfoDic"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiden" object:nil];
    [self.navigationController pushViewController:newDetail animated:YES];
}
- (void)investBtnAction:(UIButton *)sender
{
    
//    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    
//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//            // 没有网络连接
//            CLog(@"没有网络");
//            
//            [self showName];
//            break;
//            
//        case ReachableViaWWAN:
//            // 使用3G网络
//            CLog(@"正在使用3G网络");
//            [self pushToDetailVC:self.allLoadedProductArray[sender.tag-50]];
//
//            break;
//            
//        case ReachableViaWiFi:
//            // 使用WiFi网络
//            CLog(@"正在使用wifi网络");
//            [self pushToDetailVC:self.allLoadedProductArray[sender.tag-50]];
//
//            break;
//    }
    
    
    [self pushToDetailVC:self.allLoadedProductArray[sender.tag-50]];

}

-(void)showName
{
    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ProgressHUD setLabelText:@"请检查网络"];
    [ProgressHUD hide:YES afterDelay:0.8];
}

@end
