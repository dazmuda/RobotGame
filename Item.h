//
//  Item.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Square;

@interface Item : NSManagedObject

@property (nonatomic, assign) NSInteger damage;
@property (nonatomic, assign) NSInteger image;
@property (nonatomic, assign) NSInteger scrap;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, retain) Square *square;

//not in Coredata
@property (strong, nonatomic) CALayer *layer;

@end
