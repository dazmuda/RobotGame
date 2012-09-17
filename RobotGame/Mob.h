//
//  Mob.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mob : NSObject

@property int maxHP;
@property int maxShield;
@property int damage;

@property int scrap;
@property double xp;

@property (strong) CALayer *layer;

-(void)giveStats;
-(void)setupLayer;

@end
