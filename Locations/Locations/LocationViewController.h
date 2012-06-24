//
//  LocationViewController.h
//  Locations
//
//  Created by James Conroy-Finn on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (retain, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *latCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *lngCell;
@property (retain, nonatomic) IBOutlet UITableViewCell *mapCell;

@end
