//
//  Greeting.h
//  Greeting
//
//  Created by Keith Lee on 12/30/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Greeting : NSObject
{
@private NSString *salutation;
}

@property (strong) NSString *salutation;

- (NSString *) getGreeting: (NSString *) user;
@end
