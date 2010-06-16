//
//  DoodleView.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodleView.h"


@implementation DoodleView

@synthesize config;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setUserInteractionEnabled:YES];
	}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[config release];
    [super dealloc];
}

- (UIImage *) image {
	// If we don't have an image already, use the config to create a black one with the correct background
	if (nil == super.image) {
		UIGraphicsBeginImageContext(self.frame.size);
		CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), config.backgroundColor.CGColor);
		CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
		super.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return super.image;
	}
	
	return super.image;
}

- (DoodleConfig *)config {
	if (nil == config)
		config = [[DoodleConfig alloc] init];
	return config;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	[self image];
}

#pragma mark -
#pragma mark Touch methods

- (void) drawLineFrom:(CGPoint)src to:(CGPoint)dst {
	// Create an image context with the current contents of the doodle
	UIGraphicsBeginImageContext(self.frame.size);
	[self.image drawInRect:self.bounds];
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// We want pretty lines
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineWidth(context, 2);
	CGContextSetStrokeColorWithColor(context, config.strokeColor.CGColor);
	
	// Draw the line
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, src.x, src.y);
	CGContextAddLineToPoint(context, dst.x, dst.y);
	CGContextStrokePath(context);
	
	// Store it and end the context
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchNeedsDot = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	// Render it as a line
	CGPoint lastPoint = [touch previousLocationInView:self];
		
	[self drawLineFrom:lastPoint to:point];
	
	touchNeedsDot = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (touchNeedsDot) {
		CGPoint point = [[touches anyObject] locationInView:self];
		[self drawLineFrom:point to:point];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
