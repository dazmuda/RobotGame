//
//  Score.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/20/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Score : NSManagedObject

@property int level;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property int wins;

@end
