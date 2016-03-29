//
//  InvestRecoderViewController.m
//  ZiMaCaiHang
//
//  Created by zhangyy on 15/6/26.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "InvestRecoderViewController.h"
#import "InvestRecoderModel.h"
#import "InvestRecoserCell.h"
//#import "GYLProductDetailViewController.h"
//#import "ZDBProductDetailViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "MineCenterViewController.h"
#import "tzxyViewController.h"
#define PAGESIZE 1
#define ROWNUMS 20
//投资记录的状态--还款中
#define UNPAID  @"UNPAID"
#define SUCCESS @"SUCCESS"
@interface InvestRecoderViewController ()<UITableViewDataSource,UITableViewDelegate>
//  数据源
@property (strong ,nonatomic)NSMutableArray *dataSource;
//  标的状态，目前没有使用
@property (strong ,nonatomic)NSString       *loanStatus;
//  投资记录的状态（还款中，已还清）
@property (strong ,nonatomic)NSString       *payStatus;
//  数据的状态，如果没数据就显示
@property (weak   ,nonatomic) IBOutlet UILabel              *recoderState;
//  tableView
@property (weak   ,nonatomic) IBOutlet UITableView          *tableView;
//  存分段器的View
@property (weak   ,nonatomic) IBOutlet UIView               *headBackView;
//  分段器
@property (weak   ,nonatomic) IBOutlet UISegmentedControl   *segmentBtn;
@end
@implementation InvestRecoderViewController
{
    NSInteger _selectIndex;   //   选择的标记
    int _pageIndex;           //   页数
    AppDelegate *_appdelegate;//   代理
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.segmentBtn addTarget:self action:@selector(segmentSelectClick:) forControlEvents:UIControlEventValueChanged];
    self.title = @"投资记录";
    [AppDelegate storyBoradAutoLay:self.view];
    self.navigationItem.leftBarButtonItem =  [ZMTools item:@"DetailBackButton" target:self select:@selector(backVC)];
    //    [self.tableView addHeaderWithTarget:self action:@selector(headUpdate)];
    //    [self.tableView addFooterWithTarget:self action:@selector(footerUpdate)];
    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(headUpdate)];
    
    //上拉加载
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        _pageIndex = _pageIndex + 1;
        [self requestData:_pageIndex];
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
    
    [self initUI];
}
- (void)initUI
{
    _dataSource = [[NSMutableArray alloc]init];
    self.headBackView.frame =  CGRectMake(0, 64, self.headBackView.frame.size.width,self.headBackView.frame.size.height
                                          );
}
#pragma mark - 点击返回按钮的回调
- (void)backVC
{
    if(self.isFromSuccess == YES)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MineCenter" bundle:nil];
        MineCenterViewController *mineVC = [sb instantiateViewControllerWithIdentifier:@"MineCenterViewController"];
        [self.navigationController popToViewController:mineVC animated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self segmentSelectClick:self.segmentBtn];
    [self.tableView.gifHeader beginRefreshing];
}
#pragma mark - 选择器的点击回调方法
- (void)segmentSelectClick:(UISegmentedControl *)sender
{
    _selectIndex = sender.selectedSegmentIndex+1;
    //  还款中
    if(sender.selectedSegmentIndex ==0)
    {
        if(_payStatus!=nil)
        {
            _payStatus = nil;
            _payStatus = UNPAID;
        }
        else
            _payStatus = UNPAID;
    }
    //  已结束
    else if(sender.selectedSegmentIndex ==1)
    {
        if(_payStatus!=nil)
        {
            _payStatus = nil;
            _payStatus = SUCCESS;
        }
        else
            _payStatus = SUCCESS;
        
    }
    [self.tableView.header beginRefreshing];
}
#pragma mark - 头部刷新
- (void)headUpdate
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        _pageIndex = 1;
        [self requestData:_pageIndex];
        
//    });
    
}
#pragma mark - 尾部加载
- (void)footerUpdate
{
    _pageIndex = _pageIndex + 1;
    [self requestData:_pageIndex];
}
#pragma mark - 网络请求
- (void)requestData:(int)page
{
    int UserId = -1;
    if([[ZMAdminUserStatusModel shareAdminUserStatusModel] isLoggedIn]){
        UserId = (int)[[[ZMAdminUserStatusModel shareAdminUserStatusModel]adminuserBaseInfo] userId];
    }
    else
    {
        [[ZMAdminUserStatusModel shareAdminUserStatusModel] popLoginVCWithCurrentViewController:self];
    }
    [[ZMServerAPIs shareZMServerAPIs]getMyProductInvestRecordsByCategoryType:@"ALL" Id:UserId Page:page RowCount:ROWNUMS  loanStatus:nil payStatus:_payStatus Success:^(id response) {
        if(page==1)
        {
            if(_dataSource.count>0)
            {
                [_dataSource removeAllObjects];
            }
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSDictionary *json = (NSDictionary *)response;
        NSArray *arrList = json[@"datas"];
        for(NSDictionary *dict in arrList)
        {
            InvestRecoderModel *model = [[InvestRecoderModel alloc]initModelDictiony:dict];
            if([ZMTools isNullObject:model.productType]==NO)
            {
                [_dataSource addObject:model];
            }
        }
        if(_dataSource.count==0)
        {
            self.recoderState.hidden = NO;
            self.tableView.hidden = YES;
        }
        else
        {
            self.recoderState.hidden = YES;
            self.tableView.hidden = NO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id response) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        self.recoderState.hidden = NO;
        self.tableView.hidden = YES;
    }];
}
#pragma mark - 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataSource.count>0)
        return  _dataSource.count;
    else
        return 0;
}
#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"InvestRecoserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"InvestRecoserCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InvestRecoserCell *INcell = (InvestRecoserCell *)cell;
    InvestRecoderModel *model =_dataSource[indexPath.row];
    INcell.messageBtn.tag = indexPath.row+100;
    [INcell.messageBtn addTarget:self action:@selector(showInvestMessage:) forControlEvents:UIControlEventTouchUpInside];
    if([_payStatus isEqualToString:UNPAID])
    {
        model.imgName = @"还款";
    }
    else if([_payStatus isEqualToString:SUCCESS])
    {
        model.imgName = @"还清";
    }
    INcell.model = model;
    return INcell;
}
#pragma mark - 投资协议
- (void)showInvestMessage:(UIButton *)sender
{
    InvestRecoderModel *model =  _dataSource[sender.tag-100];
    tzxyViewController *investVC = [[tzxyViewController alloc]init];
    investVC.lendTime = model.lendTime;
    investVC.productId =  [NSString stringWithFormat:@"%@",model.loanId];
    [self.navigationController pushViewController:investVC animated:YES];
}
#pragma mark - 返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 * _appdelegate.autoSizeScaleY;
}
#pragma mark - 屏蔽tableView的空余行数
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}

@end
