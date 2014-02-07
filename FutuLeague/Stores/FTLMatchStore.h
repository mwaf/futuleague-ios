//
//  FTLMatchStore.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTLMatchStore : NSObject

+ (instancetype)sharedStore;

- (RACSignal *)postMatchWithHomePlayers:(NSArray *)homePlayers
                            awayPlayers:(NSArray *)awayPlayers
                              homeScore:(NSNumber *)homeScore
                              awayScore:(NSNumber *)awayScore;

@end
