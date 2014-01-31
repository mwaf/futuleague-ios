//
//  FTLNewMatchViewModel.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLNewMatchViewModel.h"
#import "FTLMatchStore.h"

@interface FTLNewMatchViewModel ()

@property (nonatomic, strong) RACCommand *submitCommand;

@property (nonatomic, copy) NSArray *players;

@end

@implementation FTLNewMatchViewModel

- (instancetype)initWithPlayers:(NSArray *)players
{
    self = [super init];
    if (!self) return nil;

    _players = players;

    RACSignal *validFormSignal = [RACSignal
        combineLatest:@[RACObserve(self, homeScore), RACObserve(self, awayScore)]
        reduce:^id(NSNumber *homeScore, NSNumber *awayScore){
            return @(homeScore && awayScore);
        }];

    self.submitCommand = [[RACCommand alloc] initWithEnabled:validFormSignal signalBlock:^RACSignal *(id input) {
        return [[FTLMatchStore sharedStore] postMatchWithPlayers:_players homeScore:self.homeScore awayScore:self.awayScore];
    }];

    return self;
}

@end
