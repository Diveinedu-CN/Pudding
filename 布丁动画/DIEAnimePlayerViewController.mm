//
//  DIEAnimePlayerViewController.m
//  布丁动画
//
//  Created by Cheetah on 15/10/2.
//  Copyright © 2015年 diveinedu. All rights reserved.
//
#import <MobileVLCKit/MobileVLCKit.h>
#import "DIEAnimePlayerViewController.h"
#import "Masonry.h"
#import "DIEDataManager.h"
#import "DIENotificationConfig.h"
@interface DIEAnimePlayerViewController ()<VLCMediaPlayerDelegate>
{
    VLCMediaListPlayer *_vlcMediaListPlayer;
    UIView *_vlcVideoView;
    UIView *_controlsView;
    UILabel *_titleLabel;
    UIButton *_playButton;
    UILabel *_timeLabel;
    UIProgressView *_videoLoadProgressView;
    UISlider *_videoSlider;

    //
    DIEVideoInfoModel *_videoInfoModel;
    CGFloat _totalDuration;
    CGFloat _currentDuration;
}
@end

@implementation DIEAnimePlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self vlcPlayer];
    [self createControls];
    self.view.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.3];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTaped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    DIEAddObserver(self, @selector(videoInfoUpdated:), kDIEVideoInfoUpdateNotif, nil);
    [self loadVideoInfoWithQuality:DIEQualityTypeHighDefinition];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //自动向左横屏
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)vlcPlayer
{
    _vlcVideoView = [UIView new];
    [self.view addSubview:_vlcVideoView];
    [self.view sendSubviewToBack:_vlcVideoView];
    [_vlcVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];

    _vlcMediaListPlayer = [[VLCMediaListPlayer alloc]init];
    _vlcMediaListPlayer.mediaPlayer.delegate = self;
    _vlcMediaListPlayer.mediaPlayer.drawable = _vlcVideoView;
    [_vlcMediaListPlayer.mediaPlayer.libraryInstance setHumanReadableName:@"Safari" withHTTPUserAgent:@"Mozilla/5.0"];

}

- (void)createControls
{
    _controlsView = [UIView new];
    [self.view addSubview:_controlsView];
    [_controlsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];

    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"player_btn_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_controlsView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@20);
        make.size.equalTo(MASBoxValue(CGSizeMake(44, 44)));
    }];
    //标题标签
    _titleLabel = [UILabel new];
    _titleLabel.text = [NSString stringWithFormat:@"%@ 第 %d 话\n%@",_videoTitle,0,@"URL"];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.numberOfLines = 0;
    [_controlsView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right).offset(10);
        make.top.equalTo(_controlsView).offset(0);
        make.right.equalTo(_controlsView).offset(-40);
        make.height.equalTo(@80);
    }];


    //播放暂停按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [_controlsView addSubview:_playButton];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.bottom.equalTo(@(-10));
        make.size.equalTo(MASBoxValue(CGSizeMake(32, 32)));
    }];

    //下一集按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:[UIImage imageNamed:@"player_btn_play_next_normal"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(playNext:) forControlEvents:UIControlEventTouchUpInside];
    [_controlsView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playButton);
        make.left.equalTo(_playButton.mas_right).offset(5);
        make.size.equalTo(MASBoxValue(CGSizeMake(32, 32)));
    }];
    //时间标签
    _timeLabel = [UILabel new];
    _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d/%02d:%02d",0,0,0,0];
    _timeLabel.textColor = [UIColor whiteColor];
    [_controlsView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nextButton.mas_right).offset(10);
        make.bottom.equalTo(nextButton);
        make.size.equalTo(MASBoxValue(CGSizeMake(300, 32)));
    }];

    //加载进度条
    _videoLoadProgressView = [UIProgressView new];
    _videoLoadProgressView.progress = 0.0f;
    _videoLoadProgressView.backgroundColor = [UIColor grayColor];
    [_controlsView addSubview:_videoLoadProgressView];
    [_videoLoadProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_controlsView);
        make.right.equalTo(_controlsView);
        make.bottom.equalTo(_playButton.mas_top).offset(-10);
        make.height.equalTo(@.5);
    }];

    //滑动条
    _videoSlider = [UISlider new];
    [_videoSlider addTarget:self action:@selector(videoSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _videoSlider.continuous = NO;
    //生成一张透明图用来放到slider的右边部分
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
    [_videoSlider setMinimumTrackTintColor:[UIColor orangeColor]];
    [_videoSlider setThumbImage:[UIImage imageNamed:@"player_btn_progress"] forState:UIControlStateNormal];
    [_controlsView addSubview:_videoSlider];
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_videoLoadProgressView);
        make.centerY.equalTo(_videoLoadProgressView).offset(-1);
        make.width.equalTo(_videoLoadProgressView);
        make.height.equalTo(@20);
    }];

}

#pragma mark targets/actions

- (void)backButtonClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playOrPause:(UIButton *)sender
{
    switch (_vlcMediaListPlayer.mediaPlayer.state) {
        case VLCMediaPlayerStateOpening:
        case VLCMediaPlayerStateBuffering:
        case VLCMediaPlayerStatePlaying:
        {
            [_vlcMediaListPlayer pause];
            break;
        }
        case VLCMediaPlayerStatePaused:
        {
            [_vlcMediaListPlayer play];
            break;
        }
        case VLCMediaPlayerStateStopped:
        case VLCMediaPlayerStateEnded:
        {
            [_vlcMediaListPlayer next];
        }
        case VLCMediaPlayerStateError:
        default:
            break;
    }

}


- (void)playNext:(UIButton *)sender
{
}

- (void)didTaped:(UITapGestureRecognizer *)recognizer
{
    BOOL hidden = _controlsView.hidden;
    _controlsView.hidden = !hidden;

}

- (void)videoSliderValueChanged:(UISlider *)slider
{
    CGFloat timeToSeek = slider.value * _totalDuration;
    CGFloat sectionTime = 0;
    int index = 0;
    for (DIEVideoSectionModel *sectionModel in _videoInfoModel.sections) {
        CGFloat time = timeToSeek - sectionTime;
        if (time < sectionModel.duration.floatValue) {
            if ([_vlcMediaListPlayer.mediaList indexOfMedia:_vlcMediaListPlayer.mediaPlayer.media] != index) {
                [_vlcMediaListPlayer playItemAtIndex:index];
            }
            _vlcMediaListPlayer.mediaPlayer.position = (time/sectionModel.duration.floatValue);
            break;
        }else{
            sectionTime += sectionModel.duration.floatValue;
            index++;
        }
    }
    NSLog(@"timeToSeek:%.0f, sectionTime:%.0f index:%d", timeToSeek,sectionTime, index);
}

#pragma mark -
- (void)syncPlayerStateToUI:(VLCMediaPlayer*)player
{
    switch (player.state) {
        case VLCMediaPlayerStateOpening:
        case VLCMediaPlayerStateBuffering:
        case VLCMediaPlayerStatePlaying:
        {
            [_playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
            break;
        }
        case VLCMediaPlayerStatePaused:
        {
            [_playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
            break;
        }
        case VLCMediaPlayerStateEnded:
        case VLCMediaPlayerStateStopped:
        {
            [_playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
            _videoSlider.value = 0.0f;
            _timeLabel.text = @"00:00 / 00:00";
            break;
        }
        case VLCMediaPlayerStateError:
        default:
            break;
    }
    _videoSlider.enabled = _vlcMediaListPlayer.mediaPlayer.seekable;

}


#pragma mark VLCMediaPlayerDelegate

- (void)mediaPlayerStateChanged:(NSNotification *)aNotification
{
    VLCMediaPlayer *player = aNotification.object;
    [self syncPlayerStateToUI:player];
}
- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification
{

    CGFloat currentSectionTime = _vlcMediaListPlayer.mediaPlayer.time.value.floatValue/1000.0;
    NSInteger currentIndex = [_vlcMediaListPlayer.mediaList indexOfMedia:_vlcMediaListPlayer.mediaPlayer.media];
    CGFloat previousSectionsTime = 0.0f;
    for (int i = 0; i < currentIndex && i < _videoInfoModel.sections.count; i++) {
        DIEVideoSectionModel *model = _videoInfoModel.sections[i];
        previousSectionsTime += model.duration.floatValue;
    }
    _currentDuration = previousSectionsTime + currentSectionTime;


    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d", (int)_currentDuration/60,(int)_currentDuration%60];
    NSString *totalTimeStr = [NSString stringWithFormat:@"%02d:%02d", (int)_totalDuration/60,(int)_totalDuration%60];
    _timeLabel.text = [NSString stringWithFormat:@"%@ / %@", currentTimeStr, totalTimeStr];
    _videoSlider.value = _currentDuration/_totalDuration;

}


#pragma mark -
#pragma mark DataManger & Notification
- (void)loadVideoInfoWithQuality:(DIEQualityType)quality
{
    [[DIEDataManager sharedManager]updateAnimeVideoWithVideoId:_videoId andQuality:DIEQualityTypeHighDefinition];
}
- (void)videoInfoUpdated:(NSNotification *)aNotification
{
    if (![aNotification.object isKindOfClass:DIEVideoInfoModel.class]) {
        return;
    }
    _videoInfoModel = aNotification.object;
    _totalDuration = 0.0f;
    _currentDuration = 0.0f;
    NSMutableArray *mediaArray = [NSMutableArray new];
    for (DIEVideoSectionModel *section in _videoInfoModel.sections) {
        _totalDuration += section.duration.floatValue;
        if (section.videoUrl) {
            VLCMedia *media = [[VLCMedia alloc]initWithURL:section.videoUrl];
            [media parse];
            [mediaArray insertObject:media atIndex:0];
        }
    }
    _vlcMediaListPlayer.mediaList = [[VLCMediaList alloc]initWithArray:mediaArray];
    if (_videoInfoModel.playDirectly) {
        [_vlcMediaListPlayer play];
    }
}
#pragma mark -
- (void)dealloc
{
    [_vlcMediaListPlayer stop];
    DIERemoveObserver(self, kDIEVideoInfoUpdateNotif, nil);
}

@end
