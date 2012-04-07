//
//  FixedPointConverter.m
//  NumberConverter
//
//  Created by Keith Lee on 1/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "FixedPointConverter.h"
#include <math.h>

#define INTEGER_BITS      16
#define INTEGER_MASK      0x7FFF8000
#define FRACTION_BITS     15
#define FRACTION_MASK     0x00007FFF
#define FRACTION_DIVISOR	32768.0
#define SIGN_MASK         0x80000000
#define MAX_FLOAT         65535

@interface FixedPointConverter()
- (float) computeFraction:(long int)fBits;
- (void) computeFloatValue;
@end

@implementation FixedPointConverter

@synthesize integerBits;
@synthesize fractionBits;
@synthesize sign;
@synthesize floatNumber;

- (id) initWithFixedPointNumber:(long int)value
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
    [self setFromFixed:value];
  }
  
  return self;
}

- (id) initWithFloatingPointNumber:(float)value
{
  self = [super init];
  if (self) 
  {
    // Initialization code here.
    [self setFromFloat:value];
  }
  
  return self;
}

- (void) computeFloatValue
{
  self.floatNumber = self.integerBits + [self computeFraction:self.fractionBits];
  if (sign)
  {
    self.floatNumber *= -1.0;
  }
}

- (float) computeFraction:(long int)fBits
{
  return ((float)fBits / FRACTION_DIVISOR);
}

- (void) setFromFixed:(long int)value
{
  self.fractionBits = value & FRACTION_MASK;
  self.integerBits = (value & INTEGER_MASK) >> FRACTION_BITS;
  self.sign = (value & SIGN_MASK) >> (INTEGER_BITS + FRACTION_BITS);
  [self computeFloatValue];
}

- (void) setFromFloat:(float)value
{
  // Use ANSI-C modf function to get integer and fractional parts of value
  double integerPart;
  double fractionalPart = modf(value, &integerPart);
  self.integerBits = (float)fabs(integerPart);
  self.fractionBits = (1 << FRACTION_BITS) * (float)fabs(fractionalPart);
  self.sign = (value < 0.0);
  
  // Throw an exception if the whole part value exceeds the maximum (65535)
  if (self.integerBits > MAX_FLOAT)
  {
    NSException *nsex = [NSException
                         exceptionWithName:@"NumberSizeException"
                         reason:@"Number magnitude exceeds maximum supported (65535)"
                         userInfo:nil];
    @throw nsex;
  }
  
  [self computeFloatValue];
}

- (float) toFloat
{
  return self.floatNumber;
}

- (NSString *) toFixedPointString
{
  // Combine bits of number to create hex value of fixed point number
  long int iBits = (self.sign << (INTEGER_BITS + FRACTION_BITS)) 
  | (self.integerBits << FRACTION_BITS) 
  | self.fractionBits;
  return [[NSString alloc] initWithFormat:@"0x%X", iBits];
}

@end
