//
//  Greeting.m
//  Greeting
//
//  Created by Keith Lee on 12/30/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Greeting.h"

@implementation Greeting

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
  }
  
  return self;
}

@synthesize salutation;

- (NSString *) getGreeting: (NSString *)user
{
  return [NSString stringWithFormat:@"%@, %@", [self salutation], user];
}


@end
