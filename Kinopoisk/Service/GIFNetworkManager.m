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
#import "GIFModel.h"
#import "GIFRealmDataManager.h"

@interface GIFNetworkManager ()
{
    GIFRealmDataManager *dataManager;
    AFHTTPSessionManager *manager;
    GIFEndpoint *endpoint;
    NSMutableDictionary *params;
}
@end

@implementation GIFNetworkManager

- (id)init
{
    dataManager = [[GIFRealmDataManager alloc] init];
    manager = [AFHTTPSessionManager manager];
    params = [[NSMutableDictionary alloc] init];
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    static GIFNetworkManager *sharedModel = nil;
    
    dispatch_once(&predicate, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}


- (void)fetchTrending
{
    endpoint = [[GIFEndpoint alloc] initWithEndpoint:Trending];
    [params setObject:API_KEY forKey:@"api_key"];
    [self apiRequest];
}

- (void)fetchRandom
{
    endpoint = [[GIFEndpoint alloc] initWithEndpoint:Random];
    [params setObject:API_KEY forKey:@"api_key"];
    [manager apiRequest:params endpoint: endpoint success:^(NSURLSessionDataTask *dataTask, id responseObject){
        if ((BOOL)[[[[responseObject valueForKey:@"meta"] valueForKey:@"status"] stringValue] isEqualToString:@"200"]){
            [dataManager deleteAll];
            NSDictionary *data = [responseObject valueForKey:@"data"];
            GIFModel *model = [GIFModel new];
            model.id = data[@"id"];
            model.slug = @"RANDOM deleted";
            model.originalImage = data[@"image_original_url"];
            model.date = @"2016-06-16 06:06:06";
            
            GIFUserModel *userModel = [GIFUserModel new];
            userModel.userName = @"RANDOM";
            userModel.avatarUrl = @"RANDOM";
            
            model.user = userModel;
            [dataManager addModel:model];
        } else {
            // show alert controller
        }
    }failure:^(NSURLSessionDataTask *dataTask, NSError *error){
        // show alert controller
    }];
    
}

- (void)fetchSearch:(NSString *)query
{
    endpoint = [[GIFEndpoint alloc] initWithEndpoint:Search];
    [params setObject:query forKey:@"q"];
    [params setObject:API_KEY forKey:@"api_key"];
    [self apiRequest];
}

- (void)apiRequest
{
    [manager apiRequest:params endpoint: endpoint success:^(NSURLSessionDataTask *dataTask, id responseObject){
        if ((BOOL)[[[[responseObject valueForKey:@"meta"] valueForKey:@"status"] stringValue] isEqualToString:@"200"]){
            [dataManager deleteAll];
            NSDictionary *data = [responseObject valueForKey:@"data"];
            for (NSDictionary* gifdata in data) {
                GIFModel *model = [GIFModel new];
                model.id = [gifdata valueForKey:@"id"];
                model.slug = [gifdata valueForKey:@"slug"];
                NSDictionary *images = [gifdata valueForKey:@"images"];
                model.originalImage = [[images valueForKey:@"original"] valueForKey:@"url"];
                model.date = [gifdata valueForKey:@"trending_datetime"];
                
                GIFUserModel *userModel = [GIFUserModel new];
                userModel.userId = [[gifdata valueForKey:@"user"] valueForKey:@"id"];
                userModel.userName = [[gifdata valueForKey:@"user"] valueForKey:@"username"];
                userModel.avatarUrl = [[gifdata valueForKey:@"user"] valueForKey:@"avatar_url"];
                
                model.user = userModel;
                [dataManager addModel:model];
            }
        } else {
            // show alert controller
        }
    }failure:^(NSURLSessionDataTask *dataTask, NSError *error){
        // show alert controller
    }];

}

@end
