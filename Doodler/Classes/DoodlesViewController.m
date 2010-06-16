//
//  DoodlesViewController.m
//  Doodler
//
//  Created by obs on 15/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodlesViewController.h"

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
			UIImageView *doodleView = [[[UIImageView alloc] initWithFrame:doodleRect] autorelease];
			[doodleViews addObject:doodleView];
			
			// Make an image with the correct background color
			UIGraphicsBeginImageContext(doodleRect.size);
			CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[doodleConfig backgroundColor] CGColor]);
			CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, doodleRect.size.width, doodleRect.size.height));
			doodleView.image = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
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

#pragma mark -
#pragma mark Touch handling & line drawing methods

- (void) drawLineFrom:(CGPoint)src to:(CGPoint)dst {
	// Create an image context with the current contents of the doodle
	UIGraphicsBeginImageContext(currentDoodle.frame.size);
	[currentDoodle.image drawInRect:currentDoodle.bounds];
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// We want pretty lines
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineWidth(context, 2);
	CGContextSetStrokeColorWithColor(context, currentConfig.strokeColor.CGColor);
	
	// Draw the line
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, src.x, src.y);
	CGContextAddLineToPoint(context, dst.x, dst.y);
	CGContextStrokePath(context);
	
	// Store it and end the context
	currentDoodle.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchNeedsDot = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:currentDoodle];
	
	// If it's on the doodle image, render it as a line
	if (CGRectContainsPoint(currentDoodle.bounds, point)) {
		CGPoint lastPoint = [touch previousLocationInView:currentDoodle];
		
		[self drawLineFrom:lastPoint to:point];
		
		touchNeedsDot = NO;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (touchNeedsDot) {
		CGPoint point = [[touches anyObject] locationInView:currentDoodle];
		[self drawLineFrom:point to:point];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end

