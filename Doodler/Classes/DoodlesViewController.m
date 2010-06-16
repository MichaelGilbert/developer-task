//
//  DoodlesViewController.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodlesViewController.h"

#import "DoodleView.h"

@implementation DoodlesViewController

@synthesize delegate=delegate_, toolbar=toolbar_;
@synthesize doodleViewContainer=doodleViewContainer_;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Get the configuration from the delegate if we don't already have it
	if (nil == configurations_)
		configurations_ = [[delegate_ doodlesConfigrationsForDoodlesViewController:self] copy];
		
	// Create the views from the configuration if we don't already have any
	if (nil == doodleViews_) {
		doodleViews_ = [[NSMutableArray alloc] init];
		for (DoodleConfig *doodleConfig in configurations_) {
			// Make the view for this doodle
			DoodleView *doodleView = [[[DoodleView alloc] initWithFrame:[doodleViewContainer_ frame]] autorelease];
			doodleView.config = doodleConfig;
			[doodleViews_ addObject:doodleView];
		}
	}

	// If we don't yet have a current view, use the first one
	if (NULL == currentDoodle_)
		currentDoodle_ = [[doodleViews_ objectAtIndex:0] retain];
	
	// Add the current doodle view to the ui
	[doodleViewContainer_ addSubview:currentDoodle_];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.toolbar = nil;
	self.doodleViewContainer = nil;
}


- (void)dealloc {
	[currentDoodle_ release];
	[toolbar_ release];
	[doodleViews_ release];
	[doodleViewContainer_ release];
    [super dealloc];
}

- (IBAction)swapDoodle:(id)sender {
	// You can't swap doodles i we only have one
	if ([doodleViews_ count] < 2) return;
	
	// Get the next doodle
	uint index = [doodleViews_ indexOfObject:currentDoodle_] + 1;
	if (index == [doodleViews_ count]) index = 0;
	DoodleView *nextDoodle = [doodleViews_ objectAtIndex:index];

	// Change the doodle
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:doodleViewContainer_ cache:YES];
	[doodleViewContainer_ addSubview:nextDoodle];
	[currentDoodle_ removeFromSuperview];
	[UIView commitAnimations];
	
	// Update the current doodle pointer
	[currentDoodle_ autorelease];
	currentDoodle_ = [nextDoodle retain];	
}

- (IBAction)saveDoodle:(id)sender {
	UIImageWriteToSavedPhotosAlbum([currentDoodle_ image], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo {
	[[[[UIAlertView alloc] initWithTitle:@"Success"
								 message:@"Your doodle has been saved"
							    delegate:nil
					   cancelButtonTitle:@"OK"
					   otherButtonTitles:nil] autorelease] show];
}

@end
