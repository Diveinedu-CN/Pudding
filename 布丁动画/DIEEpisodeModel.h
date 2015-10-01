//
//  DIEEpisode.h
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Mantle.h"

@interface DIEEpisodeModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * episodeId;
@property (nonatomic, strong) NSArray * animeCategoryNames;
@property (nonatomic, strong) NSString * animeId;
@property (nonatomic, strong) NSURL * animeImageUrl;
@property (nonatomic, strong) NSString * animeName;
@property (nonatomic, assign) NSInteger bulletCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger insertedTime;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, strong) NSArray * videos;
@property (nonatomic, strong) NSString * watchedPromotionTitle;
@property (nonatomic, strong) NSArray * watchedPromotions;

//简便的对象创建方法
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsFromJSONArray:(NSArray *)array;
@end
