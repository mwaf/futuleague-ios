//
//  FTLPlayerSelectionCell+FTLPlayer.m
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerSelectionCell+FTLPlayer.h"
#import "FTLPlayer.h"

@implementation FTLPlayerSelectionCell (FTLPlayer)

- (void)updateWithPlayer:(FTLPlayer *)player
{
    self.nameLabel.text = player.name;
}

@end
