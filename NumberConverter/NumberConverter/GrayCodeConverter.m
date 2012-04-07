//
//  GrayCodeConverter.m
//  NumberConverter
//
//  Created by Keith Lee on 1/17/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "GrayCodeConverter.h"

@implementation GrayCodeConverter

@synthesize grayNumber;

- (id) initWithBinary:(unsigned int)value
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
    [self setFromBinary:value];
  }
  
  return self;
}

- (id) initWithGray:(unsigned int)value
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
    [self setGrayNumber:value];
  }
  
  return self;
}

- (void) setFromBinary:(unsigned int)value
{
  self.grayNumber = (value >> 1) ^ value;
}

- (unsigned int) toGray
{
  return self.grayNumber;
}

- (unsigned int) toBinary
{
  unsigned int value = self.grayNumber ^ (self.grayNumber >> 16);
  value ^= (value >> 8);
  value ^= (value >> 4);
  value ^= (value >> 2);
  value ^= (value >> 1);
  return value;
}

@end
