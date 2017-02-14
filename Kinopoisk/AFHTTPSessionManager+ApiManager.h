//
//  AFHTTPSessionManager+ApiManager.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "GIFEndpoint.h"

@interface AFHTTPSessionManager (ApiManager)

- (NSURLSessionDataTask *) apiRequest: (NSMutableDictionary *) parameters endpoint: (GIFEndpoint*) endpoint success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

@end
