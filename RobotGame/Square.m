//
//  Square.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Square.h"
#import "Item.h"
#import "Mob.h"
#import "Position.h"
#import "DataStore.h"


@implementation Square

@dynamic isWall;
@dynamic item;
@dynamic mob;
@dynamic position;
@dynamic x;
@dynamic y;

+(Square*)wallWithX:(int)x andY:(int)y {
    //replace [Square new] with the datastore new method
    Square *wall = [DataStore newSquare];
    wall.isWall = TRUE;
    wall.x = x;
    wall.y = y;
    return wall;
}

+(Square*)floorWithX:(int)x andY:(int)y {
    Square *floor = [DataStore newSquare];
    floor.isWall = FALSE;
    floor.x = x;
    floor.y = y;
    return floor;
}

@end
