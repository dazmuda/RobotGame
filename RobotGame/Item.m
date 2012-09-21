//
//  Item.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Item.h"
#import <QuartzCore/QuartzCore.h>
#import "DataStore.h"

@implementation Item

@dynamic type;
@dynamic damage;
@dynamic image;
@dynamic scrap;

-(void)setupLayer {
    self.layer = [CALayer new];
    self.layer.bounds = CGRectMake(0,0,72,72);
    UIImage *item = [UIImage imageNamed:@"phit.png"];
    if (self.type == 1) {
        item = [UIImage imageNamed:@"ehit.png"];
    } else if (self.type == 2) {
        item = [UIImage imageNamed:@"mhit.png"];
    }
    self.layer.contents = (__bridge id)([item CGImage]);
}

+(Item*)newWithType:(int)type andDamage:(int)damage {
    Item *item = [DataStore newItem];
    item.type = type;
    item.damage = damage;
    item.scrap = damage*5;
    return item;
}


@end
