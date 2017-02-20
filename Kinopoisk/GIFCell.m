//
//  KPCell.m
//  Kinopoisk
//
//  Created by sasha ataman on 13.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "GIFCell.h"
#import "FLAnimatedImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+SplitString.h"

// test
#import <AFNetworking/AFNetworking.h>

@implementation GIFCell

FLAnimatedImage *image;
NSURLSession *session;

- (void)awakeFromNib
{
    [super awakeFromNib];
    // gif image set corner radius
    _gif.layer.borderWidth = 3.0f;
    _gif.layer.borderColor = [[UIColor whiteColor] CGColor];
    _gif.layer.cornerRadius = 5.0f;
}

- (void)setupCell:(GIFModel *)gifImage
{
    originalImage = gifImage.originalImage;
    if ([[gifImage user] avatarUrl] != NULL) {
        NSURL *userAvatarUrl = [[NSURL alloc] initWithString:[[gifImage user] avatarUrl]];
        [_avatar sd_setImageWithURL:userAvatarUrl placeholderImage:[UIImage imageNamed:@"default-user"]];
    } else {
        _avatar.image = [UIImage imageNamed:@"default-user"];
    }
    if ([[gifImage user] userName] != NULL) {
        _userName.text = [[gifImage user] userName];
    } else {
        _userName.text = @"NONE";
    }
    _date.text = gifImage.date;
    _slug.text = [[NSString alloc] splitString:[gifImage slug]];
    [self someRequest];
}

- (void)prepareForReuse
{
    [self cancelTasks];
    NSLog(@"reused");
}

- (void)someRequest
{
    [self startLoading];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:originalImage]];
    session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        image = [FLAnimatedImage animatedImageWithGIFData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image == NULL) {
                [self someRequest];
            } else {
                if ([[request URL].absoluteString isEqualToString: originalImage]) {
                    _gif.animatedImage = image;
                } else {
                    [self someRequest];
                }
            }
        });
    }];
    [dataTask resume];

}

- (void)cancelTasks
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

- (void)startLoading
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        FLAnimatedImage *loadingImage =
        [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"gif"]]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Main
            _gif.animatedImage = loadingImage;
        });
    });
}


@end
