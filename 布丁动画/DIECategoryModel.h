//
//  DIECategoryModel.h
//  布丁动画
//
//  Created by Cheetah on 15/9/29.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIECategoryModel : NSObject
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,assign) NSInteger animeCount;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,copy) NSURL *url;


- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary;
+ (instancetype)modelFromJSONDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)JSONDictionary;

+ (NSArray *)modelsFromJSONArray:(NSArray *)array;

@end