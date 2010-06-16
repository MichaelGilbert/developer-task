//
//  DoodleView.h
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DoodleConfig.h"

@interface DoodleView : UIImageView {
	DoodleConfig *config;
	
	BOOL touchNeedsDot;
}

@property (nonatomic, retain) DoodleConfig *config;

@end
