//
//  UIColor+colorWithHexString.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIColor+ColorWithHexString.h"

#import "NSString+HexToComponents.h"

@implementation UIColor (ColorWithHexString)

+ (id) colorWithHexString:(NSString *)hexString {
	CGFloat colors[4] = {1.0,1.0,1.0,1.0};
	
	[hexString hexToFloatComponents:colors];
	
	// Return the color
	return [UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:colors[3]];
}

@end
