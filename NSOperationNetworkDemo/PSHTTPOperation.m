//
//  PSHTTPOperation.m
//  NSOperationNetworkDemo
//
//  Created by Andrew Carter on 2/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import "PSHTTPOperation.h"

@interface PSHTTPOperation () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *_connection;
    NSMutableData *_responseData;
    NSURLResponse *_response;
    PSHTTPSuccessHandler _successHandler;
    PSHTTPFailureHandler _failureHandler;
}

@property (nonatomic, readwrite, getter = isFinished) BOOL finished;

@end

@implementation PSHTTPOperation

#pragma mark - NSOperation Overrides

- (void)main
{    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    _connection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:NO];
    [_connection scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
    [_connection start];
    
    while (![self isFinished] && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
    {
        
    };
}

#pragma mark - Instance Methods

- (void)setSuccessHandler:(PSHTTPSuccessHandler)successHandler
{
    _successHandler = [successHandler copy];
}

- (void)setFailureHandler:(PSHTTPFailureHandler)failureHandler
{
    _failureHandler = [failureHandler copy];
}

- (id)initWithRequest:(NSURLRequest *)request successHandler:(PSHTTPSuccessHandler)successHandler failureHandler:(PSHTTPFailureHandler)failureHandler
{
    self = [super init];
    if (self)
    {
        [self setRequest:request];
        [self setSuccessHandler:successHandler];
        [self setFailureHandler:failureHandler];
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request
{
    return [self initWithRequest:request successHandler:nil failureHandler:nil];
}

#pragma mark - NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_failureHandler)
    {
        _failureHandler(_responseData, _response, error);
    }
    [self setFinished:YES];
}

#pragma mark - NSURLConnectionDataDelegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)_response;
    BOOL success = [[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)] containsIndex:[response statusCode]];
    
    if (success && _successHandler)
    {
        _successHandler(_responseData, _response);
    }
    else if (!success && _failureHandler)
    {
        _failureHandler(_responseData, _response, nil);
    }
    
    [self setFinished:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [NSMutableData new];
    _response = response;
}

@end
