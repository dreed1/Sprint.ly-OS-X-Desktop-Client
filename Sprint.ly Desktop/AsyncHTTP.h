//
//  AsyncHTTP.h
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"

//find these in your sprint.ly account page
#define SPRINTLY_EMAIL @"EMAIL GOES HERE"
#define SPRINTLY_API_KEY @"API KEY GOES HERE"

@interface AsyncHTTP : NSObject

@property (nonatomic, strong) MKNetworkEngine *engine;

+ (AsyncHTTP *)sharedAsync;

- (void) makeGetRequestWithPath:(NSString *)requestPath andParameters:(NSDictionary *)paramsDict withCallback:(void(^)(MKNetworkOperation *completedOp)) callback;

@end
