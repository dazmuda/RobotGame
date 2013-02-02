//
//  Item+Methods.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Item.h"

@interface Item (Methods)

- (void)setupLayer;
+ (Item *)newWithType:(NSInteger)type andDamage:(NSInteger)damage;

@end
