//
//  Level.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Level.h"
#import "Mob.h"
#import "Item.h"
#import "LevelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Position.h"
#import "Square.h"
#import "LevelView.h"
#import "CombatView.h"
#import "Player.h"

@implementation Level

-(void)createGrid {
    
    Mob *mob = [Mob new];
    Square *mobSquare = [Square floorSquare];
    [mob setupLayer];
    [mob giveStats];
    mobSquare.objects = [NSMutableArray arrayWithObject:mob];
    
    Mob *mobHard = [Mob new];
    Square *mobHardSquare = [Square floorSquare];
    [mobHard setupLayer];
    [mobHard giveStats];
    mobHard.maxShield = 7;
    mobHardSquare.objects = [NSMutableArray arrayWithObject:mobHard];
    
    Item *item = [[Item alloc] initWithName:@"Kickass Electric Gun" andType:1 andDamage:2];
    Square *itemSquare = [Square floorSquare];
    [item setupLayer];
    itemSquare.objects = [NSMutableArray arrayWithObject:item];
    
    self.grid = [NSDictionary new];
    self.grid = @{
    [Position withX:0 andY:0] : [Square wallSquare],
    [Position withX:0 andY:1] : [Square wallSquare],
    [Position withX:0 andY:2] : [Square wallSquare],
    [Position withX:0 andY:3] : [Square wallSquare],
    [Position withX:0 andY:4] : [Square wallSquare],
    [Position withX:0 andY:5] : [Square wallSquare],
    [Position withX:0 andY:6] : [Square wallSquare],
    
    [Position withX:1 andY:0] : [Square wallSquare],
    [Position withX:1 andY:1] : [Square floorSquare],
    [Position withX:1 andY:2] : [Square floorSquare],
    [Position withX:1 andY:3] : [Square floorSquare],
    [Position withX:1 andY:4] : [Square floorSquare],
    [Position withX:1 andY:5] : [Square floorSquare],
    [Position withX:1 andY:6] : [Square floorSquare],
    
    [Position withX:2 andY:0] : [Square wallSquare],
    [Position withX:2 andY:1] : itemSquare,
    [Position withX:2 andY:2] : [Square floorSquare],
    [Position withX:2 andY:3] : mobHardSquare,
    [Position withX:2 andY:4] : [Square floorSquare],
    [Position withX:2 andY:5] : [Square floorSquare],
    [Position withX:2 andY:6] : [Square floorSquare],
    
    
    [Position withX:3 andY:0] : [Square wallSquare],
    [Position withX:3 andY:1] : mobSquare,
    [Position withX:3 andY:2] : [Square wallSquare],
    [Position withX:3 andY:3] : [Square wallSquare],
    [Position withX:3 andY:4] : [Square floorSquare],
    [Position withX:3 andY:5] : [Square floorSquare],
    [Position withX:3 andY:6] : [Square floorSquare],
    
    [Position withX:4 andY:0] : [Square floorSquare],
    [Position withX:4 andY:1] : [Square floorSquare],
    [Position withX:4 andY:2] : [Square floorSquare],
    [Position withX:4 andY:3] : [Square floorSquare],
    [Position withX:4 andY:4] : [Square floorSquare],
    [Position withX:4 andY:5] : [Square floorSquare],
    [Position withX:4 andY:6] : [Square floorSquare],
    
    [Position withX:5 andY:0] : [Square floorSquare],
    [Position withX:5 andY:1] : [Square floorSquare],
    [Position withX:5 andY:2] : [Square floorSquare],
    [Position withX:5 andY:3] : [Square floorSquare],
    [Position withX:5 andY:4] : [Square floorSquare],
    [Position withX:5 andY:5] : [Square floorSquare],
    [Position withX:5 andY:6] : [Square floorSquare],
    };
}

-(void)checkPlayerPos:(Position*)playerPos {
    //for every key in the grid dictionary
    for(Position *pos in self.grid) {
        //this is the value for that key
        if ([pos isEqual:playerPos]) {
            Square *square = [self.grid objectForKey:pos];
            
            //is the first object in the square a mob
            if ([[square.objects objectAtIndex:0] isKindOfClass:[Mob class]]) {
                //trigger combat view
                UIViewController *cvc = [UIViewController new];
                CombatView *comView = [[CombatView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
                //give the combat view the player and mob
                comView.player = self.lvc.player;
                comView.mob = [square.objects objectAtIndex:0];
                [comView setupWithBlock:^{
                    //give the setup method a block that will
                    //remove the mob layer from the level view and set the square objects to nil
                    [[[square.objects objectAtIndex:0] layer] removeFromSuperlayer];
                    square.objects = nil;
                }];
                comView.lvc = self.lvc;
                cvc.view = comView;
                [self.lvc presentModalViewController:cvc animated:YES];
                
            } else if ([[square.objects objectAtIndex:0] isKindOfClass:[Item class]]) {
                //take item
                [self.lvc.player.items addObject:[square.objects objectAtIndex:0]];
                //remove item layer and object
                [[[square.objects objectAtIndex:0] layer] removeFromSuperlayer];
                square.objects = nil;
            }
        }
    }
}

-(BOOL)isItWall:(Position*)playerPos {
    BOOL isIt = FALSE;
    //for every key in the grid dictionary
    for(Position *pos in self.grid) {
        //this is the value for that key
        if ([pos isEqual:playerPos]) {
            Square *square = [self.grid objectForKey:pos];
            if (square.isWall == TRUE) {
                isIt = TRUE;
            }
        }
    }
    return isIt;
}


//create a new world model
//contains a current pos (gridpos object)
//contains a dict of key=grid positions object=square
//square contains everything at a grid position
//gridpos => square
//square model
//bool isHole
///NSArray *enemies
//NO CA LAYERS
//gridPos model
//double x
//double y

@end
