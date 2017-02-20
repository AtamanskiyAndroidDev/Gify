//
//  GIFSegmentedControl.m
//  Kinopoisk
//
//  Created by sasha ataman on 20.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//
#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>
#import "GIFSegmentedControl.h"

@interface GIFSegmentedControl ()

@end

NSMutableArray *labelArray;
UIView *thumbView;

@implementation GIFSegmentedControl

@synthesize items = _items;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedLabelColor = _selectedLabelColor;
@synthesize unselectedLabelColor = _unselectedLabelColor;
@synthesize thumbColor = _thumbColor;
@synthesize borderColor = _borderColor;

- (void)setItems:(NSArray *)items
{
    if (items != _items) {
        _items = items;
        [self setupLabels];
        [self setNeedsDisplay];
    }
}

- (NSArray *)items
{
    if (!_items) {
        NSArray *defaultItems = [NSArray arrayWithObjects:@"item1", @"item2", @"item3", nil];
        return defaultItems;
    } else {
        return _items;
    }
}

- (NSInteger )selectedIndex
{
    if (!_selectedIndex) {
        return 0;
    } else {
        return _selectedIndex;
    }
}

- (void)setSelectedIndex:(NSInteger )selectedIndex
{
    if (selectedIndex != _selectedIndex) {
        _selectedIndex = selectedIndex;
        [self setNeedsDisplay];
    }
}

- (UIColor *)selectedLabelColor
{
    if (!_selectedLabelColor) {
        return [UIColor blackColor];
    } else {
        return _selectedLabelColor;
    }
}

- (void)setSelectedLabelColor:(UIColor *)selectedLabelColor
{
    if (selectedLabelColor != _selectedLabelColor) {
        _selectedLabelColor = selectedLabelColor;
        [self selectedLabelColor];
        [self setNeedsDisplay];
    }
}

- (UIColor *)unselectedLabelColor
{
    if (!_unselectedLabelColor) {
        return [UIColor blackColor];
    } else {
        return _unselectedLabelColor;
    }
}

- (void)setUnselectedLabelColor:(UIColor *)unselectedLabelColor
{
    if (unselectedLabelColor != _unselectedLabelColor) {
        _unselectedLabelColor = unselectedLabelColor;
        [self selectedLabelColor];
        [self setNeedsDisplay];
    }
}

- (UIColor *)thumbColor
{
    if (!_thumbColor) {
        return [UIColor whiteColor];
    } else {
        return _thumbColor;
    }
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    if (thumbColor != _thumbColor) {
        _thumbColor = thumbColor;
        [self selectedLabelColor];
        [self setNeedsDisplay];
    }
}

- (UIColor *)borderColor
{
    if (!_borderColor) {
        return [UIColor whiteColor];
    } else {
        return _borderColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self layer].borderColor = borderColor.CGColor;
        [self setNeedsDisplay];
    }
}

- (void)commonInit
{
    labelArray = [[NSMutableArray alloc] init];
    thumbView = [[UIView alloc] init];
    [self setupView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.layer.cornerRadius = [self frame].size.height / 2;
    self.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    self.layer.borderWidth = 2.0;
    
    self.backgroundColor = [UIColor clearColor];
    [self setupLabels];
    [self addIndividualItemConstraints:labelArray mainView:self padding:0];
    [self insertSubview:thumbView atIndex:0];
}

- (void)setupLabels
{
    for (UILabel *label in labelArray) {
        [label removeFromSuperview];
    }
    
    [labelArray removeAllObjects];
    
    for (int index = 1; index<=self.items.count; index++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
        label.text = self.items[index - 1];
        label.backgroundColor = [UIColor clearColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.font = [UIFont fontWithName:@"Avenir-Black" size:15];
        label.textColor = index == 1 ? self.selectedLabelColor : self.unselectedLabelColor;
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:label];
        [labelArray addObject:label];
    }
    
    [self addIndividualItemConstraints:labelArray mainView:self padding:0];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect selectFrame = self.bounds;
    double newWidth = CGRectGetWidth(selectFrame) / (CGFloat) self.items.count;
    selectFrame.size.width = newWidth;
    thumbView.frame = selectFrame;
    thumbView.backgroundColor = self.thumbColor;
    thumbView.layer.cornerRadius = thumbView.frame.size.height / 2;
    
    [self displayNewSelectedIndex];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint location = [touch locationInView:self];
    NSInteger calculatedIndex = -1;
    for (NSInteger i=0; i<labelArray.count; i++) {
        UILabel *item = [labelArray objectAtIndex:i];
        if (CGRectContainsPoint(item.frame, location)) {
            calculatedIndex = i;
        }
    }
    
    if (calculatedIndex != -1) {
        self.selectedIndex = calculatedIndex;
        [self displayNewSelectedIndex];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    return false;
}

- (void)displayNewSelectedIndex{
    for (NSInteger i=0; i<labelArray.count; i++) {
        UILabel *item = [labelArray objectAtIndex:i];
        item.textColor = self.unselectedLabelColor;
    }
    UILabel *label = [labelArray objectAtIndex:(NSUInteger) self.selectedIndex];
    label.textColor = self.selectedLabelColor;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options: UIViewAnimationOptionTransitionNone animations:^ {
        thumbView.frame = label.frame;
    } completion:nil];
}

- (void)addIndividualItemConstraints:(NSArray*)items mainView:(UIView*)mainView padding:(CGFloat)padding
{
    //NSArray *constraints = mainView.constraints;
    
    for(NSInteger index=0;index<items.count;index++) {
        UIView *button = [items objectAtIndex:index];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint *rightConstraint;
        if (index == items.count-1) {
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1.0 constant: -padding];
        } else {
            NSString *nextButton = [items objectAtIndex:index+1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nextButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-padding];
        }
        
        NSLayoutConstraint *leftConstraint;
        
        if (index == 0) {
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:padding];
        } else {
            NSString *prevButton = items[index-1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:prevButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding];
            
            NSString *firstItem = [items objectAtIndex:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:firstItem attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
            [mainView addConstraint:widthConstraint];
        }
        NSArray *constraintsArray = [NSArray arrayWithObjects:topConstraint, bottomConstraint, rightConstraint, leftConstraint, nil];
        [mainView addConstraints:constraintsArray];
    }
}

- (void)setSelectedColors
{
    for (UILabel *item in labelArray) {
        item.textColor = self.unselectedLabelColor;
    }
    
    if (labelArray.count > 0) {
        UILabel *firstLabel = [labelArray objectAtIndex:0];
        firstLabel.textColor = self.selectedLabelColor;
    }
    
    thumbView.backgroundColor = self.thumbColor;
}

@end
