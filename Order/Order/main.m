//
//  main.m
//  Order
//
//  Created by Keith Lee on 1/1/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"
#import "Price/Price_OrderItem.h"

int main (int argc, const char * argv[])
{
  // Create an autorelease pool for object management
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  // Create a collection of sample OrderItems
  OrderItem *item1 = [[OrderItem alloc] initWithComment:@"Hamburger" price:3.50];
  OrderItem *item2 = [[OrderItem alloc] initWithComment:@"Hot dog" price:2.75];
  OrderItem *item3 = [[OrderItem alloc] initWithComment:@"Slice of pizza" price:2.50];
  NSArray *items = [NSArray arrayWithObjects:item1, item2, item3, nil];
  
  // Display a summary of the OrderItems
  NSLog(@"You ordered %lu items, your order is:", [items count]);
  for (id item in items) 
  {
    NSInteger quantity = [items indexOfObject:item];
    NSLog(@"\t%i %@ for $%.2f", (int)(quantity+1) , [item comment], 
          [item computePrice:(int)(quantity+1)]);
  }
  NSLog(@"Your order will be right up, thanks!");
  
  // Create another item, this time apply a tax (5%) and a discount (10%)
  OrderItem *item4 = [[OrderItem alloc] initWithComment:@"Apple pie" price:10.00];
  [item4 setDiscount:0.10];
  [item4 setTax:0.05];
  
  // Display item with discount and tax
  float discountedCost = [item4 price] - ([item4 price] * [item4 discount]);
  float totalCost = discountedCost + (discountedCost * [item4 tax]); 
  NSLog(@"You also ordered 1 %@.  Your cost for this item with tax and discount is $%.2f", 
        [item4 comment], totalCost);

  // Release allocated objects
  for (id item in items)
  {
    [item release];
  }
  [item4 release];
  
  [pool drain];
  return 0;
}

