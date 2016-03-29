//
//  mapNaviViewController.m
//  SOUNDBOOK
//
//  Created by zima on 15-2-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "mapNaviViewController.h"


@interface mapNaviViewController ()<MapViewControllerDelegate>

@end

@implementation mapNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setImage:[UIImage imageNamed:@"playlistEntry.png"] forState:UIControlStateNormal];
//    [cancelButton setImage:[UIImage imageNamed:@"playlistEntry.png"] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0, 0, 44, 44);
//    [cancelButton setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 0)];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *mapNaviButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [mapNaviButton setImage:[UIImage imageNamed:@"messages.png"] forState:UIControlStateNormal];
    [mapNaviButton setTitle:@"启动导航" forState:UIControlStateNormal];
    mapNaviButton.frame = CGRectMake(0, 0, 44+44, 44);
//    [mapNaviButton setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 0)];
    [mapNaviButton setBackgroundColor:[UIColor clearColor]];
    [mapNaviButton addTarget:self action:@selector(mapNaviButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:mapNaviButton];
    
    
//    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [messageButton setImage:[UIImage imageNamed:@"playlistEntry.png"] forState:UIControlStateNormal];
//    [messageButton setImage:[UIImage imageNamed:@"playlistEntry.png"] forState:UIControlStateHighlighted];
//    messageButton.frame = CGRectMake(0, 0, 44, 44);
//    [messageButton setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 0)];
//    [messageButton setBackgroundColor:[UIColor clearColor]];
//    [messageButton addTarget:self action:@selector(rightNaviButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonAction:(UIButton *)cancelButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)mapNaviButtonAction:(UIButton *)naviButton
{
    CLog(@"启动高德导航等等。");
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                @"中国上海市陆家嘴延安东路",@"address",
                                @"上海市",@"city",
                                @"google",@"from_map_type",
                                @"31.23733484",@"google_lat",
                                @"121.50142656",@"google_lng",
                                @"浦东新区",@"region", nil];
    
    
    MapViewController *mv = [[MapViewController alloc] init];
    mv.navDic = dic;
    mv.mapType = RegionNavi;
    [self.navigationController pushViewController:mv animated:YES];
    
    
    
//    MapViewController *mv = [[MapViewController alloc] init];
//    mv.siteDelegate = self;
//    [mv setHidesBottomBarWhenPushed:YES];
//    mv.mapType = RegionChoose;
//    [self.navigationController pushViewController:mv animated:YES];
}


-(void)loadMapSiteMessage:(NSDictionary *)mapSiteDic{
    
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
