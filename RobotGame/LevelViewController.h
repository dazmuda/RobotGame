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

@interface LevelViewController : UIViewController

@property (strong) Level *level;
@property (strong) LevelView *levelView;
@property (strong) Player *player;
@property (strong) World *world;

@end
