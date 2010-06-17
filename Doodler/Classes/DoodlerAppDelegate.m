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

@synthesize window=window_;
@synthesize doodlesViewController=doodlesViewController_;


#pragma mark -
#pragma mark Application lifecycle

// Called when the application is ready to go
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
  // Parse the configuration file - not big so don't need to background thread it - KISS
  NSURL *configURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"xml"]];
  ConfigParser *parser = [[[ConfigParser alloc] init] autorelease];
  NSError *error = nil;
  BOOL success = [parser parse:configURL withError:&error];

  // We shouldn't fail; it's a local config file we wrote by hand.
  // If we get the config from somewhere else, deal with this error better than a debug comment!
  if (NO == success)
    NSLog(@"Failed to parse config file : %@", error);

  // Store the configuration - the doodles view controller is going to ask for it
  configuration_ = [[parser configuration] copy];

  // Display the window
  [window_ addSubview:[doodlesViewController_ view]];
  [window_ makeKeyAndVisible];
  return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [doodlesViewController_ release];
  [window_ release];
  [configuration_ release];
  [super dealloc];
}

#pragma mark DoodlesViewControllerDelegate methods

- (NSArray *)doodlesConfigrationsForDoodlesViewController:(DoodlesViewController *)controller {
  // Just return the views bit of the configuration - it's the array of DoodleConfig objects that
  // the DoodleViewController is interested in.
  return [configuration_ objectForKey:@"doodles"];
}

@end

