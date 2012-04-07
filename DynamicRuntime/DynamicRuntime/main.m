//
//  main.m
//  DynamicRuntime
//
//  Created by Keith Lee on 1/8/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mammal.h"
#import "Carnivore.h"
#import "Herbivore.h"
#import "Box.h"

int main (int argc, const char * argv[])
{
  @autoreleasepool
  {
    // Create some mammals and display info
    id lion = [[Carnivore alloc] init];
    [lion setSpecies:@"Lion"];
    id zebra = [[Herbivore alloc] init];
    [zebra setSpecies:@"Zebra"];
    NSLog(@"MAMMAL: Species - %@, Diet - %@", [lion species], [lion getDiet]);
    NSLog(@"MAMMAL: Species - %@, Diet - %@", [zebra species], [zebra getDiet]);
    
    // Now create a box and try to display it's diet
    id box = [[Box alloc] init];
    NSLog(@"Box: Diet - %@", [box getDiet]);

    // Release allocated objects
  }
  return 0;
}

