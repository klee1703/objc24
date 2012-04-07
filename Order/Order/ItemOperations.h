//
//  ItemOperations.h
//  Order
//
//  Created by Keith Lee on 1/4/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemOperations
  // Declared properties
  @property float discount;
  @property float tax;

  // Declared methods
  @optional  
    - (float)applyDiscount;
  @optional
    - (float)getTax;
@end
