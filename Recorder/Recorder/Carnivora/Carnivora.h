//
//  Carnivora.h
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Carnivora: NSObject <NSCoding>
{
@private NSString *type;
}

@property (readwrite, copy) NSString *type;
@end
