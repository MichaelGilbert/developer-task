//
//  DoodleConfig.h
//  Doodler
//
//  Created by obs on 16/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DoodleConfig : NSObject {
	UIColor *backgroundColor;
	UIColor *strokeColor;
}

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *strokeColor;

@end
