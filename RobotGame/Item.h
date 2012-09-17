//
//  Item.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong) NSString *name;
@property int type;
@property int damage;
@property int scrap;
@property (strong) CALayer *layer;

-(void)giveStats;
-(void)setupLayer;
-(id)initWithName:(NSString*)name andType:(int)type andDamage:(int)damage;

@end
