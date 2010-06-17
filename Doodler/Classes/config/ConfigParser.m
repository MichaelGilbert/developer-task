//
//  ConfigParser.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConfigParser.h"

#import "DoodleConfig.h"

#import "UIColor+ColorWithHexString.h"

@implementation ConfigParser

@synthesize configuration=configuration_;

- (void)dealloc {
  [configuration_ release];
  [super dealloc];
}

- (BOOL)parse:(NSURL *)source withError:(NSError **)error {
  // Parse the xml found in the url provided using ourself as a delegate
  NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:source]] autorelease];
  [parser setDelegate:self];
  BOOL success = [parser parse];

  // Make sure that the error parameter is set correctly - definitely nil if we parsed sucessfully!
  if (error)
    *error = (success) ? nil : [parser parserError];

  return success;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  [configuration_ release];
  configuration_ = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

  if ([elementName isEqualToString:@"doodles"]) {
    // Create the views array
    [configuration_ setObject:[NSMutableArray array] forKey:@"doodles"];
  } else if ([elementName isEqualToString:@"doodle"]) {
    // Get the views array from the config
    NSMutableArray *doodles = [configuration_ objectForKey:@"doodles"];
    
    // If we have got a doodles array, add a DoodleConfig to it
    if (doodles) {
      DoodleConfig *config = [[[DoodleConfig alloc] init] autorelease];
      config.backgroundColor = [UIColor colorWithHexString:[attributeDict objectForKey:@"backgroundColor"]];
      config.strokeColor = [UIColor colorWithHexString:[attributeDict objectForKey:@"color"]];
      [doodles addObject:config];
    }
  }

}

@end
