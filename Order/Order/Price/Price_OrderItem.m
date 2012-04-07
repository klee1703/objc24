//
//  Price_OrderItem.m
//  Order
//
//  Created by Keith Lee on 1/2/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "OrderItem.h"
#import "Price_OrderItem.h"

@implementation OrderItem (Price)
- (float) computePrice: (int) quantity
{
  return price * quantity;
}

@end
