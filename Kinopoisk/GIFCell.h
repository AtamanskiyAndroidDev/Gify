//
//  KPCell.h
//  Kinopoisk
//
//  Created by sasha ataman on 13.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
#import "GIFModel.h"

@interface GIFCell : UITableViewCell
- (void)setupCell: (GIFModel *) gifImage;
- (void) stopAnimated;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gif;

@end
