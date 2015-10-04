//
//  DIEToolKit.h
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDIEIsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kDIEIsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kDIEIsRetina ([[UIScreen mainScreen] scale] >= 2.0)

#define kDIEScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kDIEScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define kDIEScreenMaxLength (MAX(kDIEScreenWidth, kDIEScreenHeight))
#define kDIEScreenMinLength (MIN(kDIEScreenWidth, kDIEScreenHeight))

#define kDIEIsIPhone4SOrLess (kDIEIsIPhone && kDIEScreenMaxLength < 568.0)
#define kDIEIsIPhone5 (kDIEIsIPhone && kDIEScreenMaxLength == 568.0)
#define kDIEIsIPhone6 (kDIEIsIPhone && kDIEScreenMaxLength == 667.0)
#define kDIEIsIPhone6P (kDIEIsIPhone && kDIEScreenMaxLength == 736.0)



@interface DIEToolkit : NSObject
+ (NSDictionary *)deviceParams;
+ (NSDictionary *)appParams;
+ (NSDictionary *)fullParams:(NSDictionary *)params;
+ (NSString *)categoryApi;
+ (NSString *)animeApiWithCategoryId:(NSString *)categotyId;
+ (NSString *)animeEpisodeApiWithAnimeId:(NSString *)animeId andEpisodeId:(NSInteger)episodeId;
+ (NSString *)animeVideoApiWithVideoId:(NSString *)videoId;
@end
