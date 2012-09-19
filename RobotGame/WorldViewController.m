//
//  WorldViewController.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/18/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "WorldViewController.h"
#import "World.h"
#import "DataStore.h"
#import "LevelViewController.h"
#import "Level.h"
#import "Player.h"
#import "DataStore.h"

@interface WorldViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *allWorlds;
@property UITableView *tableView;

@end

@implementation WorldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.allWorlds = [DataStore allWorlds];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 240) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview: self.tableView];
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 240, 30, 30)];
    [newButton setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(createNewWorld) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allWorlds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Populate the cells
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"world"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"world"];
    }
    
    cell.imageView.image = nil;
    
    World *currentWorld = [self.allWorlds objectAtIndex: indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", currentWorld.date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LevelViewController *lvc = [LevelViewController new];
    World *currentWorld = [self.allWorlds objectAtIndex:indexPath.row];
    lvc.world = currentWorld;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self presentModalViewController:lvc animated:YES];
}

-(void)createNewWorld {
    World *world = [DataStore newWorld];
    
    world.date = [NSDate date];
    
    Level *level = [DataStore newLevel];
    [level createSquares];
    [level createGridFromSquares];
    world.level = level;
    
    Player *player = [DataStore newPlayer];
    [player beginStats];
    world.player = player;
    
    self.allWorlds = [DataStore allWorlds];
    [self.tableView reloadData];
    
    //[DataStore save];
}

@end
