//
//  Square.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Mob, Position;

@interface Square : NSManagedObject

@property BOOL isWall;
@property int x;
@property int y;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Mob *mob;
@property (nonatomic, retain) Position *position;

+(Square*)wallWithX:(int)x andY:(int)y;
+(Square*)floorWithX:(int)x andY:(int)y;

@end
