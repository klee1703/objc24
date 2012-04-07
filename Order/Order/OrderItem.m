//
//  OrderItem.m
//  Order
//
//  Created by Keith Lee on 1/1/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

@synthesize comment;
@synthesize price;
@synthesize discount;
@synthesize tax;

- (id)initWithComment:(NSString *)cmt price:(float)cost
{
  self = [super init];
  if (self) 
  {
    [self setComment:cmt];
    [self setPrice:cost];
  }
    
  return self;
}

- (float)applyDiscount
{
  return ([self price] * [self discount]);
}

- (float)getTax
{
  return ([self price] * [self tax]);
}

- (void)dealloc
{
  [comment release];
  [super dealloc];
}

@end
