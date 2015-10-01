//
//  DIEAnimeDetailViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/10/1.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEAnimeDetailViewController.h"
#import "DIEAnimeEpisodeViewController.h"
#import "DIEDataManager.h"
@interface DIEAnimeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation DIEAnimeDetailViewController
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
    return _animeModel.onairEpNumber;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 第%li话", _animeModel.name, indexPath.row+1];
    return cell;
}


#pragma mark UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DIEAnimeEpisodeViewController *episodeViewcontroller = [DIEAnimeEpisodeViewController new];
    episodeViewcontroller.animeId = _animeModel.animeId;
    episodeViewcontroller.episodeId = indexPath.row + 1;
    episodeViewcontroller.title = [NSString stringWithFormat:@"第%ld话", indexPath.row + 1];
    [self.navigationController pushViewController:episodeViewcontroller animated:YES];
}

@end
