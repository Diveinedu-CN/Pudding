//
//  DIEError.m
//  布丁动画
//
//  Created by Cheetah on 15/9/30.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "DIEError.h"

@implementation DIEError


- (instancetype)initWithCode:(NSInteger)code
{
    if (self = [super init]) {
        _errorCode = code;
    }
    return self;
}

- (instancetype)initWithError:(NSError *)error
{
    if (self = [super init]) {
        _errorCode = error.code;
    }
    return self;
}

+ (instancetype)errorWithCode:(NSInteger)code {
    return [[[self class] alloc] initWithCode:code];
}
- (NSString *)explainErrorCode {
    NSString *reason = nil;
    switch (_errorCode) {
        case kDIENetworkErrorCodeNotFound:
            reason = @"资源不存在";
            break;
        case kDIENetworkErrorCodeNotAuth:
            reason = @"没有登录";
            break;
        default:
            break;
    }
    
    return reason;
}
- (NSString *)reason {
    if (!_reason) {
        _reason = [self explainErrorCode];
    }
    
    return _reason;
}


@end
