//
//  ResourceLoader.m
//  ResourceLoader
//
//  Created by Keith Lee on 1/6/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "ResourceLoader.h"

@implementation ResourceLoader

@synthesize resourceData;
@synthesize isLoaded;

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
  }
    
    return self;
}

- (BOOL)loadResource:(NSString *)urlString
{
  [self setIsLoaded:FALSE];
  NSURL *url = [NSURL URLWithString:urlString];
  resourceData = [[NSMutableData alloc] init];
  request = [[NSURLRequest alloc]
             initWithURL:url
             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
             timeoutInterval:10];
  urlConnection = [[NSURLConnection alloc] 
                   initWithRequest:request
                   delegate:self];
  
  if (urlConnection)
  {
    return YES;
  }
  else
  {
    return NO;
  }

}


#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection 
  didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
  NSLog(@"Received challenge");
}

- (void)connection:(NSURLConnection *)connection 
  didReceiveResponse:(NSURLResponse *)response
{
  [resourceData setLength:0];
}

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)data
{
  NSLog(@"Received data");
  [resourceData appendData:data];
}

- (void)connection:(NSURLConnection *)connection 
  didFailWithError:(NSError *)error
{
  
  NSLog(@"Connection failed! Error - %@",
        [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSLog(@"Finished loading data");
  
  // Set flag to stop run loop
  [self setIsLoaded:TRUE];
}

@end
