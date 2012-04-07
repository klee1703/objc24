//
//  OrderItem.h
//  OrderItem
//
//  Created by Keith Lee on 1/21/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject
{
  @private NSString *comment;
  @private float price;
}

@property (nonatomic, strong) NSString *comment;
@property float price;

- (id) initWithComment:(NSString *)cmt price:(float)cost; 
@end
