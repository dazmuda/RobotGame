//
//  Mob+Methods.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Mob.h"

@interface Mob (Methods)

- (void)setupLayer;
+ (Mob *)newWithHP:(NSInteger)hp andShield:(NSInteger)shield andDamage:(NSInteger)damage andImage:(NSInteger)img;

@end
