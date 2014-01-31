//
//  FTLAPISessionManager.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLAPISessionManager.h"

static NSString * const FTLBaseURL = @"http://jonster.futupeople.com/futuleague/FIFA14";

@implementation FTLAPISessionManager

+ (instancetype)sharedManager {
    static FTLAPISessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:FTLBaseURL];
        _sharedManager = [[FTLAPISessionManager alloc] initWithBaseURL:baseURL];
        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        [requestSerializer setValue:@"application/vnd.futuleague.v1+json" forHTTPHeaderField:@"Accept"];
        _sharedManager.requestSerializer = requestSerializer;
    });

    return _sharedManager;
}

@end
