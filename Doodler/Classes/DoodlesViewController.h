//
//  DoodlesViewController.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodleView.h"

@class DoodlesViewController;

@protocol DoodlesViewControllerDelegate

- (NSArray *)doodlesConfigrationsForDoodlesViewController:(DoodlesViewController *)controller;

@end


@interface DoodlesViewController : UIViewController {
	id <DoodlesViewControllerDelegate> delegate;
	
	UIToolbar *toolbar;
	
	NSArray *configurations;
	NSMutableArray *doodleViews;
	
	UIView *doodleViewContainer;
	
	DoodleView *currentDoodle;
	
	BOOL touchNeedsDot;
}

@property (nonatomic, assign) IBOutlet id <DoodlesViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIView *doodleViewContainer;

- (IBAction)swapDoodle:(id)sender;

@end
