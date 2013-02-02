//
//  Square+Methods.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Square.h"
#import "Position.h"

@interface Square (Methods)

@property (nonatomic, retain) Position *position;

+ (Square *)wallWithX:(NSInteger)x andY:(NSInteger)y;
+ (Square *)floorWithX:(NSInteger)x andY:(NSInteger)y;

@end
