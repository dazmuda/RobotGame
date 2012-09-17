//
//  Position.h
//  Robots
//
//  Created by Diana Zmuda on 9/11/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject <NSCopying>

@property double x;
@property double y;

+(Position*)withX:(double)x andY:(double)y;

@end
