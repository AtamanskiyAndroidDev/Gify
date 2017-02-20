//
//  NSString+SplitString.m
//  Kinopoisk
//
//  Created by sasha ataman on 15.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "NSString+SplitString.h"

@implementation NSString (SplitString)

- (NSString *)splitString:(NSString *)string
{
    NSMutableArray *stringArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"-"]] ;
    [stringArray removeLastObject];
    return [stringArray componentsJoinedByString:@" "];
}

@end
