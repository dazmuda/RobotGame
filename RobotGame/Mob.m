//
//  Mob.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Mob.h"
#import <QuartzCore/QuartzCore.h>
#import "DataStore.h"

@implementation Mob

@dynamic maxHP;
@dynamic maxShield;
@dynamic damage;
@dynamic scrap;
@dynamic xp;
@dynamic image;
@dynamic type;

-(id)initWithHP:(int)hp andShield:(int)shield andDamage:(int)damage {
    self = [super init];
    self.maxHP = hp;
    self.maxShield = shield;
    self.damage = damage;
    return self;
}

+(Mob*)newWithHP:(int)hp andShield:(int)shield andDamage:(int)damage {
    Mob *mob = [DataStore newMob];
    mob.maxHP = hp;
    mob.maxShield = shield;
    mob.damage = damage;
    mob.scrap = mob.maxHP + mob.maxShield + mob.damage;
    mob.xp = mob.maxHP + mob.maxShield + mob.damage;
    return mob;
}

-(void)setupLayer {
    self.layer = [CALayer new];
    self.layer.bounds = CGRectMake(0,0,72,72);
    self.layer.position = CGPointMake(0, 0);
    
    UIImage *mob = [UIImage imageNamed:@"purplebot.png"];
    self.layer.contents = (__bridge id)([mob CGImage]);
}

@end
