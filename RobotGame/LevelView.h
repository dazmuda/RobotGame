//
//  LevelView.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LevelViewController;
@class Arrow;
@class Position;

@interface LevelView : UIView

@property LevelViewController *lvc;

-(void)renderGrid;

@end
