//
//  Herbivore.m
//  DynamicRuntime
//
//  Created by Keith Lee on 1/8/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Herbivore.h"

@implementation Herbivore

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
  }
    
  return self;
}


- (NSString *)getDiet
{
  return @"Plants";
}

@end
