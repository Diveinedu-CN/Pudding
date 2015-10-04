//
//  DIENotificationConfig.h
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DIEPost(name, obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

#define DIEAddObserver(observer, action, n, obj) [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:n object:obj]

#define DIERemoveObserver(observer, n, obj) [[NSNotificationCenter defaultCenter] removeObserver:observer name:n object:obj]

FOUNDATION_EXTERN NSString * const kDIECategoryUpdateNotif;
FOUNDATION_EXTERN NSString * const kDIEAnimeUpdateNotif;
FOUNDATION_EXTERN NSString * const kDIEAnimeEpisodeUpdateNotif;
FOUNDATION_EXTERN NSString * const kDIEVideoInfoUpdateNotif;