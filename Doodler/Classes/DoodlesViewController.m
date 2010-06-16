//
//  DoodlesViewController.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodlesViewController.h"

#import "UIColor+colorWithHexString.h"

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
	if (nil == configuration)
		configuration = [[delegate doodlesConfigrationForDoodlesViewController:self] copy];
		
	// Create the views from the configuration
	doodleViews = [[NSMutableArray alloc] init];
	for (NSDictionary *doodleConfig in configuration) {
		CGRect doodleRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-toolbar.frame.size.height);
		
		// Make the view for this doodle
		UIImageView *doodleView = [[[UIImageView alloc] initWithFrame:doodleRect] autorelease];
		[doodleViews addObject:doodleView];
		
		// Make an image with the correct background color
		UIGraphicsBeginImageContext(doodleRect.size);
		CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor colorWithHexString:[doodleConfig objectForKey:@"backgroundColor"]] CGColor]);
		CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, doodleRect.size.width, doodleRect.size.height));
		doodleView.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}

	// Show the view we were last on
	if (NULL == currentDoodle) currentDoodle = [doodleViews objectAtIndex:0];
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
	[toolbar release];
	[doodleViews release];
    [super dealloc];
}

#pragma mark -
#pragma mark Touch handling methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:currentDoodle];
	
	// If it's on the doodle image, render it as a line
	if (CGRectContainsPoint(currentDoodle.bounds, point)) {
		CGPoint lastPoint = [touch previousLocationInView:currentDoodle];
		
		// Create an image context with the current contents of the doodle
		UIGraphicsBeginImageContext(currentDoodle.frame.size);
		[currentDoodle.image drawInRect:currentDoodle.bounds];
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		// We want pretty lines
		CGContextSetLineCap(context, kCGLineCapRound);
		CGContextSetLineWidth(context, 2);
		CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
		
		// Draw the line
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(context, point.x, point.y);
		CGContextStrokePath(context);
		
		// Store it and end the context
		currentDoodle.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
