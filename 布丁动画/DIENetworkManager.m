//
//  DIENetworkManager.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//
#import "DIEToolKit.h"
#import "DIENetworkManager.h"
#import "AFNetworking.h"

@implementation DIENetworkManager
+ (void)categoryWithOffset:(NSInteger)offset limit:(NSInteger)limit completion:(CompletionType)completion {
    NSDictionary *params = [DIEToolkit fullParams:@{
                                                    @"offset":@(offset),
                                                    @"limit":@(limit)
                                                    }];
    
    [[AFHTTPSessionManager manager] GET:[DIEToolkit categoryApi] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DIEError *err = [[DIEError alloc] initWithError:error];
        completion(nil, err);
    }];
}

+ (void)animeWithCategoryId:(NSString *)categoryId withLimit:(NSInteger)limit completion:(CompletionType)completion
{
    NSDictionary *params = [DIEToolkit fullParams:@{
                                    @"categoryId":categoryId,
                                                    @"limit":@(limit)
                                                    }];

    [[AFHTTPSessionManager manager] GET:[DIEToolkit animeApiWithCategoryId:categoryId] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DIEError *err = [[DIEError alloc] initWithError:error];
        completion(nil, err);
    }];

}

+ (void)animeEpisodeWithAnimeId:(NSString *)animeId withEpisodeId:(NSInteger)episodeId completion:(CompletionType)completion
{
    NSDictionary *params = [DIEToolkit fullParams:@{}];

    [[AFHTTPSessionManager manager] GET:[DIEToolkit animeEpisodeApiWithAnimeId:animeId andEpisodeId:episodeId] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DIEError *err = [[DIEError alloc] initWithError:error];
        completion(nil, err);
    }];

}
+ (void)animeVideoWitdVideoId:(NSString *)videoId withQuality:(NSInteger)quality completion:(CompletionType)completion
{
    NSDictionary *params = [DIEToolkit fullParams:@{@"deviceType":@1001,@"quality":@(quality),@"sectionNumber":@0}];

    [[AFHTTPSessionManager manager] GET:[DIEToolkit animeVideoApiWithVideoId:videoId] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DIEError *err = [[DIEError alloc] initWithError:error];
        completion(nil, err);
    }];
}
@end
