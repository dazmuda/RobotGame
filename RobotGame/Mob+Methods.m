//
//  Mob+Methods.m
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Mob+Methods.h"
#import "DataStore.h"

@implementation Mob (Methods)

- (void)setupLayer
{
    self.layer = [CALayer new];
    self.layer.bounds = CGRectMake(0,0,72,72);
    self.layer.position = CGPointMake(0, 0);
    
    UIImage *mob = [UIImage imageNamed:@"purplebot.png"];
    if (self.image == 2) {
        mob = [UIImage imageNamed:@"redbot.png"];
    } else if (self.image == 3) {
        mob = [UIImage imageNamed:@"bluebot.png"];
    }
    self.layer.contents = (__bridge id)([mob CGImage]);
}

+ (Mob *)newWithHP:(NSInteger)hp andShield:(NSInteger)shield andDamage:(NSInteger)damage andImage:(NSInteger)img
{
    Mob *mob = [DataStore newMob];
    mob.maxHP = hp;
    mob.maxShield = shield;
    mob.damage = damage;
    mob.scrap = mob.maxHP + mob.maxShield + mob.damage;
    mob.xp = mob.maxHP + mob.maxShield + mob.damage;
    mob.image = img;
    return mob;
}

@end
