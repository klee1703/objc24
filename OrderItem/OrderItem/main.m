//
//  main.m
//  OrderItem
//
//  Created by Keith Lee on 1/21/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"

int main (int argc, const char * argv[])
{
  @autoreleasepool 
  {
    OrderItem *item1 = [[OrderItem alloc] initWithComment:@"Hamburger" price:3.50];
    OrderItem *item2 = [[OrderItem alloc] initWithComment:@"Hot dog" price:2.75];
    NSLog(@"First item is a %@ for $%.2f", item1.comment, item1.price);
    NSLog(@"Second item is a %@ for $%.2f", item2.comment, item2.price);
  }
  return 0;
}

