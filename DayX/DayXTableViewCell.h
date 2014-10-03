//
//  DayXTableViewCell.h
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayXEntryController.h"

@interface DayXTableViewCell : UITableViewCell

- (void)updateWithEntry:(Entry *)entry;

@end
