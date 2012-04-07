//
//  GreetingRunner.m
//  GreetingRunner
//
//  Created by Keith Lee on 2/2/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "GreetingRunner.h"

@implementation GreetingRunner

@synthesize salutation;

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
  }
  
  return self;
}

- (NSString *) getGreeting: (NSString *)user
{
  return [NSString stringWithFormat:@"%@, %@", [self salutation], user];
}

@end
