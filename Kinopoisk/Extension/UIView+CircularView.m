//
//  UIView+CircularView.m
//  Kinopoisk
//
//  Created by sasha ataman on 15.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "UIView+CircularView.h"

@implementation UIView (CircularView)

- (void)applyRounding:(RoundingMode)mode
{
    const CGFloat radius = [self radiusWith:mode];
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)radiusWith:(RoundingMode)mode
{
    switch (mode) {
        case RoundingModeCircle:
            return self.bounds.size.width / 2.0;
        case RoundingModeWithRadius:
            return 0;
    }
}

@end
