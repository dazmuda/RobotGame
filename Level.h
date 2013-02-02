//
//  Level.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Square, World;

@interface Level : NSManagedObject

@property (nonatomic, retain) NSSet *squares;
@property (nonatomic, retain) World *world;

//not saved in coredata
@property (strong, nonatomic) LevelViewController *lvc;
@property (strong, nonatomic) NSMutableDictionary *grid;

@end

@interface Level (CoreDataGeneratedAccessors)

- (void)addSquaresObject:(Square *)value;
- (void)removeSquaresObject:(Square *)value;
- (void)addSquares:(NSSet *)values;
- (void)removeSquares:(NSSet *)values;

@end
