//
//  World.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level, Player, Score;

@interface World : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Level *level;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Score *score;

@end
