//
//  Product.m
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "Product.h"
#import "Constants.h"
#import "NSObject+Types.h"

#pragma mark - Private Interface
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface Product ()

@property (nonnull) NSString *name;
@property (nonnull) NSURL *imageURL;
@property (nonnull) NSNumber *price;
@property (nonnull) NSString *itemDescription;

@end

#pragma mark - Implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation Product

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p, name = %@, imageURL = %@, price = %@, itemDescription = %@>", [self class], self, _name, _imageURL, _price, _itemDescription];
}

@end

#pragma mark - JSONCreatable
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation Product (JSONCreatable)

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
+ (nullable instancetype)fromJSON:(nonnull id)object error:(NSError * _Nullable * _Nullable)error {
    if (![object isDictionary]) {
        if (error != NULL) {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Unable to create Product from server response.",
                                                                                    @"Unable to create Product from server response.")
                                       };
            *error = [NSError errorWithDomain:ErrorDomain code:UnexpectedJSONErrorCode userInfo:userInfo];
        }
        return nil;
    }
    
    Product *product = [[Product alloc] init];
    
    // TODO: Do some type- and nil-checking
    NSDictionary *jsonDictionary = (NSDictionary *)object;
    product.name = [jsonDictionary objectForKey:@"name"];
    product.imageURL = [jsonDictionary objectForKey:@"image"];
    product.price = [jsonDictionary objectForKey:@"price"];
    product.itemDescription = [jsonDictionary objectForKey:@"description"];
    
    return product;
}

@end
