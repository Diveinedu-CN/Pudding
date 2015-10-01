//
//  DIEAnimeEpisodeViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/10/1.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEAnimeEpisodeViewController.h"
#import "DIENotificationConfig.h"
#import "DIEDataManager.h"
#import "DIEVideoModel.h"
@interface DIEAnimeEpisodeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    DIEEpisodeModel *_episodeModel;
}
@end
@implementation DIEAnimeEpisodeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"player_btn_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popBackClicked:)];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];

    _tableView.dataSource = self;
    _tableView.delegate = self;
    DIEAddObserver(self, @selector(animeEpisodeUpdated:), kDIEAnimeEpisodeUpdateNotif, nil);
    [[DIEDataManager sharedManager] updateAnimeEpisodeWithAnimeId:_animeId andEpisodeId:_episodeId];

}
- (void)animeEpisodeUpdated:(NSNotification *)notification
{
    _episodeModel = notification.object;//偷懒用法
    [_tableView reloadData];
}
- (void)popBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _episodeModel.videos.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    DIEVideoModel *model = _episodeModel.videos[indexPath.row];
    cell.textLabel.text = model.sourceWording;
    return cell;
}


#pragma mark UITableviewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return nil;
    }
    UILabel *sectionHeaderView  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 50)];
    sectionHeaderView.text = [NSString stringWithFormat:@"%@ EP %ld",_episodeModel.animeName, _episodeId];
    sectionHeaderView.textAlignment = NSTextAlignmentCenter;
    sectionHeaderView.font = [UIFont boldSystemFontOfSize:20];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
