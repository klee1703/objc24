//
//  main.m
//  ResourceLoader
//
//  Created by Keith Lee on 1/6/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceLoader.h"

int main (int argc, const char * argv[])
{
  @autoreleasepool 
  {
    // Create a ResourceLoader
    ResourceLoader *loader = [[ResourceLoader alloc] init];
    NSString *urlString = @"http://www.motupresse.com/index.html";
    bool connected = [loader loadResource:urlString];

    // Create a run loop for loading data from the ResourceLoader.
    // Data from an NSURLConnection must be loaded within the context
    // of a run loop, it will be exited when the load has completed.
    if (connected)
    {
      NSRunLoop *loop = [NSRunLoop currentRunLoop];
      while ((![loader isLoaded]) && 
             ([loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])) 
      {
      }
    
      // Retrieve the data loaded from the resource and display some info on it
      NSMutableData *data = [loader resourceData];
      NSLog(@"Loaded URL %@, number of bytes loaded = %lu", urlString, [data length]);
    }
    else
    {
      NSLog(@"Couldn't make a connection at URL %@", urlString);
    }

  }
  return 0;
}

