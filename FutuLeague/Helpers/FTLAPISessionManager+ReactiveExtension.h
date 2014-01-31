//
//  FTLAPISessionManager+ReactiveExtension.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLAPISessionManager.h"

@interface FTLAPISessionManager (ReactiveExtension)

- (RACSignal *)signalForGET:(NSString *)URLString parameters:(NSDictionary *)parameters;

@end
