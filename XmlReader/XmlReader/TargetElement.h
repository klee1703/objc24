//
//  TargetElement.h
//  XmlReader
//
//  Created by Keith Lee on 3/27/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetElement : NSObject

@property (nonatomic, strong) NSString *imageFile;
@property (nonatomic, assign) NSString *imageType;

- (id) init;
@end
