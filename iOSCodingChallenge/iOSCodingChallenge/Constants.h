//
//  Constants.h
//  iOSCodingChallenge
//
//  Created by Matthew Nunes on 1/26/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h

#define ErrorDomain @"iOSCodingChallengeErrorDomain"

typedef NS_ENUM(NSUInteger, ErrorCode) {
    InvalidURLErrorCode,
    
    UnexpectedJSONErrorCode
};

#endif /* Constants_h */
