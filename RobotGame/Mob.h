//
//  Mob.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mob : NSManagedObject

@property int maxHP;
@property int maxShield;
@property int damage;
@property int scrap;
@property int xp;
@property int image;
@property int type;

//not in core data
@property (strong) CALayer *layer;
-(void)setupLayer;
+(Mob*)newWithHP:(int)hp andShield:(int)shield andDamage:(int)damage andImage:(int)img;

@end
