//
//  UIColor+colorWithHexString.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIColor+colorWithHexString.h"


@implementation UIColor (colorWithHexString)

+ (id) colorWithHexString:(NSString *)hexString {
	// Get the int value
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	unsigned intValue = 0x000000;
	if (NO == [scanner scanHexInt:&intValue])
		return [UIColor blackColor];
	
	// Get the components
	uint r = (intValue >> 16) & 0xff;
	uint g = (intValue >> 8) & 0xff;
	uint b = (intValue >> 0) & 0xff;
	
	// Return the color
	return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
}

@end
