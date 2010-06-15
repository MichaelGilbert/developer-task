//
//  DoodlerAppDelegate.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "DoodlerAppDelegate.h"

#import "ConfigParser.h"

@implementation DoodlerAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	// Parse the configuration file - not big so don't need to background thread it (yet?)
	NSURL *configURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"xml"]];
	ConfigParser *parser = [[[ConfigParser alloc] init] autorelease];
	NSError *error = nil;
	BOOL success = [parser parse:configURL withError:&error];
	
	// We shouldn't fail; it's a local config file we wrote by hand.
	// If we get the config from somewhere else, deal with this error better than a debug comment!
	if (NO == success)
		NSLog(@"Failed to parse config file : %@", error);

	// Display the window
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end

