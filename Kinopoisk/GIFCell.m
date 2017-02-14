//
//  KPCell.m
//  Kinopoisk
//
//  Created by sasha ataman on 13.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "GIFCell.h"
#import "FLAnimatedImage.h"

@implementation GIFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCell: (GIFModel *) gifImage{
    NSString *originalImage = gifImage.originalImage;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString: originalImage]]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Main
                _gif.animatedImage = image;
        });
    });
}

- (void) stopAnimated {
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
