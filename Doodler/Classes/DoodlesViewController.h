//
//  DoodlesViewController.h
//  Doodler
//
//  Created by Sam Dean on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodleView.h"

@class DoodlesViewController;

// This protocol describes the methods called to get the configurations from a data source into the
// DoodlesViewController.
@protocol DoodlesViewControllerDelegate

// Sent to the delegate when the contrller wants an array of DoodleConfg objects to use to create
// it's DoodleViews.
- (NSArray *)doodlesConfigrationsForDoodlesViewController:(DoodlesViewController *)controller;

@end

// This controller queries it's delegate for a list of DoodleConfig objects and then creates a 
// set of DoodleViews to represent them. It displays the first DoodleView and enables it. The others
// are presented in turn when the swapDoodle method is called.
//
// The saveDoodle method will save the currently displayed DoodleView to the photo album.
@interface DoodlesViewController : UIViewController {
 @private
  id <DoodlesViewControllerDelegate> delegate_;
	
  UIToolbar *toolbar_;
	
  NSArray *configurations_;
  NSMutableArray *doodleViews_;
	
  UIView *doodleViewContainer_;

  DoodleView *currentDoodle_;
}

@property (nonatomic, assign) IBOutlet id <DoodlesViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIView *doodleViewContainer;

- (IBAction)swapDoodle:(id)sender;
- (IBAction)saveDoodle:(id)sender;

@end
