//
//  HXChangJianQuestion.m
//  miXin
//
//  Created by HAIXUN on 14-5-22.
//  Copyright (c) 2014年 HAIXUN. All rights reserved.
//

#import "HXChangJianQuestion.h"
#import "UIViewExt.h"
//#import "HXCenterQuestionTableViewCell.h"
#import "HXQuestionTableViewCell.h"
#import "MessageViewController.h"

#define kAnswer @"answer"
#define kQuestion @"question"


@interface HXChangJianQuestion ()
{
}
@property(strong,nonatomic) NSMutableArray *allDataArray;
@end

@implementation HXChangJianQuestion

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allDataArray = [NSMutableArray array];
    self.isNeedLoad = NO;
    self.isLoading = NO;
    self.noDataCanLoad = NO;
    [self setupSettingButton];
    self.navigationItem.title = @"消息中心";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_settingButton];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 10)];
    [tableHeader setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = tableHeader;
    [self getMessageList:1];
}

//获取消息列表
- (void)getMessageList:(NSInteger)pageIndex
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.delegate = self;
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.animationType = MBProgressHUDAnimationFade;
    [progressHUD setLabelText:@"数据加载中..."];
    
    [[ZMServerAPIs shareZMServerAPIs] getMessageListWithPageIndex:pageIndex Success:^(id response){
        NSDictionary *dataDic = [response valueForKey:@"data"];
        NSArray *array = [dataDic valueForKey:@"messages"];
        NSMutableArray *convertArray = [NSMutableArray array];
        for (int i = 0; i < [array count]; i++)
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
            [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
            [convertArray addObject:dic];
        }
        if ([ZMAdminUserStatusModel isNullObject:convertArray]||[convertArray count] < 10)
        {
            //服务器最后一批数据
            if ([convertArray count] > 0 && !self.noDataCanLoad)
            {
                [self.allDataArray addObjectsFromArray:convertArray];
            }
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.tableView reloadData];
                progressHUD.tag = 2001;
                [progressHUD hide:YES afterDelay:0];
            });
            self.noDataCanLoad = YES;
            self.isNeedLoad = NO;
            self.isLoading = false;
        }
        else
        {
            [self.allDataArray addObjectsFromArray:convertArray];
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.tableView reloadData];
                progressHUD.tag = 2001;
                [progressHUD hide:YES afterDelay:0];
            });
            self.isNeedLoad = NO;
            self.isLoading = false;
        }
        if ([self.allDataArray count] == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无可阅读消息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
                [alter show];
            });
        }
    }
    failure:^(id response){
        CLog(@"%@",response);
        self.isNeedLoad = NO;
        self.isLoading = false;
        dispatch_async(dispatch_get_main_queue(), ^(){
            progressHUD.tag = 2001;
            [progressHUD setLabelText:@"无可阅读消息"];
            [progressHUD hide:YES afterDelay:1.5];
        });
    }];
}

- (UIButton *)setupSettingButton{
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingButton setBackgroundColor:[UIColor clearColor]];
    _settingButton.frame = CGRectMake(0, 0, 44, 44);
    [_settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [_settingButton addTarget:self action:@selector(settingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return _settingButton;
}

//打开消息设置界面
- (void)settingButtonPressed:(UIButton *)sender
{
    MessageViewController *next = [[MessageViewController alloc]init];
    next.title = @"消息设置";
    [self.navigationController pushViewController:next animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index = @"abcder";
    
    CLog(@"WIDTH_OF_SCREEN === %f, self.width = %f", WIDTH_OF_SCREEN, self.view.width);
    
    
    HXQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell=[[HXQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
        
    }
//    questions *dict = self.allDataArray[indexPath.row];
//    cell.curentQuestion = dict;
//    cell.questionLabel.text = dict.messageTitle;
//    cell.timeLabel.text = dict.messageTime;
//    cell.descriptionLabel.text = dict.messageDescription;
//    cell.answerLabel.text = dict.messageContent;
//    cell.isReadedLabel.text = dict.isReaded;
    cell.dataDic = self.allDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if (dict.isSelect) {
//        cell.questionLabel.textColor = COLOR_BLACK_FOR_TEXT;
//
//    }
//    else{
//        cell.questionLabel.textColor=[UIColor grayColor];
//
//    }
//    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *data = self.allDataArray[indexPath.row];
    if ([[data valueForKey:@"read"] integerValue] == 0)
    {
        [data setObject:[NSNumber numberWithBool:YES] forKey:@"read"];
        //设置消息已读
        NSInteger msgId = [[data valueForKey:@"id"] integerValue];
        [[ZMServerAPIs shareZMServerAPIs] setReadedMessageWithMsgId:msgId Success:^(id response)
        {
            CLog(@"%@",response);
            dispatch_async(dispatch_get_main_queue(), ^(){
                HXQuestionTableViewCell *cell = (HXQuestionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                cell.isReadedLabel.text = @"已读";
                [cell.questionLabel setTextColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0]];
                [cell.isReadedLabel setTextColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0]];
            });
        }
        failure:^(id response)
        {
            CLog(@"failed");
        }];
    }
    if ([[data valueForKey:@"isSelected"] boolValue])
    {
        [data setValue:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
    }
    else
    {
        [data setValue:[NSNumber numberWithBool:YES] forKey:@"isSelected"];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *data = self.allDataArray[indexPath.row];
    if (![[data valueForKey:@"isSelected"] boolValue])
    {
        return 100;
    }
    else
    {
        CGFloat textHeight = [self contentCellHeightWithText:[self.allDataArray[indexPath.row] valueForKey:@"content"]];
        [data setObject:[NSNumber numberWithFloat:textHeight] forKey:@"messageContentHeight"];
        return 100 + textHeight;
    }
}

//根据文本获取控件高度
- (CGFloat)contentCellHeightWithText:(NSString*)text
{
    
    NSInteger ch;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    //设置字体
    
    CGSize size = CGSizeMake(WIDTH_OF_SCREEN-40, 20000.0f);
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size
                             options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                          attributes:tdic context:nil].size;
    ch = ceilf(size.height);
    
    CLog(@"self.width === %f, height === %f, ch %ld", size.width, size.height, ch);
    
    return ch;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = +20;
    if(y > h + reload_distance) {
        //超过底部 20 像素，设置为需要加载数据
        self.isNeedLoad = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.noDataCanLoad)
    {//没有可下载数据
        return;
    }
    if (!self.isLoading)
    {
        if (self.isNeedLoad)
        {
            NSInteger loadPages = 0;
            //加载新数据
            if ([self.allDataArray count]< 10)
            {
                loadPages = 0;
            }
            else
            {
                loadPages = [self.allDataArray count]/10;
            }
            self.isLoading = YES;
            [self getMessageList:loadPages];
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



@implementation questions



@end