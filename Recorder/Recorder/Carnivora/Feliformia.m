//
//  Feliformia.m
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Feliformia.h"

@implementation Feliformia

- (id)init
{
    self = [super init];
    if (self) 
    {
      // Initialization code here.
    }
    
    return self;
}

- (NSString *) description
{
  return [@"Feliformia:" stringByAppendingString:[super description]];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [super encodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)coder
{
  if (self = [super initWithCoder:coder])
  {
  }
  return self;
}


@end
