//
//  Level.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelViewController;
@class Position;

@interface Level : NSManagedObject

@property LevelViewController *lvc;
@property (strong) NSMutableArray *mobs;
//array of mob objects
@property (strong) NSMutableArray *items;
//array of item objects
@property (strong) NSMutableArray *walls;
//array of wall objects
@property (strong) NSMutableArray *floors;
//array of floor objects
@property (strong) NSString *name;
@property (strong) NSDictionary *grid;

-(void)createGrid;
-(void)checkPlayerPos:(Position*)playerPos;
-(BOOL)isItWall:(Position*)playerPos;

@end
