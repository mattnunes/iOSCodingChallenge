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

@property NSProgress *imageProgress;

- (void)updateInterfaceWithProduct:(Product  * _Nonnull)product;

@end

#pragma mark - Implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation ProductCell

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)setProduct:(Product *)product
{
    [self willChangeValueForKey:@"product"];
    _product = product;
    [self didChangeValueForKey:@"product"];
    
    [self updateInterfaceWithProduct:_product];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)updateInterfaceWithProduct:(Product *)product
{
    self.nameLabel.text = [self.product name];
    self.priceLabel.text = [NSString stringWithFormat:@"$%.02f", [self.product.price floatValue]];
    self.descriptionLabel.text = [self.product itemDescription];
    
    [self.imageProgress cancel];
    self.productImageView.image = nil;
    [self.activityIndicator startAnimating];
    
    self.imageProgress = [[DataService new] getImageWithURL:[self.product imageURL] completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        self.productImageView.image = image;
        [self.activityIndicator stopAnimating];
    }];
}

@end
