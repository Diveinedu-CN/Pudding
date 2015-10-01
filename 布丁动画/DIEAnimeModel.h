//
//  DIEAnimeModel.h
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Mantle/Mantle.h>

@interface DIEAnimeModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * animeId;
@property (nonatomic, strong) NSArray * aliases;
@property (nonatomic, strong) NSArray * categoryNames;
@property (nonatomic, assign) NSInteger chatGroupCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, strong) NSArray * directorNames;
@property (nonatomic, assign) NSInteger displayPlayCount;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onairEpNumber;
@property (nonatomic, assign) NSInteger picCount;
@property (nonatomic, assign) NSInteger pushedEpNumber;
@property (nonatomic, assign) NSInteger relatedImageTopicCount;
@property (nonatomic, strong) NSArray * relatedTags;
@property (nonatomic, assign) NSInteger relatedTopicCount;
@property (nonatomic, assign) NSInteger relatedVideoTopicCount;
@property (nonatomic, strong) NSArray * scenaristNames;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, strong) NSArray * seiyuNames;
@property (nonatomic, strong) NSArray * studios;
@property (nonatomic, strong) NSArray * subjectIds;
@property (nonatomic, assign) NSInteger totalEpCount;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray * videoSources;
@property (nonatomic, assign) NSInteger latestWatchedEpNumber;

//简便的对象创建方法
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsFromJSONArray:(NSArray *)array;
@end