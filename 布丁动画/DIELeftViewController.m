//
//  DIELeftViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/9/21.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIELeftViewController.h"
#import "LeftTableViewCell.h"
#import "LeftUserInfoView.h"
#import "Masonry.h"
@interface DIELeftViewController () <UITableViewDataSource,UITableViewDelegate>

{
    NSArray *_leftImageArray;
    NSArray *_leftTitleArray;
}
@end


@implementation DIELeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //init datasource
    _leftImageArray = @[@"side_menu_icon_history",@"side_menu_icon_cache",@"side_menu_icon_statistics",@"side_menu_icon_promotor"];
    _leftTitleArray = @[@"追番纪录",@"离线缓存",@"布丁统计",@"布丁娘送周边"];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"side_menu_bg.jpg"]];
    
    //headview
    LeftUserInfoView *headView = [[LeftUserInfoView alloc]initWithFrame:CGRectMake(0, 0, 320,240)];

    headView.avatarImage = [UIImage imageNamed:@"default_avatar"];
    headView.followerCount = 11;
    headView.fansCount = 22;
    headView.isLogin = YES;
    [headView addAvatarTarget:self action:@selector(userInfoAvatarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView addFollowerTarget:self action:@selector(userInfoFollowerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView addFansTarget:self action:@selector(userInfoFansClicked:) forControlEvents:UIControlEventTouchUpInside];

    tableView.tableHeaderView = headView;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableFooterView = footView;
    
    //datasource, delegate
    [tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:@"leftCell"];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
    
    //setting button
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"side_menu_icon_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view).offset(20);
        make.size.equalTo(MASBoxValue(CGSizeMake(80, 40)));
    }];

    
    //notification button
    UIButton *notificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [notificationButton setTitle:@"通知" forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"side_menu_icon_notification"] forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(notificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notificationButton];
    [notificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(settingButton);
        make.size.equalTo(settingButton);

    }];
}


#pragma mark  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_leftTitleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
    cell.titleLabel.text = _leftTitleArray[indexPath.row];
    UIImage *img = [UIImage imageNamed:_leftImageArray[indexPath.row]];
    cell.iconImageView.image = img;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark userinfo target action
- (void)userInfoAvatarClicked:(id)sender
{
    NSLog(@"侧边栏头像被点击");
}

- (void)userInfoFollowerClicked:(id)sender
{
    NSLog(@"侧边栏关注被点击");
}

- (void)userInfoFansClicked:(id)sender
{
    NSLog(@"侧边栏粉丝被点击");
}
- (void)settingButtonClicked:(id)sender
{
    NSLog(@"侧边栏设置被点击");
}
- (void)notificationButtonClicked:(id)sender
{
    NSLog(@"侧边栏通知被点击");
}
@end
