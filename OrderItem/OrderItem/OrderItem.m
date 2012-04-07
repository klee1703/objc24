//
//  OrderItem.m
//  OrderItem
//
//  Created by Keith Lee on 1/21/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

@synthesize comment, price;

- (id) initWithComment:(NSString *)cmt price:(float)cost
{
  self = [super init];
  if (self)
  {
    [self setComment:cmt];
    [self setPrice:cost];
  }
  return self;
}
@end
