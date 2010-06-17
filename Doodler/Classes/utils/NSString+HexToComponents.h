//
//  NSString+hexToFloat.h
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// This category contains methods that convert hex clor codes (i.e. 0xe8008c) into
// their component values
@interface NSString (HexToComponents)

// If the string is a valid hex string this method will put 4 float values into
// the array passed in - these will be normailsed from 0.0 -> 1.0
//
// float colors[4];
// [[NString stringWithString:@"0xff00ff"] hexToFloatComponents:colors];
//
// will populate colors with {1.0, 0.0, 1.0, 1.0} (the 4th element being alpha)
- (void)hexToFloatComponents:(CGFloat *)floatArray;

// If the string is a valid hex string this method will put 4 unsigned char values
// into the array passed in.
//
// unsigned char colors[4];
// [[NSString stringWithString:@"0xff00ff"] hexToCharComponents:colors];
//
// will populate colors with {255, 0, 255, 255} (the 4th element being alpha)
- (void)hexToCharComponents:(unsigned char *)charArray;

@end
