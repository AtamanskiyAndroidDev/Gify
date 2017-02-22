//
//  GIFUrlSessionDataTask.h
//  GIFKA
//
//  Created by sasha ataman on 22.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

@interface GIFUrlSessionDataTask : NSObject

- (void)getImageData:(NSString *)url completition:(void (^)(NSData *data, NSMutableURLRequest *request))completition;
- (void)cancelTask;

@end
