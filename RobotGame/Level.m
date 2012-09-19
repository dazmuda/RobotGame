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

-(void)createGrid {
        
    //self.player = [WorldDataStore newPlayer];
    
    //Mob *mob = [[Mob alloc] initWithHP:10 andShield:5 andDamage:2];
    Mob *mob = [Mob newWithHP:10 andShield:5 andDamage:2];
    [mob setupLayer];
    Square *mobSquare = [Square floorSquare];
    mobSquare.mob = mob;
    
    //Mob *mobHard = [[Mob alloc] initWithHP:10 andShield:7 andDamage:3];
    Mob *mobHard = [Mob newWithHP:10 andShield:7 andDamage:3];
    [mobHard setupLayer];
    Square *mobHardSquare = [Square floorSquare];
    mobHardSquare.mob = mobHard;
    
    //Item *item = [[Item alloc] initWithType:1 andDamage:2];
    Item *item = [Item newWithType:3 andDamage:2];
    [item setupLayer];
    Square *itemSquare = [Square floorSquare];
    itemSquare.item = item;
    
    NSDictionary *dictionary = @{
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
    self.grid = [NSMutableDictionary dictionaryWithDictionary:dictionary];
}

//from the squares, un-data them
//create position objects using their xy
//create squares using their stats

-(void)createSquares {
    NSMutableSet *squareSet = [NSMutableSet new];
    
    [squareSet addObject:[Square floorWithX:1 andY:1]];
    
    Mob *mob = [Mob newWithHP:10 andShield:5 andDamage:2];
    [mob setupLayer];
    Square *mobSquare = [Square floorWithX:1 andY:2];
    mobSquare.mob = mob;
    [squareSet addObject:mobSquare];
    
    Mob *mobHard = [Mob newWithHP:10 andShield:7 andDamage:3];
    [mobHard setupLayer];
    Square *mobHardSquare = [Square floorWithX:1 andY:3];
    mobHardSquare.mob = mobHard;
    [squareSet addObject:mobHardSquare];
    
    Item *item = [Item newWithType:3 andDamage:2];
    [item setupLayer];
    Square *itemSquare = [Square floorWithX:1 andY:4];
    itemSquare.item = item;
    [squareSet addObject:itemSquare];
    
    [squareSet addObject:[Square floorWithX:2 andY:1]];
    [squareSet addObject:[Square floorWithX:2 andY:2]];
    [squareSet addObject:[Square floorWithX:2 andY:3]];
    [squareSet addObject:[Square wallWithX:2 andY:4]];
    
    self.squares = [NSSet setWithSet:squareSet];
}

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
                CombatView *comView = [[CombatView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
                //give the combat view the player and mob
                comView.player = self.lvc.player;
                comView.mob = square.mob;
                [comView setupWithBlock:^{
                    //give the setup method a block that will
                    //remove the mob layer from the level view and set the square objects to nil
                    [[square.mob layer] removeFromSuperlayer];
                    square.mob = nil;
                }];
                comView.lvc = self.lvc;
                cvc.view = comView;
                [self.lvc presentModalViewController:cvc animated:YES];
                
            } else if (square.item) {
                //take item
                [self.lvc.player.inventory setByAddingObject:square.item];
                //remove item layer and object
                [[square.item layer] removeFromSuperlayer];
                square.item = nil;
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
