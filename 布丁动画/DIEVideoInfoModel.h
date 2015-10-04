//
//  DIEVideoInfoModel.h
//  布丁动画
//
//  Created by Cheetah on 15/10/3.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "Mantle.h"
typedef NS_ENUM(NSInteger, DIEQualityType) {
    DIEQualityTypeSmooth = 1,
    DIEQualityTypeStandard,
    DIEQualityTypeHighDefinition,
    DIEQualityTypeSuperDefinition
};

@interface DIEVideoQualityModel : MTLModel <MTLJSONSerializing>
@property (nonatomic,assign) DIEQualityType type;
@property (nonatomic,copy) NSString *desc;
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsFromJSONArray:(NSArray *)array;
@end

@interface DIEVideoSectionModel : MTLModel <MTLJSONSerializing>
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,copy) NSNumber *duration;
@property (nonatomic,copy) NSURL *videoUrl;
@property (nonatomic,assign) NSInteger fileType;
@end




@interface DIEVideoInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray * availableQualities;
@property (nonatomic, assign) BOOL playDirectly;
@property (nonatomic, assign) DIEVideoQualityModel *quality;
@property (nonatomic, assign) NSInteger playerType;
@property (nonatomic, strong) NSArray * sections;
@property (nonatomic, copy) NSString * videoId;
@property (nonatomic, copy) NSURL * videoPageUrl;
@property (nonatomic, strong) NSArray * videoTimeSnippets;
//简便的对象创建方法
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsFromJSONArray:(NSArray *)array;

@end
