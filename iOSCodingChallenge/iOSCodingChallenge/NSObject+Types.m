//
//  NSObject+Types.m
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "NSObject+Types.h"

@implementation NSObject (Types)

- (BOOL)isDictionary
{
    return [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]];
}

@end
