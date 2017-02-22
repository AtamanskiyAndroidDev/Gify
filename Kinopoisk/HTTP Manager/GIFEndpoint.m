//
//  Endpoint.m
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIFEndpoint.h"

#define BASE_URL  @"http://api.giphy.com"

@interface GIFEndpoint ()
{
    Endpoint endpoint;
}
- (NSString*)path;

@end

@implementation GIFEndpoint

NSString * const API_KEY = @"dc6zaTOxFJmzC";

- (id)initWithEndpoint:(Endpoint)gifEndpoint
{
    self = [super init];
    if (self) {
        endpoint = gifEndpoint;
    }
    return self;
}

- (HTTPMethod)httpMethod
{
    switch (endpoint) {
        default:
            return GET;
    }
}

- (NSString*)path
{
    switch (endpoint) {
        case Trending:
            return @"/v1/gifs/trending";
        case Random:
            return @"/v1/gifs/random";
        case Search:
            return @"/v1/gifs/search";
    }
}

- (NSString *)url
{
    NSString *baseUrl = BASE_URL;
    return [baseUrl stringByAppendingPathComponent: [self path]];
}

@end
