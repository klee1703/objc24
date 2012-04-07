//
//  NumberConverterTests.m
//  NumberConverterTests
//
//  Created by Keith Lee on 1/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "NumberConverterTests.h"
#import "FixedPointConverter.h"
#import "GrayCodeConverter.h"

@implementation NumberConverterTests

- (void)setUp
{
  [super setUp];
  
  // Set-up code here.
}

- (void)tearDown
{
  // Tear-down code here.
  
  [super tearDown];
}

- (void)testFixedToFloat
{
  unsigned int fixedValue = 0x80008000;	// Decimal value = -1
  FixedPointConverter *fixedPoint = [[FixedPointConverter alloc] initWithFixedPointNumber:(long)fixedValue];
  STAssertEquals([fixedPoint toFloat], (float)-1.0, 
                 @"Failed, value = %f", [fixedPoint toFloat]);
  
  fixedValue = 0x8000;				// Decimal value = 1
  [fixedPoint setFromFixed:(long)fixedValue];
  STAssertEquals([fixedPoint toFloat], (float)1.0, 
                 @"Failed, value = %f", [fixedPoint toFloat]);
  
  fixedValue = 0x4000;				// Decimal value = 0.5
  [fixedPoint setFromFixed:(long)fixedValue];
  STAssertEquals([fixedPoint toFloat], (float)0.5, 
                 @"Failed, value = %f", [fixedPoint toFloat]);
  
  fixedValue = 0xC1232000;				// Decimal value = -33350.25
  [fixedPoint setFromFixed:(long)fixedValue];
  STAssertEquals([fixedPoint toFloat], (float)-33350.25, 
                 @"Failed, value = %f", [fixedPoint toFloat]);
  
  fixedValue = 0x7fff8000;			// Decimal value = 65535.0
  [fixedPoint setFromFixed:(long)fixedValue];
  STAssertEquals([fixedPoint toFloat], (float)65535.0, 
                 @"Failed, value = %f", [fixedPoint toFloat]);
}

- (void)testFloatToFixed
{
  float floatValue = 32768.0;			// Fixed point value = 0x40000000
  FixedPointConverter *fixedPoint = [[FixedPointConverter alloc] initWithFloatingPointNumber:floatValue];
  STAssertTrue([[fixedPoint toFixedPointString] isEqualToString:@"0x40000000"], 
               @"Test failed, string was %@", [fixedPoint toFixedPointString]);
  
  floatValue = -32768.0;		// Fixed point value = 0xC0000000
  [fixedPoint setFromFloat:floatValue];
  STAssertTrue([[fixedPoint toFixedPointString] isEqualToString:@"0xC0000000"], 
               @"Test failed, string was %@", [fixedPoint toFixedPointString]);
  
  floatValue = 255.5;				// Fixed point value = 0x7FC000
  [fixedPoint setFromFloat:floatValue];
  STAssertTrue([[fixedPoint toFixedPointString] isEqualToString:@"0x7FC000"], 
               @"Test failed, string was %@", [fixedPoint toFixedPointString]);
   
  floatValue = -255.5;				// Fixed point value = 0x807FC000
  [fixedPoint setFromFloat:floatValue];
  STAssertTrue([[fixedPoint toFixedPointString] isEqualToString:@"0x807FC000"], 
               @"Test failed, string was %@", [fixedPoint toFixedPointString]);
        
  floatValue = -0.1234;				// Fixed point value = 0x80000FCB
  [fixedPoint setFromFloat:floatValue];
  STAssertTrue([[fixedPoint toFixedPointString] isEqualToString:@"0x80000FCB"], 
               @"Test failed, string was %@", [fixedPoint toFixedPointString]);
}

- (void)testFloatToFixedBadValue
{
  FixedPointConverter *fixedPoint;
  float floatValue = 65536.0;			// Bad value, exceeds maximum float supported
  @try 
  {
    fixedPoint = [[FixedPointConverter alloc] initWithFloatingPointNumber:floatValue];
  }
  @catch (NSException *exception) 
  {
  }
  @finally 
  {
    STAssertNil(fixedPoint, @"Variable not nil");
  }
}

- (void)testGrayToBinary
{
  unsigned int grayValue = 0x1;     // Binary value = 0x1
  GrayCodeConverter *converter = [[GrayCodeConverter alloc] initWithGray:grayValue];
  STAssertEquals([converter toBinary], (unsigned int)0x1, 
                 @"Failed, value = %u", [converter toBinary]);
  
  [converter setGrayNumber:0x2];    // Binary value = 0x3
  STAssertEquals([converter toBinary], (unsigned int)0x3, 
                 @"Failed, value = %u", [converter toBinary]);
  
  [converter setGrayNumber:0x17f];    // Binary value = 0x1aa
  STAssertEquals([converter toBinary], (unsigned int)0x1aa, 
                 @"Failed, value = %u", [converter toBinary]);
}

- (void)testBinaryToGray
{
  unsigned int binaryValue = 0x1;     // Gray code value = 0x1
  GrayCodeConverter *converter = [[GrayCodeConverter alloc] initWithBinary:binaryValue];
  STAssertEquals([converter toGray], (unsigned int)0x1, 
                 @"Failed, value = %u", [converter toGray]);
  
  [converter setFromBinary:0x1aa];      // Gray code value = 0x17f
  STAssertEquals([converter toGray], (unsigned int)0x17f, 
                 @"Failed, value = %u", [converter toGray]);
}

@end
     
