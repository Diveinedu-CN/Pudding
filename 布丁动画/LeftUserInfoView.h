//
//  LeftUserInfoView.h
//  布丁动画
//
//  Created by Cheetah on 15/9/22.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftUserInfoView : UIView
@property (nonatomic,copy,nullable) UIImage *avatarImage;
@property (nonatomic,readonly,nullable) UILabel *nickNameLabel;
@property (nonatomic,assign) NSUInteger followerCount;
@property (nonatomic,assign) NSUInteger fansCount;

@property (nonatomic,assign) BOOL isLogin;

- (void)addAvatarTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addFollowerTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addFansTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
