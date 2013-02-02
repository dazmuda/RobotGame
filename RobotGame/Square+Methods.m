//
//  Square+Methods.m
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Square+Methods.h"
#import "DataStore.h"

@implementation Square (Methods)

@dynamic position;

+ (Square *)wallWithX:(NSInteger)x andY:(NSInteger)y {
    //replace [Square new] with the datastore new method
    Square *wall = [DataStore newSquare];
    wall.isWall = TRUE;
    wall.x = x;
    wall.y = y;
    return wall;
}

+ (Square *)floorWithX:(NSInteger)x andY:(NSInteger)y {
    Square *floor = [DataStore newSquare];
    floor.isWall = FALSE;
    floor.x = x;
    floor.y = y;
    return floor;
}

@end
