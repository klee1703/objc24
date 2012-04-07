//
//  main.m
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recorder.h"
#import "Carnivora/Lion.h"

int main (int argc, const char * argv[])
{
  // Create an autorelease pool for object management
  @autoreleasepool 
  {
    // Create a Recorder instance
    Recorder *recorder = [[Recorder alloc] init];
    
    // Create test data and archive it to a file
    id animal = [[Lion alloc] init];
    NSString *file = @"data.archive";
    BOOL result = [recorder encodeArchive:animal toFile:file];
    
    // Display results
    if (result)
    {
      NSLog(@"You encoded an archive to file %@", 
            [[recorder path] stringByAppendingString:file]);
    }
    
    // Decode archive
    id data = [recorder decodeArchiveFromFile:file];
    if (data)
    {
      NSLog(@"You decoded an archive from file %@, its description is %@", 
            [[recorder path] stringByAppendingString:file], [data description]);
    }
  }
  return 0;
}

