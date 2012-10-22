//
//  AsyncHTTP.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "AsyncHTTP.h"

@implementation AsyncHTTP

@synthesize engine;

+ (AsyncHTTP *)sharedAsync{
    static dispatch_once_t pred;
    static AsyncHTTP *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[AsyncHTTP alloc] init];
    });
    
    return shared;
}

- (AsyncHTTP *) init{
    self = [super init];
    if(self){
        engine = [[MKNetworkEngine alloc]initWithHostName:@"sprint.ly" apiPath:@"api" customHeaderFields:nil];
        
    }
    return self;
}

- (void) makeGetRequestWithPath:(NSString *)requestPath andParameters:(NSDictionary *)paramsDict withCallback:(void(^)(MKNetworkOperation *completedOp)) callback{
    MKNetworkOperation *request = [engine operationWithPath:requestPath params:(NSMutableDictionary *)paramsDict httpMethod:@"GET" ssl:YES];
    [request setUsername:SPRINTLY_EMAIL password:SPRINTLY_API_KEY];
    
    [request onCompletion:^(MKNetworkOperation *completedOp){
        callback(completedOp);
    } onError:^(NSError *e){
        //DLog(@"failure: %@",e);
    }];
    
    [engine enqueueOperation:request];
}

@end
