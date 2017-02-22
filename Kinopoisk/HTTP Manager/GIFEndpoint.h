//
//  GIFEndpoint.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

@interface GIFEndpoint : NSObject

typedef NS_ENUM(NSInteger, HTTPMethod)
{
    GET,
    POST,
    DELETE,
    PATCH
};

typedef NS_ENUM(NSInteger, Endpoint)
{
    Trending,
    Random,
    Search
};

- (id)initWithEndpoint:(Endpoint )gifEndpoint;
- (HTTPMethod )httpMethod;
- (NSString *)url;
extern NSString* const API_KEY;

@end
