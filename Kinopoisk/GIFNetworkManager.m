//
//  GIFNetworkManager.m
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIFNetworkManager.h"
#import "AFHTTPSessionManager+ApiManager.h"
#import "GIFEndpoint.h"

@interface GIFNetworkManager ()

@end

@implementation GIFNetworkManager

+ (instancetype) sharedInstance
{
    static dispatch_once_t predicate;
    static GIFNetworkManager *sharedModel = nil;
    
    dispatch_once(&predicate, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}


- (void)fetchTrending{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    GIFEndpoint *endpoint = [[GIFEndpoint alloc] initWithEndpoint:Trending];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:API_KEY forKey:@"api_key"];
    [manager apiRequest:params endpoint: endpoint success:^(NSURLSessionDataTask *dataTask, id responseObject){
        NSLog(@"%@", responseObject);
    }failure:^(NSURLSessionDataTask *dataTask, NSError *error){
        
    }];
}

@end
