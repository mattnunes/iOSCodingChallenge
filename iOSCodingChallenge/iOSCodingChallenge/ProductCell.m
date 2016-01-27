//
//  ProductCell.m
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "ProductCell.h"
#import "Product.h"
#import "DataService.h"

#pragma mark - Private Interface
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface ProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nullable) Product *product;
@property (nullable) DataService *service;
@property (nullable) NSProgress *imageProgress;

- (void)updateInterfaceWithProduct:(Product  * _Nonnull)product;

@end

#pragma mark - Implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation ProductCell

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)setProduct:(Product *)product service:(DataService *)service;
{
    self.product = product;
    self.service = service;
    [self updateInterfaceWithProduct:[self product]];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)updateInterfaceWithProduct:(Product *)product
{
    self.nameLabel.text = [product name];
    self.priceLabel.text = [NSString stringWithFormat:@"$%.02f", [product.price floatValue]];
    self.descriptionLabel.text = [product itemDescription];
    
    [self.imageProgress cancel];
    self.productImageView.image = nil;
    [self.activityIndicator startAnimating];
    
    // TODO: Figure out why there's a brief flicker even when the image should be cached.
    // Maybe the server isn't setting the correct caching headers?
    self.imageProgress = [self.service getImageWithURL:[product imageURL] completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"Error encountered loading image: %@", error);
            self.productImageView.image = [UIImage imageNamed:@"Alert"];
        }
        else {
            self.productImageView.image = image;
        }
        
        self.imageProgress = nil;
        [self.activityIndicator stopAnimating];
        
    }];
}

@end
