//
//  NSDictionary+setObjectIfNotNil.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSMutableDictionary+setObjectIfNotNil.h"


@implementation NSMutableDictionary (setObjectIfNotNil)

- (void) setObjectIfNotNil:(id)anObject forKey:(id)aKey {
	if (anObject)
		[self setObject:anObject forKey:aKey];
}

@end
