//
//  FTLRankingsViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLRankingsViewController.h"
#import "FTLRankingsViewModel.h"

@interface FTLRankingsViewController ()

@property (nonatomic, strong) FTLRankingsViewModel *viewModel;

@end

@implementation FTLRankingsViewController

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    _viewModel = [[FTLRankingsViewModel alloc] init];

    return self;
}

@end
