//
//  DIECategoryModel.m
//  布丁动画
//
//  Created by Cheetah on 15/9/29.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIECategoryModel.h"
NSString * const kCategoryId = @"_id";
NSString * const kCategoryAnimeCount = @"animeCount";
NSString * const kCategoryName = @"name";

NSString * const kCategoryImage = @"image";
NSString * const kCategoryImageWidth = @"width";
NSString * const kCategoryImageHeight = @"height";
NSString * const kCategoryImageUrl = @"url";
@implementation DIECategoryModel

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _categoryId = dictionary[kCategoryId];
        _animeCount = [dictionary[kCategoryAnimeCount] integerValue];
        _name = dictionary[kCategoryName];
        NSDictionary *imageDic = dictionary[kCategoryImage];
        _height = [imageDic[kCategoryImageHeight] integerValue];
        _width = [imageDic[kCategoryImageWidth] integerValue];
        _url = [NSURL URLWithString:imageDic[kCategoryImageUrl]];
    }
    return self;
}

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithJSONDictionary:dictionary];
}

- (NSDictionary *)JSONDictionary
{
    return @{kCategoryId:_categoryId,
             kCategoryAnimeCount:@(_animeCount),
             kCategoryName:_name,
             kCategoryImage:@{
                     kCategoryImageWidth:@(_width),
                     kCategoryImageHeight:@(_height),
                     kCategoryImageUrl:_url.absoluteString
                     }};
}

+ (NSArray *)modelsFromJSONArray:(NSArray *)array
{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dic in array) {
        [modelArray addObject:[self modelFromJSONDictionary:dic]];
    }
    return [modelArray copy];
}
@end
