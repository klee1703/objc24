//
//  FixedPointConverter.h
//  NumberConverter
//
//  Created by Keith Lee on 1/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixedPointConverter : NSObject
{
  long int integerBits;
  long int fractionBits;
  BOOL sign;
  float floatNumber;
}

@property (readwrite) long int integerBits;
@property (readwrite) long int fractionBits;
@property (readwrite) BOOL sign;
@property (readwrite) float floatNumber;

- (id) initWithFixedPointNumber:(long int)value;
- (id) initWithFloatingPointNumber:(float)value;

- (void) setFromFixed:(long int)value;
- (void) setFromFloat:(float)value;

- (float) toFloat;
- (NSString *) toFixedPointString;

@end
