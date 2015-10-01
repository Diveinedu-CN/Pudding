//
//  DIEEpisode.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEEpisodeModel.h"
#import "DIEVideoModel.h"

@implementation DIEEpisodeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"episodeId":@"_id",
         @"animeCategoryNames":@"animeCategoryNames",
         @"animeId":@"animeId",
         @"animeImageUrl":@"animeImageUrl",
         @"animeName":@"animeName",
         @"bulletCount":@"bulletCount",
         @"commentCount":@"commentCount",
         @"width":@"image.width",
         @"height":@"image.height",
         @"url":@"image.url",
         @"insertedTime":@"insertedTime",
         @"number":@"number",
         @"playCount":@"playCount",
         @"videos":@"videos",
         @"watchedPromotionTitle":@"watchedPromotionTitle",
         @"watchedPromotions":@"watchedPromotions"
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

+ (NSValueTransformer *)videosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:DIEVideoModel.class];
}
@end
