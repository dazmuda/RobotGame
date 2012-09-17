//
//  CombatView.h
//  Robots
//
//  Created by Diana Zmuda on 9/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;
@class Mob;
@class LevelViewController;

@interface CombatView : UIView

@property Player *player;
@property Mob *mob;
@property LevelViewController *lvc;

-(void)setupWithBlock:(void(^)(void))block;

@end
