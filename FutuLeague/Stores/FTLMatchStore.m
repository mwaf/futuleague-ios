//
//  FTLMatchStore.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLMatchStore.h"
#import "FTLAPISessionManager+Signals.h"

@implementation FTLMatchStore

#pragma mark - Singleton

+ (instancetype)sharedStore {
    static FTLMatchStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStore = [[FTLMatchStore alloc] init];
    });

    return _sharedStore;
}

#pragma mark - Networking

- (RACSignal *)postMatchWithHomeScore:(NSNumber *)homeScore awayScore:(NSNumber *)awayScore
{
    NSDictionary *parameters = @{
        @"homeScore": homeScore,
        @"awayScore": awayScore
    };

    return [[FTLAPISessionManager sharedManager] signalForPOST:@"matches" parameters:parameters];
}

@end
