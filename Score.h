//
//  Score.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class World;

@interface Score : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, retain) World *world;

@end
