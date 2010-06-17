//
//  DoodlerAppDelegate.h
//  Doodler
//
//  Created by Sam Dean on 15/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodlesViewController.h"

// Does everything an app delegate should plus acts as the data source for the
// DoodlesViewController. It gets the config from XML at application:didFinishLaunchingWithOptions:
@interface DoodlerAppDelegate : NSObject <UIApplicationDelegate, DoodlesViewControllerDelegate> {
 @private
  UIWindow *window_;
  DoodlesViewController *doodlesViewController_;
	
  NSDictionary *configuration_; // Holds the config parsed from XML
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DoodlesViewController *doodlesViewController;

@end

