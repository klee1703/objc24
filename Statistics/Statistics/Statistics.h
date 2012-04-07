//
//  Statistics.h
//  Statistics
//
//  Created by Keith Lee on 1/31/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Statistics : NSObject

- (float) populationStandardDeviation:(NSArray *)dataset;
- (float) sampleStandardDeviation:(NSArray *)dataset;
- (float) averageDeviation:(NSArray *)dataset;
- (float) populationVariance:(NSArray *)dataset;
- (float) sampleVariance:(NSArray *)dataset;
- (float) median:(NSArray *)dataset;
- (float) mean:(NSArray *)dataset;

@end
