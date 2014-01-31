//
//  FTLPlayer.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayer.h"

@implementation FTLPlayer

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"identifier": @"identifier",
        @"name": @"name",
        @"rating": @"rating"
    };
}

@end
