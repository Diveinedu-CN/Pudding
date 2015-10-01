//
//  AnimeTableViewCell.m
//  布丁动画
//
//  Created by Cheetah on 15/10/1.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "AnimeTableViewCell.h"
#import "Masonry.h"
@implementation AnimeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _animeImageView = [UIImageView new];
        _nameLabel = [UILabel new];
        _categoryNamesLabel = [UILabel new];
        _updatedLabel = [UILabel new];


        _animeImageView.layer.cornerRadius = 5;
        _animeImageView.layer.masksToBounds = YES;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
        _categoryNamesLabel.textColor = [UIColor grayColor];
        _updatedLabel.textColor = [UIColor grayColor];



        [self.contentView addSubview:_animeImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_categoryNamesLabel];
        [self.contentView addSubview:_updatedLabel];


        [_animeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(@10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.equalTo(@70);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_animeImageView);
            make.left.equalTo(_animeImageView.mas_right).offset(5);
            make.right.equalTo(self).offset(-5);
            make.height.equalTo(@20);
        }];
        [_categoryNamesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.width.and.height.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(2);
        }];
        [_updatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.width.height.equalTo(_categoryNamesLabel);
            make.top.equalTo(_categoryNamesLabel.mas_bottom).offset(2);
        }];


    }
    return self;
}

@end
