//
//  DoodleConfig.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodleConfig.h"


@implementation DoodleConfig

@synthesize backgroundColor=backgroundColor_;
@synthesize strokeColor=strokeColor_;

- (id)init {
  if (self = [super init]) {
    // Don't allocate defalt values for the background and stroke colors here. Chances are that
    // they will be set very soon so we might as well wait until they are asked for to see if
    // we need a default value
  }
  return self;
}

- (void) dealloc {
  [strokeColor_ release];
  [backgroundColor_ release];
  [super dealloc];
}

- (UIColor *)backgroundColor {
  if (nil == backgroundColor_)
    backgroundColor_ = [[UIColor blackColor] retain];
  return backgroundColor_;
}

- (UIColor *)strokeColor {
  if (nil == strokeColor_)
    strokeColor_ = [[UIColor whiteColor] retain];
  return strokeColor_;
}

@end
