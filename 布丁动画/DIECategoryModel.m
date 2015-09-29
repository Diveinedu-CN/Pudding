//
//  DIECategoryModel.m
//  布丁动画
//
//  Created by Cheetah on 15/9/29.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIECategoryModel.h"

@implementation DIECategoryModel




#pragma  mark MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    //头文件中定义的属性  < : > JSON字典中的key
    return @{
             @"categoryId":   @"_id",
             @"name":  @"name",
             @"animeCount": @"animeCount",
             @"width":@"image.width",
             @"height":@"image.height",
             @"url":@"image.url"
             };
}

#pragma mark Utility methods
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dict error:nil];
}
+ (NSArray *)modelsWithArray:(NSArray *)array {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:array error:nil];
}

@end
