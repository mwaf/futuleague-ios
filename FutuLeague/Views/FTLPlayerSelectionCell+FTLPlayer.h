//
//  FTLPlayerSelectionCell+FTLPlayer.h
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerSelectionCell.h"

@class FTLPlayer;

@interface FTLPlayerSelectionCell (FTLPlayer)

- (void)updateWithPlayer:(FTLPlayer *)player;

@end
