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

@synthesize delegate, toolbar;

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
	if (nil == configurations)
		configurations = [[delegate doodlesConfigrationsForDoodlesViewController:self] copy];
		
	// Create the views from the configuration if we don't already have any
	if (nil == doodleViews) {
		doodleViews = [[NSMutableArray alloc] init];
		for (DoodleConfig *doodleConfig in configurations) {
			CGRect doodleRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-toolbar.frame.size.height);
			
			// Make the view for this doodle
			DoodleView *doodleView = [[[DoodleView alloc] initWithFrame:doodleRect] autorelease];
			doodleView.config = doodleConfig;
			[doodleViews addObject:doodleView];
		}
	}

	// If we don't yet have a current view, use the first one
	if (NULL == currentDoodle) {
		currentDoodle = [[doodleViews objectAtIndex:0] retain];
		currentConfig = [[configurations objectAtIndex:0] retain];
	}
	
	// Add the current doodle view to the ui
	[self.view addSubview:currentDoodle];
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
}


- (void)dealloc {
	[currentDoodle release];
	[currentConfig release];
	[toolbar release];
	[doodleViews release];
    [super dealloc];
}

- (DoodleConfig *) getConfigurationForDoodle:(UIImageView *)doodle {
	uint index = [doodleViews indexOfObject:doodle];
	if (NSNotFound == index) return [NSDictionary dictionary];
	
	return [configurations objectAtIndex:index];
}

@end

