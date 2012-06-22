//
//  NewLocationViewController.h
//  Locations
//
//  Created by James Conroy-Finn on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewLocationController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *lat;
@property (retain, nonatomic) IBOutlet UILabel *lng;
@property (retain, nonatomic) IBOutlet UIView *map;
@end
