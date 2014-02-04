//
//  FTLPlayersSelectionViewModel.m
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayersSelectionViewModel.h"

@interface FTLPlayersSelectionViewModel ()

@property (nonatomic, copy) NSArray *players;

@end

@implementation FTLPlayersSelectionViewModel

#pragma mark - Setup

- (instancetype)initWithPlayers:(NSArray *)players
{
    self = [super init];
    if (!self) return nil;

    _players = players;

    return self;
}

#pragma mark - Players

- (FTLPlayer *)playerAtIndex:(NSUInteger)index
{
    if (index < self.players.count)
    {
        return self.players[index];
    }
    return nil;
}

@end
