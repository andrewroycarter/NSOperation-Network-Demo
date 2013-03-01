//
//  PSHTTPOperation.h
//  NSOperationNetworkDemo
//
//  Created by Andrew Carter on 2/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PSHTTPSuccessHandler)(NSData *responseData, NSURLResponse *response);
typedef void (^PSHTTPFailureHandler)(NSData *responseData, NSURLResponse *response, NSError *error);

@interface PSHTTPOperation : NSOperation

@property (nonatomic, copy) NSURLRequest *request;

- (id)initWithRequest:(NSURLRequest *)request;

- (id)initWithRequest:(NSURLRequest *)request
       successHandler:(PSHTTPSuccessHandler)successHandler
       failureHandler:(PSHTTPFailureHandler)failureHandler;

- (void)setSuccessHandler:(PSHTTPSuccessHandler)successHandler;

- (void)setFailureHandler:(PSHTTPFailureHandler)failureHandler;

@end
