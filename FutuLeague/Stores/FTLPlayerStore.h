//
//  FTLPlayerStore.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTLPlayerStore : NSObject

+ (instancetype)sharedStore;

- (RACSignal *)fetchPlayersSignal;

@end
