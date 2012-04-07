//
//  Recorder.m
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Recorder.h"

@implementation Recorder

@synthesize path;

- (id) init
{
  self = [super init];
  if (self) 
  {
  }
  
  return self;
}

- (BOOL) encodeArchive:(id)objectGraph toFile:(NSString *)file
{
  NSString *archivePath;
  if (path)
  {
    archivePath = [path stringByAppendingPathComponent:file];
  }
  else
  {
    [self setPath:NSTemporaryDirectory()];
    archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:file];
  }
  
  // Create an archiver for encoding data
  NSMutableData *mdata = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mdata];
  
  // Encode the data, keyed with a simple string
  [archiver encodeObject:objectGraph forKey:@"mammal"];
  [archiver finishEncoding];
  
  // Write the encoded data to a file, returning status of the write
  BOOL result = [mdata writeToFile:archivePath atomically:YES];
  return result;
}

- (id) decodeArchiveFromFile:(NSString *) file
{
  // Get path to file with archive
  NSString *archivePath;
  if (path)
  {
    archivePath = [path stringByAppendingPathComponent:file];
  }
  else
  {
    [self setPath:NSTemporaryDirectory()];
    archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:file];
  }
  
  // Create an unarchiver for decoding data
  NSData *data = [[NSMutableData alloc] initWithContentsOfFile:archivePath];
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  
  // Decode the data, keyed with simple string
  id result = [unarchiver decodeObjectForKey:@"mammal"];
  [unarchiver finishDecoding];
  
  // Release objects and return the decoded data
  return result;
}


@end
