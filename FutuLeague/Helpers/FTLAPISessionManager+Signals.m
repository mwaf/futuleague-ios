//
//  FTLAPISessionManager+Signals.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLAPISessionManager+Signals.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const FTLErrorInfoTaskKey = @"FTLErrorInfoTaskKey";

@implementation FTLAPISessionManager (ReactiveExtension)

- (RACSignal *)signalForGET:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:[self errorWithTask:task fromError:error]];
        }];

        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] replayLazily];
}

- (RACSignal *)signalForPOST:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:[self errorWithTask:task fromError:error]];
        }];

        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] replayLazily];
}

- (NSError *)errorWithTask:(NSURLSessionDataTask *)task fromError:(NSError *)error
{
    NSMutableDictionary *userInfo = [error.userInfo mutableCopy] ?: [NSMutableDictionary dictionary];
    userInfo[FTLErrorInfoTaskKey] = task;
    return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

@end
