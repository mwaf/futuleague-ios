//
//  FTLPlayerCell+FTLPlayer.h
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerCell.h"

@class FTLPlayer;

@interface FTLPlayerCell (FTLPlayer)

- (void)updateWithPlayer:(FTLPlayer *)player rank:(NSInteger)rank;

@end
