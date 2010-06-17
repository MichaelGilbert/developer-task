//
//  DoodleView.h
//  Doodler
//
//  Created by Sam Dean on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodleConfig.h"

// A DoodleView is a UI component that can allow the user to draw onto it
// It is conigured using a DoodleConfig object
@interface DoodleView : UIImageView {
 @private
	DoodleConfig *config_;
	
	BOOL touchNeedsDot_; // If we touch but don't move, use this flag to draw a dot when we end the touch
}

// The configuration of this doodle view.
@property (nonatomic, retain) DoodleConfig *config;

@end
