//
//  XMLStreamParser.m
//  XmlReader
//
//  Created by Keith Lee on 3/27/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "XMLStreamParser.h"
#import "TargetElement.h"

// Extension for read/write property (public readonly)
@interface XMLStreamParser()
@property(nonatomic, readwrite) NSError *parserError;
@end

@implementation XMLStreamParser
{
  NSMutableString *currentElementValue;
  TargetElement *targetElement;
  NSXMLParser *parser;
  NSMutableArray *targets;
}

@synthesize parserError;

- (id)initWithFilePath:(NSString *)filePath
{
  self = [super init];
  if (self) 
  {
    NSURL *fileURL = [NSURL URLWithString:filePath];
    if (fileURL != nil)
    {
      parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
      if (parser != nil)
      {
        [parser setDelegate:self];
      }
      else
      {
        // Error creating parser, make custom domain error
        NSArray *objArray = [NSArray arrayWithObjects:@"Error initializing parser", nil];
        NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
        NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
        self.parserError = [NSError errorWithDomain:@"ParserDomain" code:1 userInfo:eDict];
      }
    }
    else
    {
      // Error creating URL, make custom error
      NSArray *objArray = [NSArray arrayWithObjects:@"Error malformed URL", nil];
      NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
      NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
      self.parserError = [NSError errorWithDomain:NSURLErrorDomain 
                                             code:NSURLErrorBadURL 
                                         userInfo:eDict];
    }
  }
  
  return self;
}

- (NSArray *)parseTargets
{
  BOOL success = [parser parse];
  if (success)
  {
    return targets;
  }
  else
  {
    // Error parsing file, make custom error and return nil
    NSArray *objArray = [NSArray arrayWithObjects:@"Error parsing file", nil];
    NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, nil];
    NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
    [self setParserError:[NSError errorWithDomain:@"ParserDomain" code:2 userInfo:eDict]];
    return nil;
  }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
  if ([elementName isEqualToString:@"ns0:Targets"]) 
  {
    // targets is an NSMutableArray instance variable
    if (!targets)
    {
      targets = [[NSMutableArray alloc] init];
    }
    return;
  }
  
  if ([elementName isEqualToString:@"ns0:TargetElement"]) 
  {
    // current TargetElement is instance variable
    targetElement = [[TargetElement alloc] init];
    return;
  }
}


#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{ 
  if(!currentElementValue)
  {
    currentElementValue = [[NSMutableString alloc] initWithString:string];
  }
  else
  {
    [currentElementValue appendString:string];
  } 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
  if([elementName isEqualToString:@"ns0:Targets"])
  {
    // Reached end of document root, return
    return;
  }
  
  if([elementName isEqualToString:@"ns0:TargetElement"]) 
  {
    // Finished parsing the TargetElement node, add instance to Targets object graph
    [targets addObject:targetElement];
        targetElement = nil;
  }
  else
  {
    // Finished parsing TargetElement subnode, add instance to TargetElement object graph
    NSRange match = [elementName rangeOfString:@":"];
    NSString *element = [elementName substringFromIndex:match.location+1];
    NSString *value = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [targetElement setValue:value forKey:element];
    currentElementValue = nil;
  }
}

@end
