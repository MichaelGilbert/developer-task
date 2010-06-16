//
//  DoodlesViewController.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodleConfig.h"

@class DoodlesViewController;

@protocol DoodlesViewControllerDelegate

- (NSArray *)doodlesConfigrationsForDoodlesViewController:(DoodlesViewController *)controller;

@end


@interface DoodlesViewController : UIViewController {
	id <DoodlesViewControllerDelegate> delegate;
	
	UIToolbar *toolbar;
	
	NSArray *configurations;
	NSMutableArray *doodleViews;
	
	UIImageView *currentDoodle;
	DoodleConfig *currentConfig;
}

@property (nonatomic, assign) IBOutlet id <DoodlesViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@end
