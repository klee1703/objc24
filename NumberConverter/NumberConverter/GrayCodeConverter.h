//
//  GrayCodeConverter.h
//  NumberConverter
//
//  Created by Keith Lee on 1/17/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrayCodeConverter : NSObject
{
  unsigned int grayNumber;
}

@property (readwrite) unsigned int grayNumber;

- (id) initWithBinary:(unsigned int)value;
- (id) initWithGray:(unsigned int)value;

- (void) setFromBinary:(unsigned int)value;

- (unsigned int) toBinary;
- (unsigned int) toGray;

@end
