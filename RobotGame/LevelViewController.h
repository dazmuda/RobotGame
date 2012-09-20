//
//  LevelViewController.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Level;
@class LevelView;
@class Player;
@class World;
@class WorldViewController;
#import "CombatView.h"

@interface LevelViewController : UIViewController <CombatViewDelegate>

@property (strong) Level *level;
@property (strong) LevelView *levelView;
@property (strong) Player *player;
@property (strong) World *world;
@property (strong) WorldViewController *wvc;

-(id)initWithWorld:(World*)world andWVC:(WorldViewController*)wvc;

//dont have to declare since you're a delegate that def has these methods
//-(void)diedInCombat;
//-(void)wonInCombat;

@end
