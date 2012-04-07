//
//  OrderItem.h
//  Order
//
//  Created by Keith Lee on 1/1/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemOperations.h"

@interface OrderItem : NSObject <ItemOperations>
{
@private NSString *comment;
@private float price;
  
// Properties from ItemOperations protocol
@private float discount;
@private float tax;
}

@property (nonatomic, retain) NSString *comment;
@property float price;

- (id) initWithComment:(NSString *)cmt price:(float)cost;

@end
