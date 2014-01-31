//
//  FTLAPISessionManager.h
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FTLAPISessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
