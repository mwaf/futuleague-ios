//
//  FTLPlayer.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FTLPlayer : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) CGFloat rating;

@end
