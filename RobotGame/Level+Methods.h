//
//  Level+Methods.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Level.h"
#import "LevelViewController.h"
#import "Position.h"

@interface Level (Methods)

- (void)createSquares;
- (void)createGridFromSquares;
- (void)checkPlayerPos:(Position *)playerPos;
- (BOOL)isItWall:(Position *)playerPos;

//in coredata, level has many squares which each have a position
//outside of coredata, we must implement a method that creates a grid given these squares

@end
