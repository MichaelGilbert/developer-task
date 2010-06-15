//
//  DoodlesViewController.h
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoodlesViewController;

@protocol DoodlesViewControllerDelegate

- (NSArray *)doodlesConfigrationForDoodlesViewController:(DoodlesViewController *)controller;

@end


@interface DoodlesViewController : UIViewController {
	id <DoodlesViewControllerDelegate> delegate;
	
	UIToolbar *toolbar;
	
	NSMutableArray *doodleViews;
}

@property (nonatomic, assign) IBOutlet id <DoodlesViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@end
