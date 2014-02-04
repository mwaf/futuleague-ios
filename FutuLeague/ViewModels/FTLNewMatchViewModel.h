//
//  FTLNewMatchViewModel.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "RVMViewModel.h"

@interface FTLNewMatchViewModel : RVMViewModel

// Commands
@property (nonatomic, readonly) RACCommand *submitCommand;

// Outlets
@property (nonatomic, readonly) NSString *homePlayersButtonTitle;
@property (nonatomic, readonly) NSString *awayPlayersButtonTitle;

// Inputs
@property (nonatomic, copy) NSNumber *homeScore;
@property (nonatomic, copy) NSNumber *awayScore;

// Data Sources
@property (nonatomic, copy, readonly) NSArray *players;

- (instancetype)initWithPlayers:(NSArray *)players;

@end
