//
//  DoodleView.m
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoodleView.h"


@implementation DoodleView

@synthesize config=config_;

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
  [config_ release];
  [super dealloc];
}

- (UIImage *) image {
  // If we don't have an image already, use the config to create a black one with the correct background
  if (nil == [super image]) {
    UIGraphicsBeginImageContext([self frame].size);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[[self config] backgroundColor] CGColor]);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, [self frame].size.width, [self frame].size.height));
    [super setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
  }

  return [super image];
}

- (DoodleConfig *)config {
  // If we don't have a config set, create a defualt one and use that
  if (nil == config_)
    config_ = [[DoodleConfig alloc] init];
  return config_;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];

  // If we are being added to a superview, make sure that we have the corrct background image
  // setup.
  [self image];
}

#pragma mark -
#pragma mark Touch methods

- (void) drawLineFrom:(CGPoint)src to:(CGPoint)dst {
  // Create an image context with the current contents of the doodle
  UIGraphicsBeginImageContext([self frame].size);
  [[self image] drawInRect:[self bounds]];
  CGContextRef context = UIGraphicsGetCurrentContext();

  // We want pretty lines
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, 3);
  CGContextSetStrokeColorWithColor(context, [[[self config] strokeColor] CGColor]);

  // Draw the line
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, src.x, src.y);
  CGContextAddLineToPoint(context, dst.x, dst.y);
  CGContextStrokePath(context);

  // Store it and end the context
  [self setImage:UIGraphicsGetImageFromCurrentImageContext()];
  UIGraphicsEndImageContext();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  touchNeedsDot_ = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  // Get the start and end points of the touch
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self];
  CGPoint lastPoint = [touch previousLocationInView:self];
    
  // Draw a line between them
  [self drawLineFrom:lastPoint to:point];

  // We've moved so we don't need to draw a dot when we end this touch
  touchNeedsDot_ = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if (touchNeedsDot_) {
    // If we didn't move, draw a dot where we tapped the screen
    CGPoint point = [[touches anyObject] locationInView:self];
    [self drawLineFrom:point to:point];
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
