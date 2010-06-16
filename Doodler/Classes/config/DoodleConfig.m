//
//  DoodleConfig.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodleConfig.h"


@implementation DoodleConfig

@synthesize strokeColor, backgroundColor;

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void) dealloc {
	[strokeColor release];
	[backgroundColor release];
	[super dealloc];
}

@end
