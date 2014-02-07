//
//  FTLMatchStore.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLMatchStore.h"
#import "FTLAPISessionManager+Signals.h"
#import "FTLPlayer.h"
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

- (RACSignal *)postMatchWithHomePlayers:(NSArray *)homePlayers
                            awayPlayers:(NSArray *)awayPlayers
                              homeScore:(NSNumber *)homeScore
                              awayScore:(NSNumber *)awayScore
{
    NSArray *homePlayersJSON = [[homePlayers.rac_sequence map:^id(FTLPlayer *player) {
        return [MTLJSONAdapter JSONDictionaryFromModel:player];
    }] array];
    NSArray *awayPlayersJSON = [[awayPlayers.rac_sequence map:^id(FTLPlayer *player) {
        return [MTLJSONAdapter JSONDictionaryFromModel:player];
    }] array];

    NSDictionary *parameters = @{
        @"homeTeam": homePlayersJSON,
        @"awayTeam": awayPlayersJSON,
        @"homeClub": [NSNull null],
        @"awayClub": [NSNull null],
        @"homeScore": homeScore,
        @"awayScore": awayScore,
        @"timestamp": @""
    };

    return [[FTLAPISessionManager sharedManager] signalForPOST:@"matches" parameters:parameters];
}

@end
