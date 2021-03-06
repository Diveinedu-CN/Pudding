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
        _animeArray = [NSMutableArray new];
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


- (void)updateAnimeWithCategoryId:(NSString *)categoryId
{
    [DIENetworkManager animeWithCategoryId:categoryId withLimit:20 completion:^(id responseObject, DIEError *error) {
        NSArray *parsedArray = [self parseAnimeData:responseObject];

        [_animeArray removeAllObjects];
        [_animeArray addObjectsFromArray:parsedArray];
        DIEPost(kDIEAnimeUpdateNotif, nil);
    }];
}

- (NSArray *)parseAnimeData:(id)animeData
{
    if ([animeData isKindOfClass:[NSArray class]]) {
        NSArray *array =  [DIEAnimeModel modelsFromJSONArray:animeData];
        return array;
    }else{
        return @[];
    }

}

- (void)updateAnimeEpisodeWithAnimeId:(NSString *)animeId andEpisodeId:(NSInteger)episodeId
{
    [DIENetworkManager animeEpisodeWithAnimeId:animeId withEpisodeId:episodeId completion:^(id responseObject, DIEError *error) {
        DIEEpisodeModel *episodeModel = [self parseAnimeEpisodeData:responseObject];
        DIEPost(kDIEAnimeEpisodeUpdateNotif, episodeModel);
    }];
}
- (DIEEpisodeModel *)parseAnimeEpisodeData:(id)episodeData
{
    DIEEpisodeModel *episodeModel;
    if ([episodeData isKindOfClass:[NSDictionary class]]) {
        episodeModel = [DIEEpisodeModel modelFromJSONDictionary:episodeData];
    }
    return episodeModel;
}


- (void)updateAnimeVideoWithVideoId:(NSString *)videoId andQuality:(DIEQualityType)quality
{
    [DIENetworkManager animeVideoWitdVideoId:videoId withQuality:quality completion:^(id responseObject, DIEError *error) {
        DIEVideoInfoModel *videoInfoModel;
        videoInfoModel = [self parseVideoInfoData:responseObject];
        DIEPost(kDIEVideoInfoUpdateNotif, videoInfoModel);
    }];
}

- (DIEVideoInfoModel *)parseVideoInfoData:(id)videoInfoData
{
    DIEVideoInfoModel *videoInfoModel;
    if ([videoInfoData isKindOfClass:[NSDictionary class]]) {
        videoInfoModel = [DIEVideoInfoModel modelFromJSONDictionary:videoInfoData];
    }
    return videoInfoModel;

}
@end



