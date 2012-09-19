//
//  DataStore.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class World, Level, Item, Mob, Player, Position, Square;

@interface DataStore : NSObject

+(NSArray*)allWorlds;
+(World*)newWorld;
+(Level*)newLevel;
+(Item*)newItem;
+(Mob*)newMob;
+(Player*)newPlayer;
+(Position*)newPosition;
+(Square*)newSquare;
+(void)save;

@end
