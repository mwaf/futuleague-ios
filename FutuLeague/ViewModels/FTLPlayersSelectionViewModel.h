//
//  FTLPlayersSelectionViewModel.h
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "RVMViewModel.h"

@class FTLPlayer;

@interface FTLPlayersSelectionViewModel : RVMViewModel

// Data Source
@property (nonatomic, copy, readonly) NSArray *players;

- (instancetype)initWithPlayers:(NSArray *)players;
- (FTLPlayer *)playerAtIndex:(NSUInteger)index;
- (NSArray *)playersAtIndexes:(NSIndexSet *)indexes;

@end
