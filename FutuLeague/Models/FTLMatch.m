//
//  FTLMatch.m
//  FutuLeague
//
//  Created by Magnus Nilsson on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLMatch.h"
#import "FTLPlayer.h"

@implementation FTLMatch

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"homeTeam": @"homeTeam",
             @"awayTeam": @"awayTeam",
             @"homeClub": @"homeClub",
             @"awayClub": @"awayClub",
             @"homeScore": @"homeScore",
             @"awayScore": @"awayScore"
             };
}

+ (NSValueTransformer *)homeTeamJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[FTLPlayer class]];
}

+ (NSValueTransformer *)awayTeamJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[FTLPlayer class]];
}

+ (NSValueTransformer *)homeClubJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FTLClub class]];
}

+ (NSValueTransformer *)awayClubJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FTLClub class]];
}


@end
