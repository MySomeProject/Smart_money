//
//  AssetDisTableViewController.m
//  ZiMaCaiHang
//
//  Created by 陈柳充 on 15/4/23.
//  Copyright (c) 2015年 zimacaihang. All rights reserved.
//

#import "AssetDisTableViewController.h"

@interface AssetDisTableViewController ()
{
    NSString *reuseCellIndentifier;
}
@end

@implementation AssetDisTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    if(Ratio_OF_WIDTH_FOR_IPHONE6 > 1.0 && Ratio_OF_WIDTH_FOR_IPHONE6 < 1.2)
    {
        reuseCellIndentifier = @"AssetDisTableViewCell6";
        UINib *nib = [UINib nibWithNibName:@"AssetDisTableViewCell6" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else if (Ratio_OF_WIDTH_FOR_IPHONE6 > 1.2)
    {
        reuseCellIndentifier = @"AssetDisTableViewCell6Plus";
        UINib *nib = [UINib nibWithNibName:@"AssetDisTableViewCell6Plus" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
    else
    {
        reuseCellIndentifier = @"AssetDisTableViewCell";
        UINib *nib = [UINib nibWithNibName:@"AssetDisTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:reuseCellIndentifier];
    }
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
    AssetDisTableViewCell *cell = (AssetDisTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseCellIndentifier];
    if (cell == nil)
    {
        cell = [[AssetDisTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
        return 568;
    }
    return 0;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
