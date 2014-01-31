//
//  FTLClub.m
//  FutuLeague
//
//  Created by Magnus Nilsson on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLClub.h"

@implementation FTLClub

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name": @"name",
             @"league": @"league",
             @"country": @"country",
             @"rating": @"rating"
             };
}

@end
