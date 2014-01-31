//
//  FTLRankingsViewModel.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLRankingsViewModel.h"
#import "FTLPlayerStore.h"

@implementation FTLRankingsViewModel

#pragma mark - Setup

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    RAC(self, model) = [[FTLPlayerStore sharedStore] fetchPlayersSignal];

    return self;
}

@end
