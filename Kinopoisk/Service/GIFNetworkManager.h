//
//  GIFNetworkManager.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//
#import "Foundation/Foundation.h"

@interface GIFNetworkManager : NSObject

+ (instancetype)sharedInstance;
- (void)fetchTrending;
- (void)fetchRandom;
- (void)fetchSearch:(NSString *)query;

@end
