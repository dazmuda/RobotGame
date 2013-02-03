//
//  Square.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

@class Item, Mob, Position;

@interface Square : NSManagedObject

@property (nonatomic, assign) BOOL isWall;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Mob *mob;

//not in coredata
@property (nonatomic, retain) Position *position;

@end
