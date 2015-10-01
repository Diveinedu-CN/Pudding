//
//  DIEDataManager.h
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DIECategoryModel.h"
#import "DIEAnimeModel.h"
#import "DIEEpisodeModel.h"
@interface DIEDataManager : NSObject
@property (nonatomic,strong,readonly) NSMutableArray<DIECategoryModel *> *categoriesArray;
@property (nonatomic,strong,readonly) NSMutableArray<DIEAnimeModel *> *animeArray;
+ (instancetype)sharedManager;
- (void)updateCategory;
- (void)loadMoreCategory;
- (void)updateAnimeWithCategoryId:(NSString *)categoryId;
- (void)updateAnimeEpisodeWithAnimeId:(NSString *)animeId andEpisodeId:(NSInteger)episodeId;
@end
