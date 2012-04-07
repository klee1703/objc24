//
//  Lion.m
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Lion.h"

@implementation Lion

@synthesize subspecies;

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
    [self setSubspecies:@"West African"];
  }
  
  return self;
}

- (NSString *) description
{
  NSString *desc = [NSString stringWithFormat:@"Lion, subspecies %@:", self.subspecies];
  return [desc stringByAppendingString:[super description]];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [super encodeWithCoder:coder];
  [coder encodeObject:self.subspecies forKey:@"subspecies"];
}

- (id)initWithCoder:(NSCoder *)coder
{
  if ((self = [super initWithCoder:coder]))
  {
    subspecies = [coder decodeObjectForKey:@"subspecies"];
  }
  return self;
}


@end
