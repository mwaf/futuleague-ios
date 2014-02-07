//
//  FTLPlayersSelectionViewController.h
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayersSelectionViewModel.h"

typedef NS_ENUM(NSUInteger, FTLPlayersSelectionViewControllerType) {
    FTLPlayersSelectionViewControllerTypeHome = 0,
    FTLPlayersSelectionViewControllerTypeAway
};

@protocol FTLPlayersSelectionViewControllerDelegate;

@interface FTLPlayersSelectionViewController : UICollectionViewController

@property (nonatomic, assign, readonly) FTLPlayersSelectionViewControllerType type;
@property (nonatomic, weak) id<FTLPlayersSelectionViewControllerDelegate> delegate;

- (instancetype)initWithViewModel:(FTLPlayersSelectionViewModel *)viewModel
                             type:(FTLPlayersSelectionViewControllerType)type;

@end

@protocol FTLPlayersSelectionViewControllerDelegate <NSObject>

- (void)playersSelectionViewController:(FTLPlayersSelectionViewController *)viewController
                      didSelectPlayers:(NSArray *)players;

@end