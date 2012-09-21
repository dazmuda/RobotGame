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
#import "Item.h"
#import "DataStore.h"
#import "UpgradeView.h"

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
    //remove the old inv items
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //place the buttons
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
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(100, 430, 50, 50);
    [button6 setImage:[UIImage imageNamed:@"skills.png"] forState:UIControlStateNormal];
    button6.adjustsImageWhenHighlighted = NO;
    [button6 addTarget:self action:@selector(upgrade) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button6];
    
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
    self.maxShield = [[UILabel alloc] initWithFrame:CGRectMake(250, 292, 100, 15)];
    self.maxShield.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.maxShield.font = [self.maxShield.font fontWithSize:14];
    [self addSubview:self.maxShield];
    self.crit = [[UILabel alloc] initWithFrame:CGRectMake(250, 310, 100, 15)];
    self.crit.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.crit.font = [self.crit.font fontWithSize:14];
    [self addSubview:self.crit];
    
    self.ePoints = [[UILabel alloc] initWithFrame:CGRectMake(250, 328, 100, 15)];
    self.ePoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.ePoints.font = [self.ePoints.font fontWithSize:14];
    [self addSubview:self.ePoints];
    self.mPoints = [[UILabel alloc] initWithFrame:CGRectMake(250, 345, 100, 15)];
    self.mPoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.mPoints.font = [self.mPoints.font fontWithSize:14];
    [self addSubview:self.mPoints];
    self.pPoints = [[UILabel alloc] initWithFrame:CGRectMake(250, 362, 100, 15)];
    self.pPoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.pPoints.font = [self.pPoints.font fontWithSize:14];
    [self addSubview:self.pPoints];
    
    self.points = [[UILabel alloc] initWithFrame:CGRectMake(250, 382, 100, 15)];
    self.points.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.points.font = [self.points.font fontWithSize:14];
    [self addSubview:self.points];
    self.scrap = [[UILabel alloc] initWithFrame:CGRectMake(250, 400, 100, 15)];
    self.scrap.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.scrap.font = [self.crit.font fontWithSize:14];
    [self addSubview:self.scrap];
    self.level = [[UILabel alloc] initWithFrame:CGRectMake(250, 415, 100, 15)];
    self.level.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.level.font = [self.crit.font fontWithSize:14];
    [self addSubview:self.level];
    
    [self updateLabels];
    
}

-(void)updateLabels {
    self.currentHP.text = [NSString stringWithFormat:@"%d", self.lvc.player.currentHP];
    self.maxHP.text = [NSString stringWithFormat:@"%d", self.lvc.player.maxHP];
    self.maxShield.text = [NSString stringWithFormat:@"%d", self.lvc.player.maxShield];
    self.crit.text = [NSString stringWithFormat:@"%d", self.lvc.player.crit];
    self.ePoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.ePoints];
    self.mPoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.mPoints];
    self.pPoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.pPoints];
    self.points.text = [NSString stringWithFormat:@"%d", self.lvc.player.points];
    self.scrap.text = [NSString stringWithFormat:@"%d", self.lvc.player.scrap];
    self.level.text = [NSString stringWithFormat:@"%d", self.lvc.player.level];
}

-(void)repair {
    double damage = self.lvc.player.maxHP - self.lvc.player.currentHP;
    if (self.lvc.player.scrap >= .5*damage) {
        self.lvc.player.scrap -= .5*damage;
        self.lvc.player.currentHP = self.lvc.player.maxHP;
    } else {
        double affordableRepair = self.lvc.player.scrap / .5;
        self.lvc.player.scrap = 0;
        self.lvc.player.currentHP += affordableRepair;
    }
    [self updateLabels];
}

-(void)dismiss {
    [DataStore save];
    [self.lvc dismissModalViewControllerAnimated:YES];
}

-(void)renderInventory {
    
    //the rects for checking if you drag into arm slots
    self.left = CGRectMake(125, 196, 50, 50);
    self.right = CGRectMake(182, 196, 50, 50);
    
    //render images in arm slots
    [self.lvc.player.leftArm setupLayer];
    self.lvc.player.leftArm.layer.frame = self.left;
    [self.layer addSublayer:self.lvc.player.leftArm.layer];
    
    [self.lvc.player.rightArm setupLayer];
    self.lvc.player.rightArm.layer.frame = self.right;
    [self.layer addSublayer:self.lvc.player.rightArm.layer];
    
    //render the draggable items that are in your inventory
    if (self.lvc.player.inv1) {
        self.inv1Item = [[ItemView alloc] initWithFrame:CGRectMake(55, 38, 50, 50) andItem:self.lvc.player.inv1 andSV:self];
        [self addSubview:self.inv1Item];
    }if (self.lvc.player.inv2) {
         self.inv2Item = [[ItemView alloc] initWithFrame:CGRectMake(120, 38, 50, 50) andItem:self.lvc.player.inv2 andSV:self];
        [self addSubview:self.inv2Item];
    } if (self.lvc.player.inv3) {
        self.inv3Item = [[ItemView alloc] initWithFrame:CGRectMake(180, 38, 50, 50) andItem:self.lvc.player.inv3 andSV:self];
        [self addSubview:self.inv3Item];
    } if (self.lvc.player.inv4) {
        self.inv4Item = [[ItemView alloc] initWithFrame:CGRectMake(240, 38, 50, 50) andItem:self.lvc.player.inv4 andSV:self];
        [self addSubview:self.inv4Item];
    }
}

-(void)upgrade{
    UIViewController *pvc = [UIViewController new];
    UpgradeView *upgrades = [[UpgradeView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    upgrades.lvc = self.lvc;
    [upgrades setupView];
    pvc.view = upgrades;
    [self.vc presentModalViewController:pvc animated:YES];
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
