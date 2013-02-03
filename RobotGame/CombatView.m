//
//  CombatView.m
//  Robots
//
//  Created by Diana Zmuda on 9/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "CombatView.h"
#import "Player+Methods.h"
#import "Mob.h"
#import "LevelViewController.h"
#import "Item.h"
#import "WorldViewController.h"
#import "DataStore.h"
#import "World.h"
#import "Score.h"

@interface CombatView () <AVAudioPlayerDelegate>

@property (assign, nonatomic) NSInteger mobHP;
@property (assign, nonatomic) NSInteger mobShields;
@property (assign, nonatomic) NSInteger playerShields;
@property (assign, nonatomic) NSInteger eWeapon;
@property (assign, nonatomic) NSInteger mWeapon;
@property (assign, nonatomic) NSInteger pWeapon;
@property (assign, nonatomic) BOOL mobStunned;

@property (strong, nonatomic) UILabel *playerHPLabel;
@property (strong, nonatomic) UILabel *playerShieldsLabel;
@property (strong, nonatomic) UILabel *mobHPLabel;
@property (strong, nonatomic) UILabel *mobShieldsLabel;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) CALayer *currentAnimation;
@property (strong, nonatomic) AVAudioPlayer* zapPlayer;
@property (strong, nonatomic) AVAudioPlayer* bangPlayer;
@property (strong, nonatomic) AVAudioPlayer* laserPlayer;

@end

@implementation CombatView

- (id)initWithFrame:(CGRect)frame andMob:(Mob *)mob andPlayer:(Player *)player
{
    self = [super initWithFrame:frame];
    self.mob = mob;
    self.player = player;
    
    UIImage *bgImage = [UIImage imageNamed:@"fightpurple.png"];
    if (self.mob.image == 2) {
        bgImage = [UIImage imageNamed:@"fightred.png"];
    } else if (self.mob.image == 3) {
        bgImage = [UIImage imageNamed:@"fightblue.png"];
    }
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    NSString *zaudioFilePath = [[NSBundle mainBundle] pathForResource:@"zap" ofType:@"wav"];
    NSURL *zaudioFileURL = [NSURL fileURLWithPath:zaudioFilePath];
    
    self.zapPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:zaudioFileURL error:nil];
    self.zapPlayer.delegate = self;
    [self.zapPlayer prepareToPlay];
    
    NSString *baudioFilePath = [[NSBundle mainBundle] pathForResource:@"bang" ofType:@"wav"];
    NSURL *baudioFileURL = [NSURL fileURLWithPath:baudioFilePath];
    
    self.bangPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:baudioFileURL error:nil];
    self.bangPlayer.delegate = self;
    [self.bangPlayer prepareToPlay];
    
    NSString *laudioFilePath = [[NSBundle mainBundle] pathForResource:@"laser" ofType:@"wav"];
    NSURL *laudioFileURL = [NSURL fileURLWithPath:laudioFilePath];
    
    self.laserPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:laudioFileURL error:nil];
    self.laserPlayer.delegate = self;
    [self.laserPlayer prepareToPlay];
    
    return self;
}

- (void)setupWithBlock:(void (^)(void))block
{
    //set up the temporary stats
    self.mobHP = self.mob.maxHP;
    self.mobShields = self.mob.maxShield;
    self.mobStunned = FALSE;
    self.playerShields = self.player.maxShield;
    self.eWeapon = 0;
    self.mWeapon = 0;
    self.pWeapon = 0;
    
    //add to your weapon damage for the left weapon
    if (self.player.leftArm.type == 1) {
        self.eWeapon += self.player.leftArm.damage;
    } else if (self.player.leftArm.type == 2) {
        self.mWeapon += self.player.leftArm.damage;
    } else if (self.player.leftArm.type == 3) {
        self.pWeapon += self.player.leftArm.damage;
    }
    //and for the right
    if (self.player.rightArm.type == 1) {
        self.eWeapon += self.player.rightArm.damage;
    } else if (self.player.rightArm.type == 2) {
        self.mWeapon += self.player.rightArm.damage;
    } else if (self.player.rightArm.type == 3) {
        self.pWeapon += self.player.rightArm.damage;
    }
    
    //set up the arm buttons
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 210, 87, 150)];
    self.rightButton.adjustsImageWhenHighlighted = NO;
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, 210, 87, 150)];
    self.leftButton.adjustsImageWhenHighlighted = NO;
    
    if (self.player.rightArm.type == 1) {
        [self.rightButton setImage:[UIImage imageNamed:@"eright.png"] forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(playerEHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.player.leftArm.type == 1) {
        [self.leftButton setImage:[UIImage imageNamed:@"eleft.png"] forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(playerEHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.player.rightArm.type == 2) {
        [self.rightButton setImage:[UIImage imageNamed:@"mright.png"] forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(playerMHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.player.leftArm.type == 2) {
        [self.leftButton setImage:[UIImage imageNamed:@"mleft.png"] forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(playerMHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.player.rightArm.type == 3) {
        [self.rightButton setImage:[UIImage imageNamed:@"pright.png"] forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(playerPHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.player.leftArm.type == 3) {
        [self.leftButton setImage:[UIImage imageNamed:@"pleft.png"] forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(playerPHit) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:self.rightButton];
    [self addSubview:self.leftButton];
    
    //add the labels
    self.playerHPLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 360, 200, 30)];
    self.playerHPLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.playerHPLabel];
    self.playerShieldsLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 390, 200, 30)];
    self.playerShieldsLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.playerShieldsLabel];
    self.mobHPLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 200, 30)];
    self.mobHPLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.mobHPLabel];
    self.mobShieldsLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 200, 30)];
    self.mobShieldsLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.mobShieldsLabel];
    
    //call the block that removes the mob from the level map
    block();
    
    [self updateLabels];
    [self setNeedsDisplay];
}

- (void)updateLabels
{
    self.playerHPLabel.text = [NSString stringWithFormat:@"Hull: %d", self.player.currentHP];
    self.playerShieldsLabel.text = [NSString stringWithFormat:@"Shield: %d", self.playerShields];
    self.mobHPLabel.text = [NSString stringWithFormat:@"Hull: %d", self.mobHP];
    self.mobShieldsLabel.text = [NSString stringWithFormat:@"Shield: %d", self.mobShields];
}

//you could also set up the labels using layers
- (void)placeLabelLayer
{
    //this is a label layer
    CATextLayer *statLabel = [[CATextLayer alloc] init];
    [statLabel setString:@"sweet combat numbers"];
    [statLabel setFont:@"Helvetica-Bold"];
    [statLabel setFrame:CGRectMake(50, 300, 300, 100)];
    [statLabel setFontSize:20];
    [statLabel setForegroundColor:[[UIColor blackColor] CGColor]];
    //statLabel.position = CGPointMake(100,100);
    [self.layer addSublayer:statLabel];
    [self setNeedsDisplay];
}

- (void)keyframeAnimate
{
    //lets animate that!
    CAKeyframeAnimation *slider = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //set yourself as the delegate so you can do stuff when the animation stops
    slider.delegate = self;
    CGPoint orig = CGPointMake(50,300);
    CGPoint point1 = CGPointMake(20, 200);
    CGPoint point2 = CGPointMake(100, 150);
    NSArray *spots = @[[NSValue valueWithCGPoint:orig],[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2]];
    [slider setValues:spots];
    [slider setDuration:1];
    [slider setKeyTimes:@[@(0.0),@(0.6),@(1.0)]];
    [self.currentAnimation addAnimation:slider forKey:@"slider"];
    //set the position to the end point so it doesn't snap back
    self.currentAnimation.position = CGPointMake(100,150);
}

- (void)playerEHit
{
    //disable the button until animation is complete
    self.leftButton.enabled = FALSE;
    self.rightButton.enabled = FALSE;
    
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        self.mobHP = self.mobHP - self.player.eHit - isCrit*self.player.eHit - self.eWeapon;
    } else {
        self.mobShields = self.mobShields - self.player.eHit - isCrit*self.player.eHit - self.eWeapon;
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    //special buff
    if (isCrit == 1 && self.player.eBuff == TRUE) {
        self.mobStunned = TRUE;
    }
    
    self.currentAnimation = [CALayer new];
    self.currentAnimation.frame = CGRectMake(50,300,46,100);
    UIImage *electricity = [UIImage imageNamed:@"ebullet.png"];
    self.currentAnimation.contents = (__bridge id)([electricity CGImage]);
    [self.layer addSublayer:self.currentAnimation];
    
    [self keyframeAnimate];
    //PLAY ZE SOUND
    [self.zapPlayer play];
    //trigger the mob's hit
    [self mobHit];
}

- (void)playerMHit
{
    self.leftButton.enabled = FALSE;
    self.rightButton.enabled = FALSE;
    
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        self.mobHP = self.mobHP - self.player.mHit - isCrit*self.player.mHit - self.mWeapon;
    } else {
        self.mobShields = self.mobShields - self.player.mHit - isCrit*self.player.mHit - self.mWeapon;
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    //special buff
    if (self.player.mBuff == TRUE) {
        self.playerShields += 1;
    }
    
    self.currentAnimation = [CALayer new];
    self.currentAnimation.frame = CGRectMake(50,300,46,100);
    UIImage *laser = [UIImage imageNamed:@"mbullet.png"];
    self.currentAnimation.contents = (__bridge id)([laser CGImage]);
    [self.layer addSublayer:self.currentAnimation];
    
    [self keyframeAnimate];
    [self.laserPlayer play];
    [self mobHit];
}

- (void)playerPHit
{
    self.leftButton.enabled = FALSE;
    self.rightButton.enabled = FALSE;
    
    //determine if its a crit
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        //if their shields are out hit them
        self.mobHP = self.mobHP - self.player.pHit - isCrit*self.player.pHit - self.pWeapon;
    } else {
        //else hit their shields
        self.mobShields = self.mobShields - self.player.pHit - isCrit*self.player.pHit - self.pWeapon;
        //special buff case
        if (self.player.pBuff == !TRUE) {
            self.mobHP = self.mobHP - .25*(self.player.pHit + self.pWeapon);
        }
        //if this shield hit destroyed shields, the excess hits them
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    self.currentAnimation = [CALayer new];
    self.currentAnimation.frame = CGRectMake(50,300,46,100);
    UIImage *missile = [UIImage imageNamed:@"pbullet.png"];
    self.currentAnimation.contents = (__bridge id)([missile CGImage]);
    [self.layer addSublayer:self.currentAnimation];
    
    [self keyframeAnimate];
    [self.bangPlayer play];
    [self mobHit];
}

- (void)mobHit
{
    //it only hits you if it isn't stunned
    if (self.mobStunned == FALSE) {
        if (self.playerShields <= 0) {
            //if your shields are out, direct hit
            self.player.currentHP -= self.mob.damage;
        } else {
            //else it hits your shields
            self.playerShields -= self.mob.damage;
            //if this shield hit destroyed shields, the excess hits directly
            if (self.playerShields <= 0) {
                float excess = 0 - self.playerShields;
                self.player.currentHP -= excess;
            }
        }
    }
    //if the mob was stunned it is no longer stunned
    self.mobStunned = FALSE;
    
    if (self.player.currentHP <= 0) {
        //display on screen
        UILabel *deadLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
        deadLabel.text = @"GORT LOST!";
        [self addSubview:deadLabel];
        //DISMISS ALL THE THINGS
        [self.delegate performSelector:@selector(diedInCombat) withObject:nil afterDelay:1];
        //saves the score you got to the datasore
        //removes the world from the datastore
    }
}

//this method is called every time the animation finishes
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    self.leftButton.enabled = TRUE;
    self.rightButton.enabled = TRUE;
    //it removes the layer
    [self.currentAnimation removeFromSuperlayer];
    [self updateLabels];
    [self isMobDead];
}

- (void)isMobDead
{
    if (self.mobHP <= 0) {
        //lock the buttons
        self.leftButton.enabled = FALSE;
        self.rightButton.enabled = FALSE;
        //indicate on the screen
        UILabel *winLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
        winLabel.text = @"GORT WINS AGAIN!";
        [self addSubview:winLabel];
        //grab their stuff and check level up
        self.player.xp += self.mob.xp;
        self.player.scrap += self.mob.scrap;
        if ([self.player didLevelUp]) {
            //indicate on the screen
            UILabel *dingLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
            dingLabel.text = @"GORT LEVELED UP!";
            [self addSubview:dingLabel];
        }
        //increment score
        self.player.world.score.wins += 1;
        //then wait a few seconds and dismiss
        [self.delegate performSelector:@selector(wonInCombat) withObject:nil afterDelay:1];
        //[self performSelector:@selector(backToLevel) withObject:self afterDelay:1];
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
