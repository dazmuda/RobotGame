//
//  Mob.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Mob.h"
#import <QuartzCore/QuartzCore.h>

@implementation Mob

-(void)giveStats {
    self.maxHP = 15;
    self.maxShield = 5;
    self.damage = 3;
    self.scrap = 10;
    self.xp = 10;
}

-(void)setupLayer {
    self.layer = [CALayer new];
    self.layer.bounds = CGRectMake(0,0,72,72);
    self.layer.position = CGPointMake(0, 0);
    
    UIImage *mob = [UIImage imageNamed:@"purplebot.png"];
    self.layer.contents = (__bridge id)([mob CGImage]);
}

@end
