//
//  DataService.h
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Product;

@interface DataService : NSObject

/**
 * Gets a list of products from the server and returns them in the completion block.
 * - parameter: completion The completion block, with an `NSArray` of `Product`s, and
 *  an `NSError` containing information about a failure.
 */
- (NSProgress * _Nullable)getProducts:(void (^ _Nonnull)(NSArray<Product *> * _Nullable products, NSError * _Nullable error))completion;

- (NSProgress * _Nullable)getImageWithURL:(NSURL * _Nonnull)url completion:(void (^ _Nonnull)(UIImage * _Nullable image, NSError * _Nullable error))completion;

@end
