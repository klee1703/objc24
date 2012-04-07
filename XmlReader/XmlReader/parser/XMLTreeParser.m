//
//  XMLTreeParser.m
//  XmlReader
//
//  Created by Keith Lee on 3/27/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "XMLTreeParser.h"
#import "TargetElement.h"

// Extension for read/write property (public readonly)
@interface XMLTreeParser()

@property(nonatomic, readwrite) NSError *parserError;
@end

@implementation XMLTreeParser
{
  TargetElement *targetElement;
  NSXMLDocument *xdoc;
  NSMutableArray *targets;
}

@synthesize parserError;

- (id) initWithFilePath:(NSString *)filePath
{
  self = [super init];
  if (self) 
  {
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    if (fileUrl == nil)
    {
      // Error creating URL, make custom error
      NSArray *objArray = [NSArray arrayWithObjects:@"Error malformed URL", nil];
      NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
      NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
      self.parserError = [NSError errorWithDomain:NSURLErrorDomain 
                                               code:NSURLErrorBadURL 
                                           userInfo:eDict];
    }
    else
    {
      NSError *initError = nil;
      xdoc = [[NSXMLDocument alloc] initWithContentsOfURL:fileUrl  
                                                  options:NSXMLDocumentTidyXML 
                                                    error:&initError];
      // Display if initialization failed
      if (xdoc == nil)
      {
        if (initError)
        {
          self.parserError = initError;
        }
      }
      else if (initError) 
      {
        self.parserError = initError;
      }
    }
  }
  
  return self;  
}

- (NSArray *) parseTargets
{
  // First create a collection for results
  NSMutableArray *telems = [NSMutableArray arrayWithCapacity:1];

  // Perform an XQuery to retrieve the TargetElement instances
  NSString *teQuery = @".//ns0:Targets/ns0:TargetElement";
  NSError *err = nil;
  NSArray *teObjects = [xdoc objectsForXQuery:teQuery error:&err];
  if (err)
  {
    self.parserError = err;
    telems = nil;
  }
  else
  {  
    if (teObjects)
    {
      // create a TargetElement and for each object, set image file and type 
      NSUInteger count = [teObjects count];
      for (unsigned ii=0; ii<count; ii++)
      {
        TargetElement *telem = [[TargetElement alloc] init];
        NSXMLElement *xte = [teObjects objectAtIndex:ii];

        // Retrieve ImageFile element from tree and assign
        NSArray *xfiles = [xte elementsForName:@"ns0:ImageFile"];
        if (xfiles != nil)
        {
          NSXMLElement *imageFile = [xfiles objectAtIndex:0];
          telem.imageFile = [imageFile stringValue];
        }

        // Retrieve ImageType element from tree and assign
        NSArray *xtypes = [xte elementsForName:@"ns0:ImageType"];
        if (xfiles != nil)
        {
          NSXMLElement *imageType = [xtypes objectAtIndex:0];
          telem.imageType = [imageType stringValue];
        }

        // Then add TargetElement to collection
        [telems addObject:telem];
      }
    }
    else
    {
      // No TargetElements found with query, set results to nil
      telems = nil;
    }
  }
  return telems;
}

@end
