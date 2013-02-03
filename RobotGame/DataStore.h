//
//  DataStore.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class World, Level, Item, Mob, Player, Position, Square, Score;

@interface DataStore : NSObject

+ (NSArray *)allWorlds;
+ (NSArray *)allScores;
+ (NSArray *)parseScores;
+ (World *)newWorld;
+ (Level *)newLevel;
+ (Item *)newItem;
+ (Mob *)newMob;
+ (Player *)newPlayer;
+ (Position *)newPosition;
+ (Square *)newSquare;
+ (Score *)newScore;
+ (void)save;
+ (void)destroy:(World *)world;

@end
