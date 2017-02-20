//
//  AFHTTPSessionManager+ApiManager.m
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "AFHTTPSessionManager+ApiManager.h"
#import "GIFEndpoint.h"

@implementation AFHTTPSessionManager (ApiManager)

- (NSURLSessionDataTask *)apiRequest:(NSMutableDictionary *)parameters endpoint:(GIFEndpoint *)endpoint success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    switch (endpoint.httpMethod) {
        case GET:
            return [self GET: endpoint.url  parameters:parameters progress:NULL success:success failure:failure];
            // return data task from other method
        default:
            return NULL;
    }
   }

@end
