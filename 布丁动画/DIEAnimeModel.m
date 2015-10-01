//
//  DIEAnimeModel.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEAnimeModel.h"

@implementation DIEAnimeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"animeId":@"_id",
         @"aliases":@"aliases",
         @"categoryNames":@"categoryNames",
         @"chatGroupCount":@"chatGroupCount",
         @"directorNames":@"directorNames",
         @"intro":@"intro",
         @"onairEpNumber":@"onairEpNumber",
         @"scenaristNames":@"scenaristNames",
         @"score":@"score",
         @"seiyuNames":@"seiyuNames",
         @"totalEpCount":@"totalEpCount",
         @"type":@"type",
         @"name":@"name",
         @"commentCount":@"commentCount",
         @"picCount":@"picCount",
         @"displayPlayCount":@"displayPlayCount",
         @"pushedEpNumber":@"pushedEpNumber",
         @"relatedTopicCount":@"relatedTopicCount",
         @"relatedImageTopicCount":@"relatedImageTopicCount",
         @"relatedVideoTopicCount":@"relatedVideoTopicCount",
         @"relatedTags":@"relatedTags",
         @"studios":@"studios",
         @"subjectIds":@"subjectIds",
         @"videoSources":@"videoSources",
         @"width":@"image.width",
         @"height":@"image.height",
         @"url":@"image.url",
         @"latestWatchedEpNumber":@"latestWatchedEpNumber"
    };
}

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dictionary error:nil];
}

+ (NSArray *)modelsFromJSONArray:(NSArray *)array {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:array error:nil];
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
