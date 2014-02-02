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
@property (nonatomic, strong) RACSignal *validFormSignal;

@property (nonatomic, copy) NSArray *players;

@end

@implementation FTLNewMatchViewModel

#pragma mark - Setup

- (instancetype)initWithPlayers:(NSArray *)players
{
    self = [super init];
    if (!self) return nil;

    _players = players;

    return self;
}

#pragma mark - Custom Accessors

- (RACCommand *)submitCommand
{
    if (!_submitCommand)
    {
        _submitCommand = [[RACCommand alloc] initWithEnabled:self.validFormSignal signalBlock:^RACSignal *(id input) {
            return [[FTLMatchStore sharedStore] postMatchWithPlayers:self.players homeScore:self.homeScore awayScore:self.awayScore];
        }];
    }
    return _submitCommand;
}

- (RACSignal *)validFormSignal
{
    if (!_validFormSignal)
    {
        _validFormSignal = [RACSignal
            combineLatest:@[RACObserve(self, homeScore), RACObserve(self, awayScore)]
            reduce:^id(NSNumber *homeScore, NSNumber *awayScore){
                return @(homeScore && awayScore);
            }];
    }
    return _validFormSignal;
}

@end
