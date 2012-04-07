//
//  Statistics.m
//  Statistics
//
//  Created by Keith Lee on 1/31/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#include "math.h"
#import "Statistics.h"

@implementation Statistics

- (float) mean:(NSArray *)dataset
{
  float sum = 0.0;
  for (id item in dataset)
  {
    sum += [item floatValue];
  }
  return (sum / [dataset count]);
}

- (float) median:(NSArray *)dataset
{
  NSArray *sortedSet = [dataset sortedArrayUsingComparator: ^(id obj1, id obj2)
  {
    if ([obj1 floatValue] > [obj2 floatValue])
    {
      return (NSComparisonResult)NSOrderedDescending;
    }
    else if ([obj1 floatValue] < [obj2 floatValue]) 
    {
      return (NSComparisonResult)NSOrderedAscending;
    }
    else
    {
      return (NSComparisonResult)NSOrderedSame;
    }
  }];
   
  if ([sortedSet count] == 0)
  {
    return -0.0;
  }
  else if ([sortedSet count] == 1)
  {
    return [[sortedSet objectAtIndex:0] floatValue];
  }
  else
  {
    if (([sortedSet count] % 2) == 1)
    {
      unsigned long index = ([sortedSet count] - 1) / 2;
      return [[sortedSet objectAtIndex:index] floatValue];
    }
    else if (([sortedSet count] % 2) == 0)
    {
      unsigned long index1 = [sortedSet count] / 2;
      unsigned long index2 = index1 - 1;
      float temp = [[sortedSet objectAtIndex:index1] floatValue] +
      [[sortedSet objectAtIndex:index2] floatValue];
      return (temp / 2.0);
     }
   }
  return 0.0;
}

- (float) populationVariance:(NSArray *)dataset
{
  float mn = [self mean:dataset];
  float sum = 0.0;
  for (id item in dataset)
  {
    sum += powf(([item floatValue] - mn), 2.0);
  }
  return (sum / [dataset count]);
}

- (float) populationStandardDeviation:(NSArray *)dataset
{
  return sqrtf([self populationVariance:dataset]);
}

- (float) averageDeviation:(NSArray *)dataset
{
  float mn = [self mean:dataset];
  float sum = 0.0;
  for (id item in dataset)
  {
    sum += fabs([item floatValue] - mn);
  }
  return (sum / [dataset count]);
}

- (float) sampleVariance:(NSArray *)dataset
{
  float mn = [self mean:dataset];
  float sum = 0.0;
  for (id item in dataset)
  {
    sum += powf(([item floatValue] - mn), 2.0);
  }
  return (sum / ([dataset count] - 1));
}

- (float) sampleStandardDeviation:(NSArray *)dataset
{
  return sqrtf([self sampleVariance:dataset]);
}

@end
