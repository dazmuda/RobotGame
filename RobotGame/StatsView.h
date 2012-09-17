//
//  StatsView.h
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;
@class LevelViewController;

@interface StatsView : UIView

@property Player *player;
@property LevelViewController *lvc;

@property CGRect left;
@property CGRect right;
@property CGRect inv;

//this stuff is defunct
@property UIView *leftArm;
@property UIView *rightArm;

-(void)setupView;

@end
