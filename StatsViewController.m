//
//  StatsViewController.m
//  RobotGame
//
//  Created by Diana Zmuda on 2/3/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "StatsViewController.h"
#import "Player.h"
#import "LevelViewController.h"
#import "ItemView.h"
#import "Item+Methods.h"
#import "DataStore.h"
#import "UpgradeViewController.h"

@interface StatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentHP;
@property (weak, nonatomic) IBOutlet UILabel *maxHP;
@property (weak, nonatomic) IBOutlet UILabel *maxShield;
@property (weak, nonatomic) IBOutlet UILabel *crit;
@property (weak, nonatomic) IBOutlet UILabel *eHit;
@property (weak, nonatomic) IBOutlet UILabel *mHit;
@property (weak, nonatomic) IBOutlet UILabel *pHit;
@property (weak, nonatomic) IBOutlet UILabel *ePoints;
@property (weak, nonatomic) IBOutlet UILabel *mPoints;
@property (weak, nonatomic) IBOutlet UILabel *pPoints;

@property (weak, nonatomic) IBOutlet UILabel *scrap;
@property (weak, nonatomic) IBOutlet UILabel *points;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *xp;

@end

@implementation StatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *bgImage = [UIImage imageNamed:@"inventory.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

- (void)setupView
{
    //remove the old inv items
    for (UIView* view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    //place the buttons
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(100, 430, 50, 50);
    [button4 setImage:[UIImage imageNamed:@"skills.png"] forState:UIControlStateNormal];
    button4.adjustsImageWhenHighlighted = NO;
    [button4 addTarget:self action:@selector(repair) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(270, 430, 50, 50);
    [button5 setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    button5.adjustsImageWhenHighlighted = NO;
    [button5 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(40, 430, 50, 50);
    [button6 setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    button6.adjustsImageWhenHighlighted = NO;
    [button6 addTarget:self action:@selector(upgrade) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    [self renderInventory];
    
    self.level = [[UILabel alloc] initWithFrame:CGRectMake(250, 415, 100, 15)];
    self.level.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.level.font = [self.crit.font fontWithSize:14];
    [self.view addSubview:self.level];
    
    [self updateLabels];
    
}

- (void)updateLabels
{
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

- (void)repair
{
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

- (void)dismiss
{
    [DataStore save];
    [self.lvc dismissModalViewControllerAnimated:YES];
}

- (void)renderInventory
{
    //the rects for checking if you drag into arm slots
    self.left = CGRectMake(125, 196, 50, 50);
    self.right = CGRectMake(182, 196, 50, 50);
    
    //render images in arm slots
    [self.lvc.player.leftArm setupLayer];
    self.lvc.player.leftArm.layer.frame = self.left;
    [self.view.layer addSublayer:self.lvc.player.leftArm.layer];
    
    [self.lvc.player.rightArm setupLayer];
    self.lvc.player.rightArm.layer.frame = self.right;
    [self.view.layer addSublayer:self.lvc.player.rightArm.layer];
    
    //render the draggable items that are in your inventory
    if (self.lvc.player.inv1) {
        self.inv1Item = [[ItemView alloc] initWithFrame:CGRectMake(55, 38, 50, 50) andItem:self.lvc.player.inv1 andSV:self];
        [self.view addSubview:self.inv1Item];
    }if (self.lvc.player.inv2) {
        self.inv2Item = [[ItemView alloc] initWithFrame:CGRectMake(120, 38, 50, 50) andItem:self.lvc.player.inv2 andSV:self];
        [self.view addSubview:self.inv2Item];
    } if (self.lvc.player.inv3) {
        self.inv3Item = [[ItemView alloc] initWithFrame:CGRectMake(180, 38, 50, 50) andItem:self.lvc.player.inv3 andSV:self];
        [self.view addSubview:self.inv3Item];
    } if (self.lvc.player.inv4) {
        self.inv4Item = [[ItemView alloc] initWithFrame:CGRectMake(240, 38, 50, 50) andItem:self.lvc.player.inv4 andSV:self];
        [self.view addSubview:self.inv4Item];
    }
}

- (void)upgrade
{
    UpgradeViewController *upgrades = [UpgradeViewController new];
    upgrades.lvc = self.lvc;
    [upgrades setupView];
    [self presentModalViewController:upgrades animated:YES];
}

@end
