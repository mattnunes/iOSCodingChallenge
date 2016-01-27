//
//  DataService.m
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "Product.h"
#import "Constants.h"
#import "DataService.h"
#import "JSONCreatable.h"

#pragma mark - Private Interface
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface DataService ()

@property NSURLSession *session;

- (NSProgress * _Nonnull)submitRequest:(NSURLRequest *)request completion:(void (^ _Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;

@end

#pragma mark - Implementation
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation DataService

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSProgress * _Nonnull)submitRequest:(NSURLRequest *)request completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion
{
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:1];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [progress setCompletedUnitCount:1];
            completion(data, response, error);
        });

    }];
    
    [progress setCancellationHandler:^{
        [task cancel];
    }];
    
    [task resume];
    
    return progress;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSProgress * _Nullable)getProducts:(void (^ _Nonnull)(NSArray<Product *> * _Nullable products, NSError * _Nullable error))completion
{
    // If the URL fails to parse, then we fail out immediately.
    NSURL *url = [NSURL URLWithString:@"https://public.touchofmodern.com/ioschallenge.json"];
    if (url == nil) {
        NSError *error = [NSError errorWithDomain:ErrorDomain
                                             code:InvalidURLErrorCode
                                         userInfo:nil];
        completion(nil, error);
        return nil; // - - - - EARLY RETURN - - - -
    }
    
    // Generate the body data (requestDate: yyyy-mm-dd)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary *bodyDictionary = @{@"requestDate": dateString};
    

    // Generate the body as JSON data
    NSError *jsonError = nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDictionary
                                                       options:0
                                                         error:&jsonError];
    if (jsonError != nil) {
        completion(nil, jsonError);
        return nil; // - - - - EARLY RETURN - - - -
    }
    
    // Make up the JSON Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:bodyData];
    
    // Dispatch the request and handle it with a completion block.
    return [self submitRequest:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                completion(nil, error);
            }
            else {
                
                // Attempt to parse the JSON data into an object
                NSError *jsonError = nil;
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                if (jsonError != nil) {
                    completion(nil, jsonError);
                    return; // - - - - EARLY RETURN - - - -
                }
                
                // Then build up an array of the JSON parsed into our model objects
                NSMutableArray *mArray = [NSMutableArray array];
                NSError *parseError = nil;
                
                for (NSDictionary *dict in arr) {
                    
                    Product *product = [Product fromJSON:dict error:&parseError];
                    if (parseError != nil) {
                        completion(nil, parseError);
                        return; // - - - - EARLY RETURN - - - -
                    }
                    
                    [mArray addObject:product];
                    
                }
                
                completion(mArray, nil);
            }
        });
    }];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSProgress * _Nullable)getImageWithURL:(NSURL * _Nonnull)url completion:(void (^ _Nonnull)(UIImage * _Nullable image, NSError * _Nullable error))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"image/jpeg, image/png" forHTTPHeaderField:@"Accept"];
    
    return [self submitRequest:request completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
            return; // - - - - EARLY RETURN - - - -
        }
        else {
            UIImage *image = [UIImage imageWithData:data];
            completion(image, nil);
        }
    }];
}

@end

