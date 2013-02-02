//
//  Position.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject <NSCopying>

@property (assign, nonatomic) NSInteger x;
@property (assign, nonatomic) NSInteger y;

+ (Position *)withX:(NSInteger)x andY:(NSInteger)y;

@end
