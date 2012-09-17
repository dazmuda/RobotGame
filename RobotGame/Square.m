//
//  Square.m
//  Robots
//
//  Created by Diana Zmuda on 9/11/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Square.h"

@implementation Square

+(Square*)wallSquare {
    Square *wall = [Square new];
    wall.isWall = TRUE;
    return wall;
}

+(Square*)floorSquare {
    Square *floor = [Square new];
    floor.isWall = FALSE;
    return floor;
}

@end
