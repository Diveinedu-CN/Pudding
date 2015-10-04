//
//  DIEVideoInfoModel.m
//  布丁动画
//
//  Created by Cheetah on 15/10/3.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEVideoInfoModel.h"

#pragma mark -
#pragma mark DIEVideoQualityModel
@implementation DIEVideoQualityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //头文件中定义的属性  < : > JSON字典中的key
    return @{
             @"type":   @"type",
             @"desc":  @"description"
             };
}
+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
            @{@1:@(DIEQualityTypeSmooth),
              @2:@(DIEQualityTypeStandard),
              @3:@(DIEQualityTypeHighDefinition),
              @4:@(DIEQualityTypeSuperDefinition)
              }];
}
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dictionary error:nil];
}

+ (NSArray *)modelsFromJSONArray:(NSArray *)array {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:array error:nil];
}
@end
#pragma mark -
#pragma mark DIEVideoSectionModel
@implementation DIEVideoSectionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //头文件中定义的属性  < : > JSON字典中的key
    return @{
             @"number":   @"number",
             @"duration":  @"duration",
             @"videoUrl":  @"videoUrl",
             @"fileType":  @"fileType"
             };
}
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dictionary error:nil];
}

+ (NSArray *)modelsFromJSONArray:(NSArray *)array {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:array error:nil];
}
+ (NSValueTransformer *)videoUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
#pragma mark -
#pragma mark DIEVideoInfoModel
@implementation DIEVideoInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //头文件中定义的属性  < : > JSON字典中的key
    return @{
             @"availableQualities":   @"availableQualities",
             @"playDirectly":  @"playDirectly",
             @"playerType":  @"playerType",
             @"quality":  @"quality",
             @"sections":  @"sections",
             @"videoId":  @"videoId",
             @"videoPageUrl":  @"videoPageUrl",
             @"videoTimeSnippets":  @"videoTimeSnippets"
             };
}
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dictionary error:nil];
}

+ (NSArray *)modelsFromJSONArray:(NSArray *)array {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:array error:nil];
}
+ (NSValueTransformer *)availableQualitiesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:DIEVideoQualityModel.class];
}
+ (NSValueTransformer *)qualityJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:DIEVideoQualityModel.class];
}
+ (NSValueTransformer *)sectionsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:DIEVideoSectionModel.class];
}
+ (NSValueTransformer *)videoPageUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
