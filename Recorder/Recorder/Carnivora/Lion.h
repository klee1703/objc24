//
//  Lion.h
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Felidae.h"

@interface Lion : Felidae
{
@private NSString *subspecies;
}

@property (readwrite, strong) NSString *subspecies;

@end
