//
//  ModelsSpec.m
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "Kiwi.h"
#import "FTLPlayer.h"

SPEC_BEGIN(ModelsSpec)

describe(@"Player Model", ^{
    __block NSArray *players;
    __block FTLPlayer *firstPlayer;
    
    beforeAll(^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [bundle pathForResource:@"players" ofType:@"json"];
        players = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                                options:0
                                                                  error:NULL];
        
        firstPlayer = [MTLJSONAdapter modelOfClass:[FTLPlayer class] fromJSONDictionary:players[0] error:NULL];
    });
    
    context(@"parse json to dictionary", ^{
        it(@"dictionary should not be nil", ^{
            [[players shouldNot] beNil];
        });
    });

    context(@"parse json entries to Player models", ^{
        
        it(@"first model should not be nil", ^{
            [[firstPlayer shouldNot] beNil];
        });
        
        it(@"players name should be Jon", ^{
            [firstPlayer.name isEqualToString:@"Jon"];
        });
        
        it(@"players rating should be 5", ^{
            [[theValue(firstPlayer.rating) should] equal:theValue(5)];
        });
    });
    
});

SPEC_END
