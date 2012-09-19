//
//  Position.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject <NSCopying>

@property int x;
@property int y;

+(Position*)withX:(double)x andY:(double)y;

@end
