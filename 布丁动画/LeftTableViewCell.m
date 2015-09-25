//
//  LeftTableViewCell.m
//  布丁动画
//
//  Created by Cheetah on 15/9/21.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "Masonry.h"

@interface LeftTableViewCell ()
{
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UIImageView *_indicatorImageView;
}
@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier])
    {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 32, 32)];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 150, 40)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        
        _indicatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(250, 5, 32, 32)];
        _indicatorImageView.image = [UIImage imageNamed:@"home_anime_indicator"];
        
        [self.contentView addSubview:_iconImageView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_indicatorImageView];
    }

    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
