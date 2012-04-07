//
//  GreetingRunner.h
//  GreetingRunner
//
//  Created by Keith Lee on 2/2/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GreetingRunner: NSObject
@property (strong) NSString *salutation;

- (NSString *) getGreeting: (NSString *) user;
@end
