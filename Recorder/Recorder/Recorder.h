//
//  Recorder.h
//  Recorder
//
//  Created by Keith Lee on 1/5/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recorder : NSObject
{
@private NSString *path;
}

@property (nonatomic, strong) NSString *path;

- (BOOL) encodeArchive:(id)data toFile:(NSString *)file;
- (id) decodeArchiveFromFile:(NSString *) file;

@end
