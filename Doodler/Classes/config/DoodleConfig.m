//
//  DoodleConfig.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodleConfig.h"


@implementation DoodleConfig

@synthesize backgroundColor, strokeColor;

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

- (UIColor *)backgroundColor {
	if (nil == backgroundColor)
		backgroundColor = [[UIColor blackColor] retain];
	return backgroundColor;
}

- (UIColor *)strokeColor {
	if (nil == strokeColor)
		strokeColor = [[UIColor whiteColor] retain];
	return strokeColor;
}

@end
