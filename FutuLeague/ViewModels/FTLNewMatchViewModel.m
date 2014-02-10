//
//  FTLNewMatchViewModel.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLNewMatchViewModel.h"
#import "FTLMatchStore.h"
#import "FTLPlayer.h"

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

    RAC(self, homePlayersButtonTitle) = [RACObserve(self, homePlayers) map:^id(NSArray *team) {
        if (team.count > 0)
        {
            return [[[team.rac_sequence map:^id(FTLPlayer *player) {
                return player.name;
            }] array] componentsJoinedByString:@", "];
        }
        return @"Home Players";
    }];

    RAC(self, awayPlayersButtonTitle) = [RACObserve(self, awayPlayers) map:^id(NSArray *team) {
        if (team.count > 0)
        {
            return [[[team.rac_sequence map:^id(FTLPlayer *player) {
                return player.name;
            }] array] componentsJoinedByString:@", "];
        }
        return @"Away Players";
    }];

    return self;
}

#pragma mark - Custom Accessors

- (RACCommand *)submitCommand
{
    if (!_submitCommand)
    {
        _submitCommand = [[RACCommand alloc] initWithEnabled:self.validFormSignal signalBlock:^RACSignal *(id input) {
            return [[FTLMatchStore sharedStore] postMatchWithHomePlayers:self.homePlayers
                                                             awayPlayers:self.awayPlayers
                                                               homeScore:self.homeScore
                                                               awayScore:self.awayScore];
        }];
    }
    return _submitCommand;
}

- (RACSignal *)validFormSignal
{
    if (!_validFormSignal)
    {
        _validFormSignal = [RACSignal
            combineLatest:@[RACObserve(self, homePlayers),
                            RACObserve(self, awayPlayers),
                            RACObserve(self, homeScore),
                            RACObserve(self, awayScore)]
            reduce:^id(NSArray *homePlayers, NSArray *awayPlayers, NSNumber *homeScore, NSNumber *awayScore) {
                NSSet *homeSet = [NSSet setWithArray:homePlayers];
                NSSet *awaySet = [NSSet setWithArray:awayPlayers];
                BOOL conflictingPlayers = [homeSet intersectsSet:awaySet];
                return @(homeSet.count && awaySet.count && !conflictingPlayers && homeScore && awayScore);
            }];
    }
    return _validFormSignal;
}

@end
