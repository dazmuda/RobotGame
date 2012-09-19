//
//  Position.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Position.h"

@implementation Position

+(Position*)withX:(double)x andY:(double)y {
    Position *newPos = [Position new];
    newPos.x = x;
    newPos.y = y;
    return newPos;
}

//we are implementing this copy method so we can use position as a key in an NSDict
- (id)copyWithZone:(NSZone *)zone {
    return [Position withX:self.x andY:self.y];
}

- (BOOL)isEqual:(id)anObject {
    if ([anObject isKindOfClass:[Position class]]) {
        Position *otherObject = anObject;
        if (self.x == otherObject.x && self.y == otherObject.y) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (NSUInteger)hash {
    NSDictionary *dict = @{ @"x" : @(self.x), @"y" : @(self.y) };
    return dict.hash;
}


@end
