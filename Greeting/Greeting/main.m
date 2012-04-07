//
//  main.m
//  COCin24Hours_1
//
//  Created by Keith Lee on 12/19/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Greeting.h"

int main (int argc, const char * argv[])
{
  NSString * const DEFAULT_SALUTATION = @"Hello";
  NSString *const DEFAULT_USER = @"World";
  
  // Create an autorelease pool for object management
  @autoreleasepool 
  {  
    // Retrieve command line arguments
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *salut = [defaults stringForKey:@"s"];
    NSString *user = [defaults stringForKey:@"u"];
    
    if (salut == nil)
    {
      salut = DEFAULT_SALUTATION;
    }
    if (user == nil)
    {
      user = DEFAULT_USER;
    }

    // Create a Greeting instance
    Greeting *greeter = [[Greeting alloc] init];
    
    // Set the salutation property
    [greeter setSalutation:salut];
    
    // Retrieve a greeting for the user
    NSLog(@"%@!", [greeter getGreeting:user]);
  }
  return 0;
}

