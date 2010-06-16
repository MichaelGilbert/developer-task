//
//  NSString+hexToFloat.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+HexToComponents.h"


@implementation NSString (HexToComponents)

- (void)hexToCharComponents:(unsigned char *)charArray {
	// Get the int value
	NSScanner *scanner = [NSScanner scannerWithString:self];
	unsigned intValue = 0x000000;
	if (NO == [scanner scanHexInt:&intValue]) {
		for (int n = 0; n < 4; ++n)
			*charArray++ = 1.0f;
		return;
	}
	
	// Put the components into the array of floats passed in
	*charArray++ = (intValue >> 16) & 0xff;
	*charArray++ = (intValue >> 8) & 0xff;
	*charArray++ = (intValue >> 0) & 0xff;
	*charArray = 0xff;
}

- (void)hexToFloatComponents:(CGFloat *)floatArray {
	unsigned char charArray[] = {0,0,0,0};
	
	// Get the integer components
	[self hexToCharComponents:charArray];
	
	// Convert them to floats
	for (int n = 0; n < 4; ++n)
		*floatArray++ = (CGFloat)(charArray[n]) / 255.0;
}

@end
