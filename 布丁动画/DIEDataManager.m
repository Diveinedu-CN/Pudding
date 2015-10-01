//
//  DIEDataManager.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEDataManager.h"
#import "DIENetworkManager.h"
#import "DIENotificationConfig.h"
@interface DIEDataManager ()
{
    NSInteger _categoryOffset;
    NSInteger _categoryLimit;
}
@end

@implementation DIEDataManager
static DIEDataManager *instnce;
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instnce = [DIEDataManager new];
    });
    return instnce;
}

- (instancetype)init
{
    if (self = [super init]) {
        _categoryOffset = 0;
        _categoryLimit = 18;
        _categoriesArray = [NSMutableArray new];
    }
    return self;
}

- (void)updateCategory
{
    [DIENetworkManager categoryWithOffset:0 limit:_categoryLimit completion:^(id responseObject, DIEError *error) {
        NSArray *array = [self parseCategoryData:responseObject];
        [_categoriesArray removeAllObjects];
        [_categoriesArray addObjectsFromArray:array];
        _categoryOffset = 0;
        DIEPost(kDIECategoryUpdateNotif, nil);
    }];
}
- (void)loadMoreCategory
{
    [DIENetworkManager categoryWithOffset:_categoryOffset limit:_categoryLimit completion:^(id responseObject, DIEError *error) {
        NSArray *array = [self parseCategoryData:responseObject];
        [_categoriesArray addObjectsFromArray:array];
        _categoryOffset+=[array count];
        DIEPost(kDIECategoryUpdateNotif, nil);
    }];
}

#pragma mark parse category infomation array
- (NSArray *)parseCategoryData:(id)categoryData
{
    if ([categoryData isKindOfClass:[NSArray class]]) {
        NSArray *array =  [DIECategoryModel modelsWithArray:categoryData];
        return array;
    }else{
        return @[];
    }
}
@end



