//
//  JSONCreatable.h
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONCreatable <NSObject>

+ (nullable instancetype)fromJSON:(nonnull id)object error:(NSError * _Nullable * _Nullable)error;

@end
