//
//  UTCDateFormatter.m
//
//  Created by Martin Richter on 27.06.13.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "UTCDateFormatter.h"

@implementation UTCDateFormatter

- (id)init
{
    self = [super init];
    if (self)
    {
        // Use ISO 8601 UTC format
        self.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        self.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    }
    return self;
}

#pragma mark - Singleton

+ (UTCDateFormatter *)sharedFormatter
{
    static UTCDateFormatter *sharedFormatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedFormatter = [[self alloc] init];
    });
    
    return sharedFormatter;
}

@end
