//
//  Square.h
//  Robots
//
//  Created by Diana Zmuda on 9/11/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject

@property BOOL isWall;
@property NSMutableArray *objects;

//square model
//bool isHole
///NSArray *enemies

+(Square*)wallSquare;
+(Square*)floorSquare;

@end
