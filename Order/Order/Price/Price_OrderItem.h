//
//  Price_OrderItem.h
//  Order
//
//  Created by Keith Lee on 1/2/12.
//  Copyright 2012 Personal. All rights reserved.
//
#import "OrderItem.h"


@interface OrderItem (Price)
- (float) computePrice: (int) quantity;

@end
