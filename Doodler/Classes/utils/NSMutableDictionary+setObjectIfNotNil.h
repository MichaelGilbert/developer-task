//
//  NSDictionary+setObjectIfNotNil.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (setObjectIfNotNil)

- (void) setObjectIfNotNil:(id)anObject forKey:(id)aKey;

@end
