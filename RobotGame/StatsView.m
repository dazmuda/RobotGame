//
//  StatsView.m
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "StatsView.h"
#import "Player.h"
#import "LevelViewController.h"
#import "ItemView.h"
#import <QuartzCore/QuartzCore.h>

@interface StatsView ()
@property UILabel *currentHP;
@property UILabel *maxHP;
@property UILabel *maxShield;
@property UILabel *eHit;
@property UILabel *mHit;
@property UILabel *pHit;
@property UILabel *ePoints;
@property UILabel *mPoints;
@property UILabel *pPoints;
@property UILabel *crit;
@property UILabel *scrap;
@property UILabel *points;
@property UILabel *level;
@property UILabel *xp;
@end

@implementation StatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        CALayer *bgLayer = [CALayer new];
        //        bgLayer.bounds = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
        //        bgLayer.frame = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
        //        UIImage *inventory = [UIImage imageNamed:@"inventory.png"];
        //        bgLayer.contents = (__bridge id)([inventory CGImage]);
        //        [self.layer addSublayer:bgLayer];
        
        UIImage *bgImage = [UIImage imageNamed:@"inventory.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    }
    return self;
}

- (void) setupView {
    //place the buttons
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 50, 50);
    [button1 setImage:[UIImage imageNamed:@"ehit.png"] forState:UIControlStateNormal];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 addTarget:self action:@selector(increaseEPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(50, 0, 50, 50);
    [button2 setImage:[UIImage imageNamed:@"mhit.png"] forState:UIControlStateNormal];
    button2.adjustsImageWhenHighlighted = NO;
    [button2 addTarget:self action:@selector(increaseMPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(100, 0, 50, 50);
    [button3 setImage:[UIImage imageNamed:@"phit.png"] forState:UIControlStateNormal];
    button3.adjustsImageWhenHighlighted = NO;
    [button3 addTarget:self action:@selector(increasePPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(40, 430, 50, 50);
    [button4 setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    button4.adjustsImageWhenHighlighted = NO;
    [button4 addTarget:self action:@selector(repair) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(270, 430, 50, 50);
    [button5 setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    button5.adjustsImageWhenHighlighted = NO;
    [button5 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button5];
    
    [self renderInventory];
    
    //place the labels
    self.currentHP = [[UILabel alloc] initWithFrame:CGRectMake(250, 260, 100, 15)];
    self.currentHP.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.currentHP.font = [self.currentHP.font fontWithSize:14];
    [self addSubview:self.currentHP];
    self.maxHP = [[UILabel alloc] initWithFrame:CGRectMake(250, 275, 100, 15)];
    self.maxHP.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.maxHP.font = [self.maxHP.font fontWithSize:14];
    [self addSubview:self.maxHP];
    self.maxShield = [[UILabel alloc] initWithFrame:CGRectMake(250, 290, 100, 15)];
    self.maxShield.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.maxShield.font = [self.maxShield.font fontWithSize:14];
    [self addSubview:self.maxShield];
    self.crit = [[UILabel alloc] initWithFrame:CGRectMake(250, 305, 100, 15)];
    self.crit.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.crit.font = [self.crit.font fontWithSize:14];
    [self addSubview:self.crit];
    
    
    
    self.scrap = [[UILabel alloc] initWithFrame:CGRectMake(250, 400, 100, 15)];
    self.scrap.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.scrap];
    self.scrap.font = [self.crit.font fontWithSize:14];
    self.level = [[UILabel alloc] initWithFrame:CGRectMake(250, 415, 100, 15)];
    self.level.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.level];
    self.level.font = [self.crit.font fontWithSize:14];
    
    
    //    self.ePoints = [[UILabel alloc] initWithFrame:CGRectMake(250, 305, 100, 15)];
    //    self.ePoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    //    [self addSubview:self.ePoints];
    //    self.points = [[UILabel alloc] initWithFrame:CGRectMake(250, 320, 100, 15)];
    //    self.points.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    //    [self addSubview:self.points];
    
    [self updateLabels];
    [self setNeedsDisplay];
    
}

-(void)updateLabels {
    self.currentHP.text = [NSString stringWithFormat:@"%ld", lroundf(self.player.currentHP)];
    self.maxHP.text = [NSString stringWithFormat:@"%d", self.player.maxHP];
    self.maxShield.text = [NSString stringWithFormat:@"%d", self.player.maxShield];
    self.crit.text = [NSString stringWithFormat:@"%d", self.player.crit];
    
    self.scrap.text = [NSString stringWithFormat:@"%d", self.player.scrap];
    self.level.text = [NSString stringWithFormat:@"%d", self.player.level];
    
    self.ePoints.text = [NSString stringWithFormat:@"%d", self.player.ePoints];
    self.points.text = [NSString stringWithFormat:@"%d", self.player.points];
}

-(void)increaseEPoints {
    if (self.player.points >0) {
        self.player.ePoints += 1;
        self.player.points -= 1;
        self.player.eHit += 1;
        self.player.crit += 1;
        if (self.player.ePoints == 3) {
            self.player.eBuff = TRUE;
        }
        if (self.player.ePoints == 6) {
            self.player.eMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)increaseMPoints {
    if (self.player.points >0) {
        self.player.mPoints += 1;
        self.player.points -= 1;
        self.player.mHit += 1;
        self.player.maxShield += 1;
        if (self.player.mPoints == 3) {
            self.player.mBuff = TRUE;
        }
        if (self.player.mPoints == 6) {
            self.player.mMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)increasePPoints {
    if (self.player.points >0) {
        self.player.pPoints += 1;
        self.player.points -= 1;
        self.player.pHit += 1;
        self.player.maxHP += 2;
        if (self.player.mPoints == 3) {
            self.player.mBuff = TRUE;
        }
        if (self.player.mPoints == 6) {
            self.player.mMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)repair {
    double damage = self.player.maxHP - self.player.currentHP;
    if (self.player.scrap >= .5*damage) {
        self.player.scrap -= .5*damage;
        self.player.currentHP = self.player.maxHP;
    } else {
        double affordableRepair = self.player.scrap / .5;
        self.player.scrap = 0;
        self.player.currentHP += affordableRepair;
    }
    [self updateLabels];
}

-(void)dismiss {
    [self.lvc dismissModalViewControllerAnimated:YES];
}

-(void)renderInventory {
    
    //bottom row is equipped arms slots
    self.left = CGRectMake(0, 100, 50, 50);
    self.right = CGRectMake(50, 100, 50, 50);
    self.inv = CGRectMake(0, 50, 50, 50);
    //    self.leftArm = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    //    [self addSubview:self.leftArm];
    //    self.rightArm = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    //    [self addSubview:self.rightArm];
    
    //the items in the equipped arms slots
    Item *leftItem = [self.player.equipped objectForKey:@"left"];
    ItemView *leftItemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 100, 50, 50) andItem:leftItem];
    leftItemView.sv = self;
    [self addSubview:leftItemView];
    Item *rightItem = [self.player.equipped objectForKey:@"right"];
    ItemView *rightItemView = [[ItemView alloc] initWithFrame:CGRectMake(50, 100, 50, 50) andItem:rightItem];
    rightItemView.sv = self;
    [self addSubview:rightItemView];
    
    //middle row is items in inventory
    for (Item *item in self.player.items) {
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 50, 50, 50) andItem:item];
        itemView.sv = self;
        itemView.player = self.player;
        [self addSubview:itemView];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
