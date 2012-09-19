//
//  Item.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property int type;
@property int damage;
@property int image;
@property int scrap;

//not in core data
@property (strong) CALayer *layer;
-(void)setupLayer;
+(Item*)newWithType:(int)type andDamage:(int)damage;

@end
