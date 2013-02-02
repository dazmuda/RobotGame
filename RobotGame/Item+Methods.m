//
//  Item+Methods.m
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Item+Methods.h"
#import "DataStore.h"

@implementation Item (Methods)

- (void)setupLayer {
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

+ (Item *)newWithType:(NSInteger)type andDamage:(NSInteger)damage {
    Item *item = [DataStore newItem];
    item.type = type;
    item.damage = damage;
    item.scrap = damage*5;
    return item;
}

@end
