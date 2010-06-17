//
//  UIColor+colorWithHexString.h
//  Doodler
//
//  Created by Sam Dean on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Takes a hex input string (i.e. 0xe8008c) and converts it into a UIColor object
@interface UIColor (ColorWithHexString)

// Given a hex string i.e. 0xff0000 will return the correct UIColor
// (in this case purple)
+ (id)colorWithHexString:(NSString *)hexString;

@end
