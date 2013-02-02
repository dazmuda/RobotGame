//
//  Mob.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Square;

@interface Mob : NSManagedObject

@property (nonatomic, assign) NSInteger damage;
@property (nonatomic, assign) NSInteger image;
@property (nonatomic, assign) NSInteger maxHP;
@property (nonatomic, assign) NSInteger maxShield;
@property (nonatomic, assign) NSInteger scrap;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger xp;
@property (nonatomic, retain) Square *square;

//not in coredata
@property (strong) CALayer *layer;

@end
