//
//  MessageViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

@interface MessageViewController ()
{
    NSString *reuseCellIndentifier;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
    {
        reuseCellIndentifier = @"MessageTableViewCell6";
        UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell6" bundle:nil];
        [self.messageTabelView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        reuseCellIndentifier = @"MessageTableViewCell6Plus";
        UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell6Plus" bundle:nil];
        [self.messageTabelView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else
    {
        reuseCellIndentifier = @"MessageTableViewCell";
        UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
        [self.messageTabelView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    [self.messageTabelView setDelegate:self];
    [self.messageTabelView setDataSource:self];
    [self relayout];
    [self getMessageSettings];
    // Do any additional setup after loading the view from its nib.
}

//获取消息设置
- (void)getMessageSettings
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"数据加载中..."];

    [[ZMServerAPIs shareZMServerAPIs] getMessageSettingsSuccess:^(id response)
    {
        CLog(@"%@",response);
        self.dataDic = [response valueForKey:@"data"];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.messageTabelView reloadData];
            progressHUD.tag = 2001;
            [progressHUD hide:YES afterDelay:0];
        });
    }
    failure:^(id response)
     {
         CLog(@"%@",response);
         dispatch_async(dispatch_get_main_queue(), ^(){
             [self.messageTabelView reloadData];
             progressHUD.tag = 2001;
             [progressHUD hide:YES afterDelay:0];
         });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//不同机型布局
- (void)relayout
{
    if( Ratio_OF_WIDTH_FOR_IPHONE6 == 1.0) //iPhone4s 5s
    {
        [self.messageHeaderView setFrame:CGRectMake(0, 64, 320, 38)];
        [self.messageTabelView setFrame:CGRectMake(0, 102, 320, 530)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)//iPhone6（6 plus真机器）
    {
        [self.messageHeaderView setFrame:CGRectMake(0, 64, 375, 45)];
        [self.messageTabelView setFrame:CGRectMake(0, 109, 375, 622)];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2) //iPhone6 Plus
    {
        [self.messageHeaderView setFrame:CGRectMake(0, 64, 414, 49)];
        [self.messageTabelView setFrame:CGRectMake(0, 113, 414, 687)];
    }
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = (MessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier];
    if (cell == nil)
    {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIndentifier];
    }
    cell.dataDic = self.dataDic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
        return 568;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)dealloc
{
    CLog(@"message dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
