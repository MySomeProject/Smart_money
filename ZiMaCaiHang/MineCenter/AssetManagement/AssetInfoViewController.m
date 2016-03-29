//
//  AssetInfoViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/22.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetInfoViewController.h"

@interface AssetInfoViewController ()

@end

@implementation AssetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self setValueByModel];
    // Do any additional setup after loading the view from its nib.
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
//创建界面
- (void)createView
{
    [self.assetScrollView setDelegate:self];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.assetScrollView setFrame:CGRectMake(0, 0, screenWidth,[UIScreen mainScreen].bounds.size.height)];
    [self relayout];
    [self createChart];
}

//不同机型下布局控件
- (void)relayout
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
    {
        [self.tip6pImageView setFrame:CGRectMake(0, 0, 320, 291)];
        [self.allAssetTitleLabel setFrame:CGRectMake(40, 315, self.allAssetTitleLabel.frame.size.width, self.allAssetTitleLabel.frame.size.height)];
        [self.balanceTitleLabel setFrame:CGRectMake(40, 360, self.balanceTitleLabel.frame.size.width, self.balanceTitleLabel.frame.size.height)];
        [self.freMoneyTitleLabel setFrame:CGRectMake(40, 405, self.freMoneyTitleLabel.frame.size.width, self.freMoneyTitleLabel.frame.size.height)];
        [self.principalTtileLabel setFrame:CGRectMake(40, 450, self.principalTtileLabel.frame.size.width, self.principalTtileLabel.frame.size.height)];
        [self.assetScrollView setContentSize:CGSizeMake(self.assetScrollView.frame.size.width, self.principalTtileLabel.frame.origin.y + self.principalTtileLabel.frame.size.height + 20)];
        [self.allAssetLabel sizeToFit];
        [self.allAssetLabel setFrame:CGRectMake(screenWidth - 45 - self.allAssetLabel.frame.size.width, 315, self.allAssetLabel.frame.size.width, 21)];
        [self.balanceLabel sizeToFit];
        [self.balanceLabel setFrame:CGRectMake(screenWidth - 45 - self.balanceLabel.frame.size.width, 360, self.balanceLabel.frame.size.width, 21)];
        [self.freMoneyLabel sizeToFit];
        [self.freMoneyLabel setFrame:CGRectMake(screenWidth - 45 - self.freMoneyLabel.frame.size.width, 405, self.freMoneyLabel.frame.size.width, 21)];
        [self.principalLabel sizeToFit];
        [self.principalLabel setFrame:CGRectMake(screenWidth - 45 - self.principalLabel.frame.size.width, 450, self.principalLabel.frame.size.width, 21)];
        [self.slideLine1 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.allAssetLabel.frame.origin.y + 32, screenWidth - 85, self.slideLine1.frame.size.height)];
        [self.slideLine2 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.balanceTitleLabel.frame.origin.y + 32, screenWidth - 85, self.slideLine1.frame.size.height)];
        [self.slideLine3 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.freMoneyTitleLabel.frame.origin.y + 32, screenWidth - 85, self.slideLine1.frame.size.height)];
        [self.slideLine4 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.principalTtileLabel.frame.origin.y + 32, screenWidth - 85, self.slideLine1.frame.size.height)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
    {
        [self.tip6pImageView setFrame:CGRectMake(0, 0, 375, 341)];
        [self.allAssetTitleLabel setFrame:CGRectMake(50, 375, self.allAssetTitleLabel.frame.size.width, self.allAssetTitleLabel.frame.size.height)];
        [self.balanceTitleLabel setFrame:CGRectMake(50, 420, self.balanceTitleLabel.frame.size.width, self.balanceTitleLabel.frame.size.height)];
        [self.freMoneyTitleLabel setFrame:CGRectMake(50, 465, self.freMoneyTitleLabel.frame.size.width, self.freMoneyTitleLabel.frame.size.height)];
        [self.principalTtileLabel setFrame:CGRectMake(50, 510, self.principalTtileLabel.frame.size.width, self.principalTtileLabel.frame.size.height)];
        [self.assetScrollView setContentSize:CGSizeMake(self.assetScrollView.frame.size.width, self.principalTtileLabel.frame.origin.y + self.principalTtileLabel.frame.size.height + 20)];
        [self.allAssetLabel sizeToFit];
        [self.allAssetLabel setFrame:CGRectMake(screenWidth - 55 - self.allAssetLabel.frame.size.width, 375, self.allAssetLabel.frame.size.width, 21)];
        [self.balanceLabel sizeToFit];
        [self.balanceLabel setFrame:CGRectMake(screenWidth - 55 - self.balanceLabel.frame.size.width, 420, self.balanceLabel.frame.size.width, 21)];
        [self.freMoneyLabel sizeToFit];
        [self.freMoneyLabel setFrame:CGRectMake(screenWidth - 55 - self.freMoneyLabel.frame.size.width, 465, self.freMoneyLabel.frame.size.width, 21)];
        [self.principalLabel sizeToFit];
        [self.principalLabel setFrame:CGRectMake(screenWidth - 55 - self.principalLabel.frame.size.width, 510, self.principalLabel.frame.size.width, 21)];
        [self.slideLine1 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.allAssetLabel.frame.origin.y + 30, screenWidth - 105, self.slideLine1.frame.size.height)];
        [self.slideLine2 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.balanceTitleLabel.frame.origin.y + 30, screenWidth - 105, self.slideLine1.frame.size.height)];
        [self.slideLine3 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.freMoneyTitleLabel.frame.origin.y + 30, screenWidth - 105, self.slideLine1.frame.size.height)];
        [self.slideLine4 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.principalTtileLabel.frame.origin.y + 30, screenWidth - 105, self.slideLine1.frame.size.height)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
    {
        [self.tip6pImageView setFrame:CGRectMake(0, 0, 414, 376)];
        [self.allAssetTitleLabel setFrame:CGRectMake(55, 400, self.allAssetTitleLabel.frame.size.width, self.allAssetTitleLabel.frame.size.height)];
        [self.balanceTitleLabel setFrame:CGRectMake(55, 465, self.balanceTitleLabel.frame.size.width, self.balanceTitleLabel.frame.size.height)];
        [self.freMoneyTitleLabel setFrame:CGRectMake(55, 530, self.freMoneyTitleLabel.frame.size.width, self.freMoneyTitleLabel.frame.size.height)];
        [self.principalTtileLabel setFrame:CGRectMake(55, 595, self.principalTtileLabel.frame.size.width, self.principalTtileLabel.frame.size.height)];
        [self.assetScrollView setContentSize:CGSizeMake(self.assetScrollView.frame.size.width, self.principalTtileLabel.frame.origin.y + self.principalTtileLabel.frame.size.height + 20)];
        [self.allAssetLabel sizeToFit];
        [self.allAssetLabel setFrame:CGRectMake(screenWidth - 58 - self.allAssetLabel.frame.size.width, 400, self.allAssetLabel.frame.size.width, 21)];
        [self.balanceLabel sizeToFit];
        [self.balanceLabel setFrame:CGRectMake(screenWidth - 58 - self.balanceLabel.frame.size.width, 465, self.balanceLabel.frame.size.width, 21)];
        [self.freMoneyLabel sizeToFit];
        [self.freMoneyLabel setFrame:CGRectMake(screenWidth - 58 - self.freMoneyLabel.frame.size.width, 530, self.freMoneyLabel.frame.size.width, 21)];
        [self.principalLabel sizeToFit];
        [self.principalLabel setFrame:CGRectMake(screenWidth - 58 - self.principalLabel.frame.size.width, 595, self.principalLabel.frame.size.width, 21)];
        [self.slideLine1 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.allAssetLabel.frame.origin.y + 40, screenWidth - 113, self.slideLine1.frame.size.height)];
        [self.slideLine2 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.balanceTitleLabel.frame.origin.y + 40, screenWidth - 113, self.slideLine1.frame.size.height)];
        [self.slideLine3 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.freMoneyTitleLabel.frame.origin.y + 40, screenWidth - 113, self.slideLine1.frame.size.height)];
        [self.slideLine4 setFrame:CGRectMake(self.allAssetTitleLabel.frame.origin.x, self.principalTtileLabel.frame.origin.y + 40, screenWidth - 113, self.slideLine1.frame.size.height)];

    }
}

//创建饼状图
- (void)createChart
{
    self.dataArray = [NSArray arrayWithObjects:@0,@0,@50,nil];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
    {
        self.assetChart = [[XYPieChart alloc] initWithFrame:CGRectMake(screenWidth - 213, 80, 180, 180)];
        self.allAssetTipLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(30, 30, 120, 120)];
        [self.allAssetTipLabel setText:@"￥899.33"];
        [self.allAssetTipLabel setTextColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:125/255.0 alpha:1.0]];
        [self.allAssetTipLabel setBackgroundColor:[UIColor whiteColor]];
        [self.allAssetTipLabel setClipsToBounds:YES];
        [self.allAssetTipLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:self.assetChart];
        [self.assetChart addSubview:self.allAssetTipLabel];
        [self.assetChart setDataSource:self];
        [self.assetChart setDelegate:self];
        [self.assetChart setStartPieAngle:M_PI_2];
        [self.assetChart setAnimationSpeed:1.0];
        [self.assetChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
        [self.assetChart setLabelRadius:180];
        [self.assetChart setShowPercentage:NO];
        [self.assetChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
        [self.assetChart setPieCenter:CGPointMake(90, 90)];
        [self.assetChart setUserInteractionEnabled:NO];
        [self.allAssetTipLabel.layer setCornerRadius:60];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0)
    {
        self.assetChart = [[XYPieChart alloc] initWithFrame:CGRectMake(screenWidth - 243, 100, 210, 210)];
        self.allAssetTipLabel = [[Heiti15Label alloc] initWithFrame:CGRectMake(35, 35, 140, 140)];
        [self.allAssetTipLabel setText:@"￥899.33"];
        [self.allAssetTipLabel setTextColor:[UIColor colorWithRed:237/255.0 green:68/255.0 blue:125/255.0 alpha:1.0]];
        [self.allAssetTipLabel setBackgroundColor:[UIColor whiteColor]];
        [self.allAssetTipLabel setClipsToBounds:YES];
        [self.allAssetTipLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:self.assetChart];
        [self.assetChart addSubview:self.allAssetTipLabel];
        [self.assetChart setDataSource:self];
        [self.assetChart setDelegate:self];
        [self.assetChart setStartPieAngle:M_PI_2];
        [self.assetChart setAnimationSpeed:1.0];
        [self.assetChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
        [self.assetChart setLabelRadius:210];
        [self.assetChart setShowPercentage:NO];
        [self.assetChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
        [self.assetChart setPieCenter:CGPointMake(105, 105)];
        [self.assetChart setUserInteractionEnabled:NO];
        [self.allAssetTipLabel.layer setCornerRadius:70];
    }
    [self.assetScrollView addSubview:self.assetChart];
    [self.assetChart reloadData];
}

//根据数据设置控件显示内容
- (void)setValueByModel
{
    _dataModel = [ZMAdminUserStatusModel shareAdminUserStatusModel];
    if (_dataModel.adminUserAssert.userPointVO)
    {
        self.allAssetLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"amount"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"amount"]];
        self.allAssetLabel.text = [ZMTools moneyStandardFormatByString:self.allAssetLabel.text withDollarSign:@"￥"];
        self.balanceLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"availablePoints"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"availablePoints"]];
        self.balanceLabel.text = [ZMTools moneyStandardFormatByString:self.balanceLabel.text withDollarSign:@"￥"];
        self.freMoneyLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"frozenPoints"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"frozenPoints"]];
        self.freMoneyLabel.text = [ZMTools moneyStandardFormatByString:self.freMoneyLabel.text withDollarSign:@"￥"];
        self.principalLabel.text = [NSString stringWithFormat:@"￥%@",[ZMAdminUserStatusModel isNullObject:[_dataModel.adminUserAssert.userPointVO valueForKey:@"waittingPrincipal"]]?@"0.00":[_dataModel.adminUserAssert.userPointVO valueForKey:@"waittingPrincipal"]];
        self.principalLabel.text = [ZMTools moneyStandardFormatByString:self.principalLabel.text withDollarSign:@"￥"];
        NSNumber *availablePoints = [_dataModel.adminUserAssert.userPointVO valueForKey:@"availablePoints"];
        NSNumber *frozenPoints = [_dataModel.adminUserAssert.userPointVO valueForKey:@"frozenPoints"];
        NSNumber *waittingPrincipal = [_dataModel.adminUserAssert.userPointVO valueForKey:@"waittingPrincipal"];
        if (![ZMAdminUserStatusModel isNullObject:availablePoints]&&![ZMAdminUserStatusModel isNullObject:frozenPoints]&&![ZMAdminUserStatusModel isNullObject:waittingPrincipal])
        {
            self.dataArray = [NSArray arrayWithObjects:availablePoints,frozenPoints,waittingPrincipal,nil];
            [self.assetChart reloadData];
            self.allAssetTipLabel.text = self.allAssetLabel.text;
        }
        [self relayoutLabel];
    }
}

//重新布局各控件
- (void)relayoutLabel
{
    CGRect newFrame = self.allAssetLabel.frame;
    CGFloat oldWidth = newFrame.size.width;
    [self.allAssetLabel sizeToFit];
    newFrame.size.width = self.allAssetLabel.frame.size.width;
    newFrame.origin.x = newFrame.origin.x + oldWidth - newFrame.size.width;
    [self.allAssetLabel setFrame:newFrame];
    newFrame = self.balanceLabel.frame;
    oldWidth = newFrame.size.width;
    [self.balanceLabel sizeToFit];
    newFrame.size.width = self.balanceLabel.frame.size.width;
    newFrame.origin.x = newFrame.origin.x + oldWidth - newFrame.size.width;
    [self.balanceLabel setFrame:newFrame];
    newFrame = self.freMoneyLabel.frame;
    oldWidth = newFrame.size.width;
    [self.freMoneyLabel sizeToFit];
    newFrame.size.width = self.freMoneyLabel.frame.size.width;
    newFrame.origin.x = newFrame.origin.x + oldWidth - newFrame.size.width;
    [self.freMoneyLabel setFrame:newFrame];
    newFrame = self.principalLabel.frame;
    oldWidth = newFrame.size.width;
    [self.principalLabel sizeToFit];
    newFrame.size.width = self.principalLabel.frame.size.width;
    newFrame.origin.x = newFrame.origin.x + oldWidth - newFrame.size.width;
    [self.principalLabel setFrame:newFrame];
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
        return [UIColor colorWithRed:107/255.0 green:205/255.0 blue:224/255.0 alpha:1.0];
    }
    else if (index == 1)
    {
        return [UIColor colorWithRed:248/255.0 green:189/255.0 blue:106/255.0 alpha:1.0];
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
