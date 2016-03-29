//
//  IncomeViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "IncomeViewController.h"

@interface IncomeViewController ()

@end

@implementation IncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createChart];
    [self setValueByModel];
    [self.incomeScrollView setFrame:CGRectMake(0, 0, self.incomeScrollView.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.incomeScrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,self.bottomView.frame.origin.y + 20)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)createChart
{
    self.dataSource = [[PieChartDataSource alloc] init];
    [self.incomeChart setDataSource:self];
    [self.incomeChart setDelegate:self];
    [self.incomeChart setStartPieAngle:M_PI_2];
    [self.incomeChart setAnimationSpeed:1.0];
    [self.incomeChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.incomeChart setLabelRadius:self.incomeChart.frame.size.width];
    [self.incomeChart setShowPercentage:NO];
    [self.incomeChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.incomeChart setPieCenter:CGPointMake(self.incomeChart.frame.size.width/2, self.incomeChart.frame.size.width/2)];
    [self.incomeChart setUserInteractionEnabled:NO];
    [self.pieLabel.layer setCornerRadius:self.incomeChart.frame.size.width/3];
    [self.incomeChart reloadData];
    [self.incomChartOne setDataSource:self.dataSource];
    [self.incomChartOne setDelegate:self];
    [self.incomChartOne setStartPieAngle:M_PI_2];
    [self.incomChartOne setAnimationSpeed:1.0];
    [self.incomChartOne setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.incomChartOne setLabelRadius:self.incomChartOne.frame.size.width];
    [self.incomChartOne setShowPercentage:NO];
    [self.incomChartOne setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.incomChartOne setPieCenter:CGPointMake(self.incomChartOne.frame.size.width/2, self.incomChartOne.frame.size.width/2)];
    [self.incomChartOne setUserInteractionEnabled:NO];
    [self.pieLabelOne.layer setCornerRadius:self.incomChartOne.frame.size.width/3];
    [self.incomChartOne reloadData];
    self.incomChartOne.tag = 1;
}

- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userProfitVo)
    {
        _shouyiTotalLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalAlreadyProfit"]]?@"0.00":[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalAlreadyProfit"]];
        self.pieLabel.text = [ZMTools moneyStandardFormatByString:_shouyiTotalLabel.text withDollarSign:@"￥"];
        _dsTotalLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalWaitingProfit"]]?@"0.00":[_dataModel.adminUserAssert.userProfitVo valueForKey:@"totalWaitingProfit"]];
        self.pieLabelOne.text = [ZMTools moneyStandardFormatByString:_dsTotalLabel.text withDollarSign:@"￥"];
        NSArray *alreadyProfitsArray = [_dataModel.adminUserAssert.userProfitVo valueForKey:@"alreadyProfits"];
        NSArray *waittingProfitsArray = [_dataModel.adminUserAssert.userProfitVo valueForKey:@"waittingProfits"];
        __block NSNumber *zidingyingSyNumber;
        __block NSNumber *zidaibaoSyNumber;
        __block NSNumber *zidingyingDsNumber;
        __block NSNumber *zidaibaoDsNumber;
        __block NSNumber *rizibaoSyNumber;
        [alreadyProfitsArray enumerateObjectsUsingBlock:^(NSDictionary *dic,NSUInteger index, BOOL* te){
            if ([[dic valueForKey:@"displayProductName"] isEqualToString:@"紫定盈"])
            {
                _zidingyingSyLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[dic valueForKey:@"amount"]]?@"0.00":[dic valueForKey:@"amount"]];
                zidingyingSyNumber = [dic valueForKey:@"amount"];
                _zidingyingSyLabel.text = [ZMTools moneyStandardFormatByString:_zidingyingSyLabel.text withDollarSign:@"￥"];
            }
            else if ([[dic valueForKey:@"displayProductName"] isEqualToString:@"紫贷宝"])
            {
                _zidaibaoSyLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[dic valueForKey:@"amount"]]?@"0.00":[dic valueForKey:@"amount"]];
                zidaibaoSyNumber = [dic valueForKey:@"amount"];
                _zidaibaoSyLabel.text = [ZMTools moneyStandardFormatByString:_zidaibaoSyLabel.text withDollarSign:@"￥"];

            }
            else
            {
                _rizibaoSyLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[dic valueForKey:@"amount"]]?@"0.00":[dic valueForKey:@"amount"]];
                rizibaoSyNumber = [dic valueForKey:@"amount"];
                _rizibaoSyLabel.text = [ZMTools moneyStandardFormatByString:_rizibaoSyLabel.text withDollarSign:@"￥"];
            }
        }];
        [waittingProfitsArray enumerateObjectsUsingBlock:^(NSDictionary *dic,NSUInteger index, BOOL* te){
            if ([[dic valueForKey:@"displayProductName"] isEqualToString:@"紫定盈"])
            {
                _zidingyingDsLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[dic valueForKey:@"amount"]]?@"0.00":[dic valueForKey:@"amount"]];
                zidingyingDsNumber = [dic valueForKey:@"amount"];
                _zidingyingDsLabel.text = [ZMTools moneyStandardFormatByString:_zidingyingDsLabel.text withDollarSign:@"￥"];

            }
            else if ([[dic valueForKey:@"displayProductName"] isEqualToString:@"紫贷宝"])
            {
                _zidaibaoDsLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[dic valueForKey:@"amount"]]?@"0.00":[dic valueForKey:@"amount"]];
                zidaibaoDsNumber = [dic valueForKey:@"amount"];
                _zidaibaoDsLabel.text = [ZMTools moneyStandardFormatByString:_zidaibaoDsLabel.text withDollarSign:@"￥"];

            }
        }];
        self.dataArray = [NSArray arrayWithObjects:zidingyingSyNumber,rizibaoSyNumber,zidaibaoSyNumber,nil];
        self.dataSource.dataArray = [NSArray arrayWithObjects:zidingyingDsNumber,zidaibaoDsNumber,nil];
        [self.incomeChart reloadData];
        [self.incomChartOne reloadData];
        //        NSArray *productArray = [_dataModel.adminUserAssert.userInvestVO valueForKey:@"invsetAmouts"];
//        NSNumber *rizibaoNumber;
//        NSNumber *zidingyingNumber;
//        NSNumber *zidaibaoNumber;
//        for (int i = 0; i < [productArray count]; i++)
//        {
//            NSLog(@"");
//            if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"RIZIBAO"])
//            {
//                //日紫宝
//                _rizibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
//                rizibaoNumber = [productArray[i] valueForKey:@"amount"];
//            }
//            else if ([[productArray[i]  valueForKey:@"productName"] isEqualToString:@"INVEST_PRODUCT"])
//            {
//                //紫定盈
//                _zidingyingLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
//                zidingyingNumber = [productArray[i] valueForKey:@"amount"];
//            }
//            else
//            {
//                //紫贷宝
//                _zidaibaoLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[productArray[i] valueForKey:@"amount"]]?@"0.00":[productArray[i] valueForKey:@"amount"]];
//                zidaibaoNumber = [productArray[i] valueForKey:@"amount"];
//            }
//        }
//        if (![ZMAdminUserStatusModel isNullObject:rizibaoNumber]&&![ZMAdminUserStatusModel isNullObject:zidingyingNumber]&&![ZMAdminUserStatusModel isNullObject:zidaibaoNumber])
//        {
//            self.dataArray = [NSArray arrayWithObjects:rizibaoNumber,zidingyingNumber,zidaibaoNumber,nil];
//            [self.assetDisChart reloadData];
//            self.chartLabel.text = self.investmentLabel.text;
//        }
//        
    }
}

#pragma mark - AssetChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [self.dataArray count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [self.dataArray[index] doubleValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if (index == 0)
    {
        return [UIColor colorWithRed:248/255.0 green:189/255.0 blue:106/255.0 alpha:1.0];
    }
    else if (index == 1)
    {
        return [UIColor colorWithRed:107/255.0 green:205/255.0 blue:224/255.0 alpha:1.0];
    }
    else
    {
        return [UIColor colorWithRed:245/255.0 green:90/255.0 blue:94/255.0 alpha:1.0];
    }
}

#pragma mark - AssetChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    CLog(@"click chart");
}
@end
