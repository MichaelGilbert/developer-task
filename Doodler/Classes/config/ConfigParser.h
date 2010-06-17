//
//  ConfigParser.h
//  Doodler
//
//  Created by Sam Dean on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Takes an input xml file URL and parses it into an NSDictionary representing
// the configuration.
//
// Currently, this will only understand the list of doodles configurations
@interface ConfigParser : NSObject {
 @private
  NSMutableDictionary *configuration_;
}

// Read this after a parse to get the configuration
@property (nonatomic, readonly) NSDictionary *configuration;

// Pass in a URL to a valid coniuration XML document and a reference to an NSError
// pointer.
//
// Returns NO on failure and *error will point to a valid NSError object.
// If the parse is sucessful, YES is returned and *error is set to nil. You ca
// then read the configuration property safely.
//
// If you don't care about the error, you can pass in nil for this parameter
- (BOOL)parse:(NSURL *)source withError:(NSError **)error;

@end
