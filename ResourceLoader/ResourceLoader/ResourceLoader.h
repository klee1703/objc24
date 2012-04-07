//
//  ResourceLoader.h
//  ResourceLoader
//
//  Created by Keith Lee on 1/6/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceLoader : NSObject <NSURLConnectionDelegate>
{
@private NSMutableData *resourceData;
@private NSURLConnection *urlConnection;
@private NSURLRequest *request;
@private BOOL isLoaded;
}

@property (strong) NSMutableData *resourceData;
@property BOOL isLoaded;

- (BOOL)loadResource:(NSString *)urlString;

@end
