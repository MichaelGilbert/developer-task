//
//  DoodleConfig.h
//  Doodler
//
//  Created by Sam Dean on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Represents the configuration for a doodle
@interface DoodleConfig : NSObject {
 @private
  UIColor *backgroundColor_;
  UIColor *strokeColor_;
}

// The background color for the doodle. This defaults to black.
// Setting it to nil will just reset it to the default.
@property (nonatomic, retain) UIColor *backgroundColor;

// The color the doodle should use when touched. This defaults to white.
// Setting it to nil will just reset it to the default.
@property (nonatomic, retain) UIColor *strokeColor;

@end
