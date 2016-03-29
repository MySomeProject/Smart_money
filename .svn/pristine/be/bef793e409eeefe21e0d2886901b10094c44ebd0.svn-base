//
//  rizibaoTableViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/27.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "RizibaoTableViewController.h"
#import "RizibaoTableViewCell.h"

@interface RizibaoTableViewController ()<UIScrollViewDelegate,RizibaoTableViewCellDelegate>
{
    NSString *reuseCellIndentifier;
    UITextField *moneyTextField;
}
@end

@implementation RizibaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =  [ZMTools item:@"DetailBackButton" target:self select:@selector(backVC)];
//    [self.tableView setScrollEnabled:NO];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
    {
        reuseCellIndentifier = @"RizibaoTableViewCell6";
        UINib *nib = [UINib nibWithNibName:@"RizibaoTableViewCell6" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        reuseCellIndentifier = @"RizibaoTableViewCellPlus6";
        UINib *nib = [UINib nibWithNibName:@"RizibaoTableViewCellPlus6" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else
    {
        reuseCellIndentifier = @"RizibaoTableViewCell";
        UINib *nib = [UINib nibWithNibName:@"RizibaoTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureToHideInputBoard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)backVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RizibaoTableViewCell *cell = (RizibaoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier];
    cell.delegate = self;
    if (cell == nil)
    {
        cell = [[RizibaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIndentifier];
        
    }
    
    moneyTextField = cell.moneyTextField;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        return  20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
    {
        return 667;
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        return 736;
    }
    else
    {
        return 480;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//点击return时触发的事件
- (IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}



#pragma mark  --------------------------- UIScrollView Delegate ------------------------------
//上下滑动scroll 用于隐藏输入法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [moneyTextField resignFirstResponder];
}
-(void)tapGestureToHideInputBoard
{
    [moneyTextField resignFirstResponder];
}

- (void)backToVC
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
