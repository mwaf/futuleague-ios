//
//  FTLPlayerStore.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerStore.h"
#import "FTLAPISessionManager+Signals.h"
#import "FTLPlayer.h"

@implementation FTLPlayerStore

#pragma mark - Singleton

+ (instancetype)sharedStore {
    static FTLPlayerStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStore = [[FTLPlayerStore alloc] init];
    });

    return _sharedStore;
}

#pragma mark - Networking

- (RACSignal *)fetchPlayersSignal
{
    return [[[FTLAPISessionManager sharedManager] signalForGET:@"players" parameters:nil]
        map:^id(id responseObject) {
            NSArray *playersArray = (NSArray *)responseObject;
            return [[[playersArray rac_sequence] map:^id(NSDictionary *playerDictionary) {
                return [MTLJSONAdapter modelOfClass:[FTLPlayer class] fromJSONDictionary:playerDictionary error:NULL];
            }] array];
        }];
}

@end
