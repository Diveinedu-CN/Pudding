//
//  LeftUserInfoView.m
//  布丁动画
//
//  Created by Cheetah on 15/9/22.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "LeftUserInfoView.h"
#import "Masonry.h"
@interface LeftUserInfoView ()
{
    //内部使用的控件
    UIButton *_avatarButton;
    UIButton *_followerButton;
    UIButton *_fansButton;
}

@end


@implementation LeftUserInfoView


#pragma mark initial
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createAvatarButton];
        [self createNickNameLabel];
        [self createFollowerButton];
        [self createFansButton];
    }
    return self;
}

- (void)createAvatarButton
{
    _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_avatarButton setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    _avatarButton.layer.cornerRadius = 80/2;
    _avatarButton.layer.masksToBounds = YES;
    
    [self addSubview:_avatarButton];
    [_avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.left.equalTo(@96);
        make.size.equalTo(MASBoxValue(CGSizeMake(80, 80)));
    }];
    

    
}
- (void)createNickNameLabel
{
    //Sorry，此方法无注释
    _nickNameLabel = [[UILabel alloc]init];
    _nickNameLabel.text = @"登录以获取追番纪录";
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_nickNameLabel];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarButton.mas_bottom).offset(10);
        make.centerX.equalTo(_avatarButton.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(200, 40)));
    }];
}
- (void)createFollowerButton
{
    _followerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followerButton setTitle:[NSString stringWithFormat:@"关注 %lu", _followerCount] forState:UIControlStateNormal];
    [self addSubview:_followerButton];
    [_followerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).offset(10);
        make.right.equalTo(_nickNameLabel.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(120, 40)));
    }];
    _followerButton.hidden = YES;
}

- (void)createFansButton
{
    _fansButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fansButton setTitle:[NSString stringWithFormat:@"粉丝 %ld",_fansCount] forState:UIControlStateNormal];
    [self addSubview:_fansButton];
    [_fansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).offset(10);
        make.left.equalTo(_nickNameLabel.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(120, 40)));
    }];
    _fansButton.hidden = YES;
}


#pragma mark setter/getter

- (void)setAvatarImage:(UIImage *)avatarImage
{
    [_avatarButton setBackgroundImage:avatarImage forState:UIControlStateNormal];
}

- (UIImage *)avatarImage
{
    return [_avatarButton backgroundImageForState:UIControlStateNormal];
}

- (void)setFollowerCount:(NSUInteger)followerCount
{
    _followerCount = followerCount;
    [_followerButton setTitle:[NSString stringWithFormat:@"关注 %lu", followerCount] forState:UIControlStateNormal];
}

- (void)setFansCount:(NSUInteger)fansCount
{
    _fansCount = fansCount;
    [_fansButton setTitle:[NSString stringWithFormat:@"粉丝 %lu", fansCount] forState:UIControlStateNormal];
}

- (void)setIsLogin:(BOOL)isLogin
{
    _followerButton.hidden = !isLogin;
    _fansButton.hidden = !isLogin;
}



#pragma mark  targets/actions

- (void)addAvatarTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_avatarButton addTarget:target action:action forControlEvents:controlEvents];
}

- (void)addFollowerTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_followerButton addTarget:target action:action forControlEvents:controlEvents];
}


- (void)addFansTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_fansButton addTarget:target action:action forControlEvents:controlEvents];
}

@end








