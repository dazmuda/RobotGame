//
//  Item.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Item.h"
#import <QuartzCore/QuartzCore.h>

@implementation Item

-(void)giveStats {
    self.type = 1;
    self.name = @"Super Cool Projectile Launcher";
    self.damage = 1;
    self.scrap = 5;
}

-(void)setupLayer {
    self.layer = [CALayer new];
    self.layer.bounds = CGRectMake(0,0,72,72);
    
    UIImage *item = [UIImage imageNamed:@"redbot.png"];
    self.layer.contents = (__bridge id)([item CGImage]);
}

-(id)initWithName:(NSString *)name andType:(int)type andDamage:(int)damage {
    self = [super init];
    self.type = type;
    self.name = name;
    self.damage = damage;
    self.scrap = damage*5;
    return self;
}

@end
