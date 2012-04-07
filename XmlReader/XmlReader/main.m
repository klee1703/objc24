//
//  main.m
//  XmlReader
//  COCin24Hours_1
//
//  Created by Keith Lee on 03/26/12.
//  Copyright 2012 Keith Lee. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//   1. Redistributions of source code must retain the above copyright notice, this list of
//      conditions and the following disclaimer.
//
//   2. Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY Keith Lee ''AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Keith Lee OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Keith Lee.
//

#import <Foundation/Foundation.h>

#import "parser/XMLStreamParser.h"
#import "parser/XMLTreeParser.h"
#import "TargetElement.h"

int main (int argc, const char * argv[])
{
  BOOL isError = NO;
  @autoreleasepool 
  {      
    // Retrieve command line arguments
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *filePath = [defaults stringForKey:@"f"];
    if (filePath == nil)
    {
      filePath = @"file:///Users/klee/TargetImages.xml";
    }
    
    NSLog(@"\n\n**** Creating targets with tree parser ****");
    XMLTreeParser *treeParser = [[XMLTreeParser alloc] initWithFilePath:(NSString *)filePath];
    if (treeParser.parserError != nil)
    {
      NSLog(@"Error: %@", [treeParser.parserError localizedDescription]);
      isError = YES;
    }
    else
    {
      NSArray *targets = [treeParser parseTargets];
      if (targets == nil)
      {
        NSLog(@"Error: %@", [treeParser.parserError localizedDescription]);
        isError = YES;
      }
      else
      {
        for (TargetElement *elem in targets)
        {
          NSLog(@"Image file: %@", [elem imageFile]);
          NSLog(@"Image type: %@", [elem imageType]);
        }
      }
    }

    NSLog(@"\n\n**** Creating targets with stream parser ****");
    XMLStreamParser *streamParser = [[XMLStreamParser alloc] initWithFilePath:(NSString *)filePath];
    if (streamParser.parserError != nil)
    {
      NSLog(@"Error: %@", [streamParser.parserError localizedDescription]);
      isError = YES;
    }
    else
    {
      NSArray *targets = [streamParser parseTargets];
      if (targets == nil)
      {
        NSLog(@"Error: %@", [streamParser.parserError localizedDescription]);
        isError = YES;
      }
      else
      {
        for (TargetElement *elem in targets)
        {
          NSLog(@"Image file: %@", [elem imageFile]);
          NSLog(@"Image type: %@", [elem imageType]);
        }
      }
    }    
  }
  
  return isError;
}

