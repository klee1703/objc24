//
//  Carnivora.m
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Carnivora.h"

@implementation Carnivora

@synthesize type;

- (id) init
{
  self = [super init];
  if (self)
  {
    [self setType:@"Mammal"];
  }
  
  return self;
}

- (NSString *) description
{
  return [@"Carnivora, type " stringByAppendingString:[self type]];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.type forKey:@"type"];
}

- (id)initWithCoder:(NSCoder *)coder
{
  if (self = [super init])
  {
    type = [coder decodeObjectForKey:@"type"];
  }
  return self;
}


@end
