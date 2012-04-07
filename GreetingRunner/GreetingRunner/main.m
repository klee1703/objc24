//
//  main.m
//  GreetingRunner
//
//  Created by Keith Lee on 2/2/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "GreetingRunner.h"

void aurevoir(id self, SEL _cmd);
void aurevoir(id self, SEL _cmd)
{
  NSLog(@"Au-revoir!");
}


int main (int argc, const char * argv[])
{
  @autoreleasepool 
  {
    NSString * const DEFAULT_SALUTATION = @"Hello";
    NSString * const DEFAULT_USER = @"World";
    NSString * const DEFAULT_METHOD_NAME = @"getGreeting:";
    
    if ((argc > 1) && (argv[1][0] == '-'))
    {
      switch (argv[1][1])
      {
        case 'h':
          printf("\nUsage: runner -s [Salutation] -u [User] -m [Method name]");
          return 0;
        default:
          break;
      }
    }

    // Retrieve command line arguments
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *salut = [defaults stringForKey:@"s"];
    NSString *user = [defaults stringForKey:@"u"];
    NSString *methodName = [defaults stringForKey:@"m"];
    
    if (salut == nil)
    {
      salut = DEFAULT_SALUTATION;
    }
    if (user == nil)
    {
      user = DEFAULT_USER;
    }
    if (methodName == nil)
    {
      methodName = DEFAULT_METHOD_NAME;
    }
    
    // Create a GreetingRunner instance
    GreetingRunner *runner = [[GreetingRunner alloc] init];
    SEL dynamicMethod = NSSelectorFromString(methodName);
    
    // Set the salutation property
    [runner setSalutation:salut];
    
    // Perform dynamic runtime functions (introspection, invoke method)
    NSLog(@"Class name: %s", class_getName([runner class]));
    if (class_respondsToSelector([runner class], dynamicMethod))
    {
      NSLog(@"%s responds to selector %@", class_getName([runner class]), methodName);
      
      // Retrieve a greeting for the user (eliminate compiler warning for dynamic method!)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      id result = [runner performSelector:dynamicMethod withObject:user];
#pragma clang diagnostic pop
      NSLog(@"%@!", result);
      
      // Now say goodbye with a dynamically added method
      SEL goodbye = NSSelectorFromString(@"aurevoir:");
      class_addMethod([runner class], goodbye, (IMP)aurevoir, "v@:");
      if (class_respondsToSelector([runner class], goodbye))
      {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [runner performSelector:goodbye];
#pragma clang diagnostic pop
      }
      else
      {
        NSLog(@"%s does not respond to selector %@", class_getName([runner class]), NSStringFromSelector(goodbye));
      }
    }
    else
    {
      NSLog(@"%s does not respond to selector %@", class_getName([runner class]), methodName);
    }
  }
  return 0;
}

