//
//  GIFSegmentedControl.h
//  Kinopoisk
//
//  Created by sasha ataman on 20.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//
#import "UIKit/UIKit.h"

IB_DESIGNABLE
@interface GIFSegmentedControl : UIControl

@property (nonatomic) NSArray *items;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) IBInspectable UIColor* selectedLabelColor;
@property (nonatomic) IBInspectable UIColor* unselectedLabelColor;
@property (nonatomic) IBInspectable UIColor* thumbColor;
@property (nonatomic) IBInspectable UIColor* borderColor;

@end
