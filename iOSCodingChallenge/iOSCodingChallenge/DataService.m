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
- (void)getProducts:(void (^ _Nonnull)( NSArray * _Nullable products, NSError * _Nullable error))completion
{
    // If the URL fails to parse, then we fail out immediately.
    NSURL *url = [NSURL URLWithString:@"https://public.touchofmodern.com/ioschallenge.json"];
    if (url == nil) {
        NSError *error = [NSError errorWithDomain:ErrorDomain
                                             code:InvalidURLErrorCode
                                         userInfo:nil];
        completion(nil, error);
        return; // - - - - EARLY RETURN - - - -
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
        return; // - - - - EARLY RETURN - - - -
    }
    
    // Make up the JSON Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:bodyData];
    
    // Dispatch the request and handle it with a completion block.
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
    [dataTask resume];
}



@end

