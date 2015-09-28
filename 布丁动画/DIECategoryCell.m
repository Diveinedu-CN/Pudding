//
//  DIECategoryCell.m
//  布丁动画
//
//  Created by Cheetah on 15/9/28.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIECategoryCell.h"
#import "Masonry.h"
@interface DIECategoryCell()
{
    UIImageView *_imageView;
    UILabel *_textLabel;
    UILabel *_floatTextLabel;
}
@end
@implementation DIECategoryCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.width.equalTo(self);
            make.height.equalTo(self.mas_width);
        }];
    }
    return _imageView;
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.width.equalTo(self);
            make.bottom.equalTo(self).offset(-5);
            make.height.equalTo(self.mas_height).multipliedBy(0.25);
        }];
    }
    return _textLabel;
}

- (UILabel *)floatTextLabel
{
    if (_floatTextLabel == nil) {
        _floatTextLabel = [[UILabel alloc]init];
        _floatTextLabel.textAlignment = NSTextAlignmentCenter;
        _floatTextLabel.textColor = [UIColor whiteColor];
        _floatTextLabel.backgroundColor = [UIColor colorWithHue:1 saturation:0.5 brightness:0.2 alpha:0.8];
        [self.imageView addSubview:_floatTextLabel];
        [_floatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.width.equalTo(_imageView);
            make.height.equalTo(@20);
        }];
    }
    return _floatTextLabel;
}
@end
