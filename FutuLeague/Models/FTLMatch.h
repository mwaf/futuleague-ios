//
//  FTLMatch.h
//  FutuLeague
//
//  Created by Magnus Nilsson on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FTLClub.h"

@interface FTLMatch : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray *homeTeam;
@property (nonatomic, copy) NSArray *awayTeam;
@property (nonatomic, copy, readonly) FTLClub *homeClub;
@property (nonatomic, copy, readonly) FTLClub *awayClub;
@property (nonatomic, assign, readonly) CGFloat *homeScore;
@property (nonatomic, assign, readonly) CGFloat *awayScore;

@end
