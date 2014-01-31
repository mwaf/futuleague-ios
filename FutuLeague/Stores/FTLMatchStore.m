//
//  FTLMatchStore.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLMatchStore.h"
#import "FTLAPISessionManager+Signals.h"
#import <Mantle/Mantle.h>

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

- (RACSignal *)postMatchWithPlayers:(NSArray *)players homeScore:(NSNumber *)homeScore awayScore:(NSNumber *)awayScore
{
    NSArray *homeTeam = @[[MTLJSONAdapter JSONDictionaryFromModel:players.firstObject]];
    NSArray *awayTeam = @[[MTLJSONAdapter JSONDictionaryFromModel:players.lastObject]];

    NSDictionary *parameters = @{
        @"homeTeam": homeTeam,
        @"awayTeam": awayTeam,
        @"homeClub": [NSNull null],
        @"awayClub": [NSNull null],
        @"homeScore": @1,
        @"awayScore": @0,
        @"timestamp": @""
    };

    return [[FTLAPISessionManager sharedManager] signalForPOST:@"matches" parameters:parameters];
}

@end
