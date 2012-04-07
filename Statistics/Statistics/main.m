//
//  main.m
//  Statistics
//
//  Created by Keith Lee on 1/31/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statistics.h"

#define InvalidValueError	1


int main (int argc, const char * argv[])
{
  @autoreleasepool 
  {
    
    // Retrieve command line arguments using the C getopt() function
    if ((argc > 1) && (argv[1][0] == '-'))
    {
      switch (argv[1][1])
      {
        case 'v':
          break;
        case 'h':
          NSLog(@"Usage: statistics -v [numbers] (each separated by a comma)");
          return 0;
        default:
          NSLog(@"Invalid argument!");
          NSLog(@"Usage: statistics -v [numbers] (each separated by a comma)");
          return 0;
      }
    }
    else
    {
      return 0;
    }
    
    // Retrieve input numbers
    NSArray *commandLine = [[NSProcessInfo processInfo] arguments];
    if ([commandLine count] < 3)
    {
      NSLog(@"Please provide a list of numbers for input");
      NSLog(@"Usage: statistics -v [numbers] (each separated by a comma)");
      return 0;
    }
    
    // Add numbers to dataset and validate
    NSError *error = nil;
    NSMutableArray *dataset = [[NSMutableArray alloc] init];
    NSArray *args = [[commandLine objectAtIndex:2] componentsSeparatedByString:@","];
    for (id arg in args)
    {
      float value;
      if ([[NSScanner scannerWithString:arg] scanFloat:&value])
      {
        [dataset addObject:[NSNumber numberWithFloat:value]];
      }
      else
      {
        NSString *description = 
        [NSString stringWithFormat:@"Invalid floating point value %@", arg];
        NSString *suggestion = 
        @"Please provide a list of real numbers separated by commas (e.g., statistics -v 1.0,2.0,3.0)";
        NSArray *objArray = [NSArray arrayWithObjects:description, suggestion, nil];
        NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,
                             NSLocalizedRecoverySuggestionErrorKey, nil];
        NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
        error = [NSError errorWithDomain:@"StatisticsErrorDomain" code:InvalidValueError userInfo:eDict];
        break;
      }
    }
    
    // Perform operation on input dataset
    if (error != nil)
    {
      NSLog(@"%@", [error localizedDescription]);
      NSLog(@"%@", [error localizedRecoverySuggestion]);
    }
    else
    {
      float (^mean)(NSArray *) = ^(NSArray *dataset)
      {
        float sum = 0.0;
        for (id item in dataset)
        {
          sum += [item floatValue];
        }
        return (sum / [dataset count]);
      };
      Statistics *stats = [[Statistics alloc] init];
      float median = [stats median:dataset];
      float pvariance = [stats populationVariance:dataset];
      float svariance = [stats sampleVariance:dataset];
      float pstdv = [stats populationStandardDeviation:dataset];
      float sstdv = [stats sampleStandardDeviation:dataset];
      float aadv = [stats averageDeviation:dataset];
      NSLog(@"Dataset = %@", [commandLine objectAtIndex:2]);
      NSLog(@"Mean = %f", mean(dataset));
      NSLog(@"Median = %f", median);
      NSLog(@"Population variance = %f", pvariance);
      NSLog(@"Population standard deviation = %f", pstdv);
      NSLog(@"Sample variance = %f", svariance);
      NSLog(@"Sample standard deviation = %f", sstdv);
      NSLog(@"Average absolute deviation = %f", aadv);
    }
  }
  return 0;
}

