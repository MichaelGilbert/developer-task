//
//  ConfigParser.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConfigParser.h"


@implementation ConfigParser

@synthesize configuration;

- (void)dealloc {
	[configuration release];
	[super dealloc];
}

- (BOOL)parse:(NSURL *)source withError:(NSError **)error {
	// Parse the xml found in the url provided using ourself as a delegate
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:source]];
	[parser setDelegate:self];
	BOOL success = [parser parse];
	[parser release];

	// Make sure that the error parameter is set correctly - definitely nil if we parsed sucessfully!
	if (error)
		*error = (success) ? nil : [parser parserError];
	
	return success;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[configuration release];
	configuration = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"views"]) {
		// Create the views array
		[configuration setObject:[NSMutableArray array] forKey:@"views"];
	} else if ([elementName isEqualToString:@"view"]) {
		// Add the specified view to the views array
		NSMutableArray *views = [configuration objectForKey:@"views"];
		NSMutableDictionary *view = [NSMutableDictionary dictionaryWithCapacity:2];
		[view setObject:[attributeDict objectForKey:@"backgroundColor"] forKey:@"backgroundColor"];
		[view setObject:[attributeDict objectForKey:@"color"] forKey:@"color"];
		[views addObject:view];
	}
	
}

@end
