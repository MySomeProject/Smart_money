//
//  BackCashViewController.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/26.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "BackCashViewController.h"
#import "MJRefresh.h"
#import "BackCashCell.h"
#import "BackCashModel.h"
#define PAGESIZE 1
#define ROWNUMS 20
#import "AppDelegate.h"
@interface BackCashViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak  , nonatomic) IBOutlet UILabel *backState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
//  数据源
@property (strong, nonatomic)NSMutableArray *dataSource;
@end

@implementation BackCashViewController
{
    AppDelegate *_appdelegate;
    int _currentPage;
    NSString *_backMoneyStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc]init];
      self.navigationItem.leftBarButtonItem =  [ZMTools item:@"DetailBackButton" target:self select:@selector(backVC)];
    _currentPage = PAGESIZE;
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [self.tableView addHeaderWithTarget:self action:@selector(headUpdate)];
//    [self.tableView addFooterWithTarget:self action:@selector(footerUpdate)];
    
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headUpdate)];
    
    //上拉加载
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        _currentPage = _currentPage + 1;
        [self requestData:_currentPage];
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
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)backVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self selectCardAction:self.segment];
    
}
#pragma mark - 刷新
- (void)headUpdate
{
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        _currentPage = 1;
        [self requestData:_currentPage];
        
//    });
}
#pragma mark - 加载
- (void)footerUpdate
{
    _currentPage = _currentPage + 1;
    [self requestData:_currentPage];
}

#pragma mark - 网络请求
- (void)requestData:(int)page
{
    long UserId = -1;
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
        UserId = [[[ZMAdminUserStatusModel shareAdminUserStatusModel]adminuserBaseInfo] userId];
    }
    else
    {
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    }
    [[ZMServerAPIs shareZMServerAPIs]requestPaymentRecordsListByUserId:UserId page:page rowCount:ROWNUMS loanPhaseStatus:_backMoneyStyle Success:^(id response) {
        if(page==1)
        {
            if(_dataSource.count>0)
            {
                [_dataSource removeAllObjects];
            }
        }
        NSDictionary *json = (NSDictionary *)response;
        NSArray *arrList = json[@"datas"];
        for(NSDictionary *dict in arrList)
        {
            BackCashModel *model = [[BackCashModel alloc]initModelDictiony:dict];
            if(model!=nil)
            {
                [_dataSource addObject:model];
            }
        }
        if(_dataSource.count>0)
        {
            if(self.tableView.hidden == YES)
            {
                self.tableView.hidden = NO;
            }
        }
        else
        {
            if(self.tableView.hidden == NO)
            {
                self.tableView.hidden = YES;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        });
       
        
    } failure:^(id response) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}
#pragma mark - 选择器
- (IBAction)selectCardAction:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex==0)
    {
        _backMoneyStyle = @"UNPAID";
    }
    else
    {
        _backMoneyStyle = @"SUCCESS";
    }
     [self.tableView.header beginRefreshing];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataSource.count>0)
    {
        return _dataSource.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identy = @"BackCashCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BackCashCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BackCashCell *backCell = (BackCashCell *)cell;
    backCell.model = _dataSource[indexPath.row];
    return backCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96*_appdelegate.autoSizeScaleY;
}
@end
