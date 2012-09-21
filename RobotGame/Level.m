//
//  Level.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
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
#import "World.h"


@implementation Level

@dynamic squares;
@dynamic world;

//create a square set for coredata
-(void)createSquares {
    NSMutableSet *squareSet = [NSMutableSet new];
    
    Mob *mob1 = [Mob newWithHP:10 andShield:5 andDamage:2 andImage:1];
    Square *square12 = [Square floorWithX:1 andY:2];
    square12.mob = mob1;
    
    Mob *mob2 = [Mob newWithHP:10 andShield:7 andDamage:3 andImage:2];
    Square *square13 = [Square floorWithX:1 andY:3];
    square13.mob = mob2;
    
    Item *item1 = [Item newWithType:3 andDamage:2];
    Square *square14 = [Square floorWithX:1 andY:4];
    square14.item = item1;
    
    Mob *mob3 = [Mob newWithHP:12 andShield:7 andDamage:5 andImage:3];
    Square *square31 = [Square floorWithX:3 andY:1];
    square31.mob = mob3;
    
    Item *item2 = [Item newWithType:1 andDamage:3];
    Square *square43 = [Square floorWithX:4 andY:3];
    square43.item = item2;
    
    [squareSet addObject:[Square wallWithX:0 andY:0]];
    [squareSet addObject:[Square wallWithX:0 andY:1]];
    [squareSet addObject:[Square wallWithX:0 andY:2]];
    [squareSet addObject:[Square wallWithX:0 andY:3]];
    [squareSet addObject:[Square wallWithX:0 andY:4]];
    [squareSet addObject:[Square wallWithX:0 andY:5]];
    
    [squareSet addObject:[Square wallWithX:1 andY:0]];
    [squareSet addObject:[Square floorWithX:1 andY:1]];
    [squareSet addObject:square12];
    [squareSet addObject:square13];
    [squareSet addObject:square14];
    [squareSet addObject:[Square wallWithX:1 andY:5]];
    
    [squareSet addObject:[Square wallWithX:2 andY:0]];
    [squareSet addObject:[Square floorWithX:2 andY:1]];
    [squareSet addObject:[Square floorWithX:2 andY:2]];
    [squareSet addObject:[Square floorWithX:2 andY:3]];
    [squareSet addObject:[Square wallWithX:2 andY:4]];
    [squareSet addObject:[Square wallWithX:2 andY:5]];

    [squareSet addObject:[Square wallWithX:3 andY:0]];
    [squareSet addObject:square31];
    [squareSet addObject:[Square floorWithX:3 andY:2]];
    [squareSet addObject:[Square floorWithX:3 andY:3]];
    [squareSet addObject:[Square wallWithX:3 andY:4]];
    [squareSet addObject:[Square wallWithX:3 andY:5]];
    
    [squareSet addObject:[Square wallWithX:4 andY:0]];
    [squareSet addObject:[Square floorWithX:4 andY:1]];
    [squareSet addObject:[Square floorWithX:4 andY:2]];
    [squareSet addObject:square43];
    [squareSet addObject:[Square floorWithX:4 andY:4]];
    [squareSet addObject:[Square wallWithX:4 andY:5]];
    
    [squareSet addObject:[Square wallWithX:5 andY:0]];
    [squareSet addObject:[Square wallWithX:5 andY:1]];
    [squareSet addObject:[Square wallWithX:5 andY:2]];
    [squareSet addObject:[Square wallWithX:5 andY:3]];
    [squareSet addObject:[Square wallWithX:5 andY:4]];
    [squareSet addObject:[Square wallWithX:5 andY:5]];

    
    self.squares = [NSSet setWithSet:squareSet];
}

//create a grid to use for moving around
-(void)createGridFromSquares {
    self.grid = [NSMutableDictionary new];
    for (Square *square in self.squares) {
        Position *position = [Position withX:square.x andY:square.y];
        [self.grid setValue:square forKey:position];
    }
}

-(void)checkPlayerPos:(Position*)playerPos {
    //for every key in the grid dictionary
    for(Position *pos in self.grid) {
        //this is the value for that key
        if ([pos isEqual:playerPos]) {
            Square *square = [self.grid objectForKey:pos];
            
            //is the first object in the square a mob
            if (square.mob) {
                //trigger combat view
                UIViewController *cvc = [UIViewController new];
                CombatView *comView = [[CombatView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) andMob:square.mob andPlayer:self.lvc.player];
                [comView setupWithBlock:^{
                    //give the setup method a block that will
                    //remove the mob layer from the level view and set the square objects to nil
                    [[square.mob layer] removeFromSuperlayer];
                    square.mob = nil;
                }];
                //comView.lvc = self.lvc;
                comView.delegate = self.lvc;
                cvc.view = comView;
                [self.lvc presentModalViewController:cvc animated:YES];
                
            } else if (square.item) {
                //take item
                if (self.lvc.player.inv1 == nil) {
                    self.lvc.player.inv1 = square.item;
                    //remove item layer and object
                    [[square.item layer] removeFromSuperlayer];
                    square.item = nil;
                } else if (self.lvc.player.inv2 == nil) {
                    self.lvc.player.inv2 = square.item;
                    [[square.item layer] removeFromSuperlayer];
                    square.item = nil;
                } else if (self.lvc.player.inv3 == nil) {
                    self.lvc.player.inv3 = square.item;
                    [[square.item layer] removeFromSuperlayer];
                    square.item = nil;
                } else if (self.lvc.player.inv4 == nil) {
                    self.lvc.player.inv4 = square.item;
                    [[square.item layer] removeFromSuperlayer];
                    square.item = nil;
                }
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

@end
