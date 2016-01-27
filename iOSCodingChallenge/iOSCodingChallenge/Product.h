//
//  Product.h
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONCreatable.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface Product : NSObject

@property (readonly, nonnull) NSString *name;
@property (readonly, nonnull) NSURL *imageURL;
@property (readonly, nonnull) NSNumber *price;
@property (readonly, nonnull) NSString *itemDescription;

@end

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface Product (JSONCreatable) <JSONCreatable>

@end
