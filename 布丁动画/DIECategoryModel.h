//
//  DIECategoryModel.h
//  布丁动画
//
//  Created by Cheetah on 15/9/29.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@interface DIECategoryModel : MTLModel <MTLJSONSerializing>
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,assign) NSInteger animeCount;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,copy) NSURL *url;



+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (NSArray *)modelsWithArray:(NSArray *)array;
@end