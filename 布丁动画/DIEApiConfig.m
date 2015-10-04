//
//  DIEApiConfig.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEApiConfig.h"

NSString * const kDIEHost = @"http://pudding.cc";

NSString * const kDIECategoryApi = @"api/v1/category";
NSString * const kDIEAnimeApi = @"api/v1/category/%@/anime";
NSString * const kDIEAnimeEpisodeApi = @"api/v1/anime/%@/ep/%d";
NSString * const kDIEAnimeVideoApi = @"api/v1/video/%@/play_info";