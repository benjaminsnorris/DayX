//
//  DetailViewController.h
//  DayX
//
//  Created by Ben Norris on 9/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayXEntryController.h"

@class DetailViewController;

@interface DetailViewController : UIViewController

- (void)updateWithEntry:(DayXEntry *)entry;

@end
