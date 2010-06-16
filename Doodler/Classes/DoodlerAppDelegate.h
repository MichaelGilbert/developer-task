//
//  DoodlerAppDelegate.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodlesViewController.h"

@interface DoodlerAppDelegate : NSObject <UIApplicationDelegate, DoodlesViewControllerDelegate> {
    
    UIWindow *window_;
	DoodlesViewController *doodlesViewController_;
	
	NSDictionary *configuration_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DoodlesViewController *doodlesViewController;

@end

