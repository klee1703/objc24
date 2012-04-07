//
//  XMLTreeParser.h
//  XmlReader
//
//  Created by Keith Lee on 3/27/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLTreeParser : NSObject

@property (nonatomic, readonly) NSError *parserError;

- (id) initWithFilePath:(NSString *)filePath;
- (NSArray *) parseTargets;

@end
