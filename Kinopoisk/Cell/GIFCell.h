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
#import "CustomAvatar.h"

@interface GIFCell : UITableViewCell
{
    NSString *originalImage;
}

- (void)setupCell:(GIFModel *)gifImage;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gif;
@property (weak, nonatomic) IBOutlet CustomAvatar *avatar;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *slug;

@end
