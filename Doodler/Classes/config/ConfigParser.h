//
//  ConfigParser.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigParser : NSObject {
	NSMutableDictionary *configuration;
}

@property (nonatomic, readonly) NSDictionary *configuration;

- (BOOL)parse:(NSURL *)source withError:(NSError **)error;

@end
