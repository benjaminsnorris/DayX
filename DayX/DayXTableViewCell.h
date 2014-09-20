//
//  DayXTableViewCell.h
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayXTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *contentSummary;
@property (nonatomic, strong) UILabel *dateStamp;

@end
