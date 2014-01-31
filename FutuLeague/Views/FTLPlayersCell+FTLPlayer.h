//
//  FTLPlayersCell+FTLPlayer.h
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayersCell.h"

@class FTLPlayer;

@interface FTLPlayersCell (FTLPlayer)

- (void)fillCellWithPlayer:(FTLPlayer *)player atPosition:(NSInteger)position;

@end
