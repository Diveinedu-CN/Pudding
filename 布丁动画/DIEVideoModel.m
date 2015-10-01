//
//  DIEVideo.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEVideoModel.h"

@implementation DIEVideoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"videoId":@"_id",
         @"epId":@"epId",
         @"source":@"source",
         @"url":@"url",
         @"sourceWording":@"sourceWording"
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
