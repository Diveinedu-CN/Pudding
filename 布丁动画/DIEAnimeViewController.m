//
//  DIEAnimeViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/10/1.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEAnimeViewController.h"
#import "AnimeTableViewCell.h"
#import "DIEDataManager.h"
#import "UIImageView+WebCache.h"
#import "DIENotificationConfig.h"
#import "DIEAnimeDetailViewController.h"
@interface DIEAnimeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end


@implementation DIEAnimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"player_btn_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popBackClicked:)];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];

    [_tableView registerClass:[AnimeTableViewCell class] forCellReuseIdentifier:@"AnimeTableViewCell"];

    _tableView.dataSource = self;
    _tableView.delegate = self;

    DIEAddObserver(self, @selector(animeUpdated:), kDIEAnimeUpdateNotif, nil);
    [[DIEDataManager sharedManager] updateAnimeWithCategoryId:_categoryId];


}

- (void)popBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)animeUpdated:(id)sender
{
    [_tableView reloadData];
}

#pragma mark UITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DIEDataManager sharedManager].animeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnimeTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"AnimeTableViewCell" forIndexPath:indexPath];
    DIEAnimeModel *model = [DIEDataManager sharedManager].animeArray[indexPath.row];

    [cell.animeImageView sd_setImageWithURL:model.url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = model.name;
    cell.categoryNamesLabel.text = [model.categoryNames componentsJoinedByString:@" / "];
    cell.updatedLabel.text = [NSString stringWithFormat:@"更新至第%ld话",model.onairEpNumber];

    return cell;
}


#pragma mark UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIEAnimeModel *animeModel = [DIEDataManager sharedManager].animeArray[indexPath.row];
    DIEAnimeDetailViewController *detailViewController = [DIEAnimeDetailViewController new];
    detailViewController.animeModel = animeModel;
    detailViewController.title = @"动画详情";
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
