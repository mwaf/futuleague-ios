//
//  FTLClub.h
//  FutuLeague
//
//  Created by Magnus Nilsson on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FTLClub : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *league;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, assign, readonly) CGFloat rating;

@end
