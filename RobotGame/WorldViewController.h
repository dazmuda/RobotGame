//
//  WorldViewController.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/18/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class World;

@interface WorldViewController : UIViewController

- (void)diedInWorld:(World *)world;
- (void)exitedGame;

@end
