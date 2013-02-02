//
//  LevelView.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LevelView.h"
#import "Player.h"
#import "Mob+Methods.h"
#import "LevelViewController.h"
#import "Level+Methods.h"
#import "Item+Methods.h"
#import "CombatView.h"
#import "Position.h"
#import "Square+Methods.h"

@implementation LevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }
    return self;
}

-(void)renderGrid {
    
    //for every key in the grid dictionary
    for(Position *pos in self.lvc.level.grid) {
        //this is the value for that key
        Square *square = [self.lvc.level.grid objectForKey:pos];
        
        //if is a floor
        if (square.isWall == FALSE) {
            //get a random number
            int randNum = arc4random() %5;
            
            //render a random floor tile there
            CALayer *floor = [CALayer new];
            int xxx = pos.x * 72;
            int yyy = pos.y * 72;
            floor.frame = CGRectMake(xxx,yyy,72,72);
            UIImage *floorImage = [UIImage new];
            if (randNum == 0) {
                floorImage = [UIImage imageNamed:@"floor1.png"];
            } else if (randNum == 1) {
                floorImage = [UIImage imageNamed:@"floor2.png"];
            } else if (randNum == 2) {
                floorImage = [UIImage imageNamed:@"floor3.png"];
            } else if (randNum == 3) {
                floorImage = [UIImage imageNamed:@"floor4.png"];
            } else if (randNum == 4) {
                floorImage = [UIImage imageNamed:@"floor5.png"];
            }
            floor.contents = (__bridge id)([floorImage CGImage]);
            [self.layer addSublayer:floor];
            
            //if the floor has a mob on it
            if (square.mob) {
                [square.mob setupLayer];
                square.mob.layer.frame = CGRectMake(xxx, yyy, 72, 72);
                [self.layer addSublayer:square.mob.layer];
                
                //if the floor has an item on it
            } else if (square.item) {
                [square.item setupLayer];
                square.item.layer.frame = CGRectMake(xxx+20, yyy+20, 40, 40);
                [self.layer addSublayer:square.item.layer];
            }
        }
        
        //if it is a wall
        else if (square.isWall == TRUE) {
            //render a wall there
            CALayer *wall = [CALayer new];
            int xxx = pos.x * 72;
            int yyy = pos.y * 72;
            wall.frame = CGRectMake(xxx,yyy,72,72);
            UIImage *wallImage = [UIImage imageNamed:@"redfloor.png"];
            wall.contents = (__bridge id)([wallImage CGImage]);
            [self.layer addSublayer:wall];
        }
        
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
// Drawing code
//}

@end
