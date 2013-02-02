//
//  Square.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Mob;

@interface Square : NSManagedObject

@property (nonatomic, assign) BOOL isWall;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Mob *mob;

@end
