//
//  NSString+hexToFloat.h
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (hexToFloat)

- (void)hexToFloatComponents:(CGFloat *)floatArray;
- (void)hexToCharComponents:(unsigned char *)charArray;

@end
