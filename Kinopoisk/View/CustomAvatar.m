//
//  CustomAvatar.m
//  Kinopoisk
//
//  Created by sasha ataman on 15.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CustomAvatar.h"
#import "UIView+CircularView.h"

@interface CustomAvatar ()

@end

@implementation CustomAvatar

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self applyRounding:RoundingModeCircle];
}

@end
