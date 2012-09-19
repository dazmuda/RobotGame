//
//  Level.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Square, World, LevelViewController, Position;

@interface Level : NSManagedObject

@property (nonatomic, retain) NSSet *squares;
@property (nonatomic, retain) World *world;

//not in core data
@property LevelViewController *lvc;
@property (strong) NSMutableDictionary *grid;

-(void)createGrid;
-(void)createSquares;
-(void)createGridFromSquares;
-(void)checkPlayerPos:(Position*)playerPos;
-(BOOL)isItWall:(Position*)playerPos;

//in coredata, level has many squares which each have a position
//outside of coredata, we must implement a method that creates a grid given these squares

@end

@interface Level (CoreDataGeneratedAccessors)

- (void)addSquaresObject:(Square *)value;
- (void)removeSquaresObject:(Square *)value;
- (void)addSquares:(NSSet *)values;
- (void)removeSquares:(NSSet *)values;

@end
