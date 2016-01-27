//
//  ProductCell.h
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product, DataService;

@interface ProductCell : UITableViewCell

- (void)setProduct:(Product * _Nonnull)product service:(DataService * _Nonnull)service;

@end
