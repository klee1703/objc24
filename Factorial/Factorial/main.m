//
//  main.m
//  Factorial
//
//  Created by Keith Lee on 1/27/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef int (^Adder)(int);

@interface AdderBlock : NSObject
{
  int addend;
}
@property int addend;
- (Adder) getAdder;
@end

@implementation AdderBlock
@synthesize addend;
- (Adder) getAdder
{
  return ^(int anInt)
  {
    return (anInt + [self addend]);
  };
}
@end

int main (int argc, const char * argv[])
{
  @autoreleasepool 
  {
    AdderBlock *block = [[AdderBlock alloc] init];
    [block setAddend:4];
    Adder adder = [block getAdder];
    NSLog(@"Sum = %d", adder(1));
  }
  return 0;
}

