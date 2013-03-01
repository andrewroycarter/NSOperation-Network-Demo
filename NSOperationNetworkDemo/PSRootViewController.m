//
//  PSRootViewController.m
//  NSOperationNetworkDemo
//
//  Created by Andrew Carter on 2/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import "PSRootViewController.h"

#import "PSHTTPOperation.h"

static NSString *const PSRedditTopStoriesURLString = @"http://www.reddit.com/top.json";

@interface PSRootViewController ()
{
    NSOperationQueue *_operationQueue;
}
@end

@implementation PSRootViewController

#pragma mark - UIViewController Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _operationQueue = [NSOperationQueue new];
    }
    return self;
}

- (void)viewDidLoad
{
    [self getRedditTopStories];
}

#pragma mark - Instance Methods

- (void)getRedditTopStories
{
    NSURL *url = [NSURL URLWithString:PSRedditTopStoriesURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    PSHTTPOperation *operation = [[PSHTTPOperation alloc] initWithRequest:request successHandler:^(NSData *responseData, NSURLResponse *response) {
        
        NSError *parseError;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
        NSAssert(!parseError, @"Failed to parse responseData");
        
        NSLog(@"Top Stories: %@", JSON[@"data"][@"children"]);
        
    } failureHandler:^(NSData *responseData, NSURLResponse *response, NSError *error) {
        
        NSLog(@"Failed to get top stories");
        
    }];
    
    [_operationQueue addOperation:operation];
}

@end
