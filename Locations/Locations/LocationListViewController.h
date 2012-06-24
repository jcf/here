//
//  LocationListViewController.h
//  Locations
//
//  Created by James Conroy-Finn on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationViewController;

#import <CoreData/CoreData.h>

@interface LocationListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) LocationViewController *locationViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
