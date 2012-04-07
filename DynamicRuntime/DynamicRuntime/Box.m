//
//  Box.m
//  DynamicRuntime
//
//  Created by Keith Lee on 1/8/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Box.h"
#import "MessageSwallower.h"

@implementation Box

- (id)init
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
  }
  
  // Use a message swallower to log messages not implemented
  messageSwallower = [[MessageSwallower alloc] init];
    
  return self;
}


- (id)forwardingTargetForSelector:(SEL)sel 
{ 
  return messageSwallower; 
}

@end
