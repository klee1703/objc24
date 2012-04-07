//
//  main.m
//  NumberConverter
//
//  Created by Keith Lee on 1/11/12.
//  Copyright 2012 Personal. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FixedPointConverter.h"
#import "GrayCodeConverter.h"
#include <unistd.h>

/*
 * Simple enum for number conversions supported
 */
enum conversionType
{
  FixedToFloat,
  FloatToFixed,
  GrayToBinary,
  BinaryToGray
};

int main (int argc, const char * argv[])
{
  // Create an autorelease pool for object management
  @autoreleasepool {
  
  // Retrieve command line arguments using the C getopt() function
    int optChar;
    enum conversionType conversion;
    NSString *inputString;
    while ((optChar = getopt(argc, (char * const*)argv, "hf:i:x:g:")) != -1)
    {
      switch (optChar)
      {
        case 'h':
          NSLog(@"converter -i [Decimal number] -f [Fixed-point hex number] -x [Hexadecimal] -g [Gray code hexadecimal]");
          break;
        case 'f':
          conversion = FixedToFloat;
          inputString = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
          break;
        case 'i':
          conversion = FloatToFixed;
          inputString = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
          break;
        case 'x':
          conversion = BinaryToGray;
          inputString = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
          break;
        case 'g':
          conversion = GrayToBinary;
          inputString = [NSString stringWithCString:optarg encoding:NSUTF8StringEncoding];
          break;
        default:
          NSLog(@"converter -i [Decimal number] -f [Fixed-point hex number] -x [Hexadecimal] -g [Gray code hexadecimal]");
          break;
      }
    }

    // Perform conversion per the input selection
    switch (conversion)
    {
      case FixedToFloat:
      {
        // Create a floating-point value for a fixed-point input
        if ([inputString length] > 8)
        {
          // Display message if fixed-point number is too large
          NSLog(@"Invalid fixed-point value entered: %@, must be input as 1-8 hexadecimal characters",
                inputString);
        }
        else
        {
          // Retrieve integer from hex input fixed-point value (must be a valid number!)
          NSScanner *scanner = [NSScanner scannerWithString:inputString];
          unsigned int intValue = 0;
          if ([scanner scanHexInt:&intValue])
          {
            // Display decimal value for fixed-point input
            FixedPointConverter *fixedPoint = [[FixedPointConverter alloc] 
                                               initWithFixedPointNumber:intValue];
            NSLog(@"Decimal value for fixed-point number 0x%X = %f", 
                  intValue, [fixedPoint toFloat]);
          }
          else
          {
            NSLog(@"Invalid fixed-point value entered: %@, must be input as 1-8 hexadecimal characters",
                  inputString);
          }
        }
        break;
      }
      case FloatToFixed:
      {
        // Create a fixed-point value for a floating-point input
        // Retrieve float from input string
        NSScanner *scanner = [NSScanner scannerWithString:inputString];
        float floatValue = 0.0;
        if ([scanner scanFloat:&floatValue])
        {
          @try
          {
            // Display decimal value for floating-point input (autorelease
            // because of try-catch block)
            FixedPointConverter *fixedPoint = [[FixedPointConverter alloc] 
                                                initWithFloatingPointNumber:floatValue];
            NSLog(@"Fixed-point value for decimal number %g = %@", 
                  floatValue, [fixedPoint toFixedPointString]);
          }
          @catch (NSException *nsex)
          {
            NSLog(@"Exception: %@", [nsex reason]);
          }
        }
        else
        {
          NSLog(@"Invalid floating-point value entered: %@",
                inputString);
        }
        break;
      }
      case BinaryToGray:
      {
        // Create a gray code value for a hexadecimal input
        if ([inputString length] > 8)
        {
          // Display message if hexadecimal number is too large
          NSLog(@"Invalid hexadecimal number entered: %@, must be from 1-8 hexadecimal characters",
                inputString);
        }
        else
        {
          // Retrieve integer from hex input value (must be a valid number!)
          NSScanner *scanner = [NSScanner scannerWithString:inputString];
          unsigned int hexValue = 0;
          if ([scanner scanHexInt:&hexValue])
          {
            // Display gray code value for hexadecimal input
            GrayCodeConverter *converter = [[GrayCodeConverter alloc] 
                                            initWithBinary:hexValue];
            NSLog(@"Gray code value for hexadecimal number 0x%X = 0x%X", 
                  hexValue, [converter toGray]);
          }
          else
          {
            NSLog(@"Invalid hexadecimal value entered: %@, must be from 1-8 hexadecimal characters",
                  inputString);
          }
        }
        break;
      }
      case GrayToBinary:
      {
        // Create a decimal value for a gray code input
        if ([inputString length] > 8)
        {
          // Display message if gray code number is too large
          NSLog(@"Invalid gray code number entered: %@, must be input as 1-8 hexadecimal characters",
                inputString);
        }
        else
        {
          // Retrieve integer from hex input value (must be a valid number!)
          NSScanner *scanner = [NSScanner scannerWithString:inputString];
          unsigned int grayValue = 0;
          if ([scanner scanHexInt:&grayValue])
          {
            // Display decimal value for gray code input
            GrayCodeConverter *converter = [[GrayCodeConverter alloc] 
                                            initWithGray:grayValue];
            NSLog(@"Decimal value for gray code number 0x%X = %u", 
                  grayValue, [converter toBinary]);
          }
          else
          {
            NSLog(@"Invalid gray code value entered: %@, must be input as 1-8 hexadecimal characters",
                  inputString);
          }
        }
        break;
      }
      default:
        break;
    }
  
  // Release allocated objects
  }
  return 0;
}
