//
//  GIFUrlSessionDataTask.m
//  GIFKA
//
//  Created by sasha ataman on 22.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIFUrlSessionDataTask.h"
#import <AFNetworking/AFNetworking.h>

@interface GIFUrlSessionDataTask ()
{
    NSURLSession *session;
}
@end

@implementation GIFUrlSessionDataTask

- (void)getImageData:(NSString *)url completition:(void (^)(NSData *, NSMutableURLRequest *))completition
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        completition(data, request);
    }];
    [dataTask resume];

}

- (void)cancelTask
{
    [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        
        if (!dataTasks || !dataTasks.count) {
            return;
        }
        for (NSURLSessionTask *task in dataTasks) {
            [task cancel];
        }
    }];

}

@end
