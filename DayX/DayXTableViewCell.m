//
//  DayXTableViewCell.m
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXTableViewCell.h"
#import "DayXEntryController.h"

#define margin 15
#define titleHeight 20
#define subtitleHeight 15

@implementation DayXTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    CGFloat widthMinusMargin = self.contentView.bounds.size.width - (margin * 3);
    CGFloat top = 10;
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, titleHeight)];
    [self.contentView addSubview:self.title];
    top += titleHeight;
    
    self.contentSummary = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, subtitleHeight)];
    self.contentSummary.font = [UIFont systemFontOfSize:12];
    self.contentSummary.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [self .contentView addSubview:self.contentSummary];
    top += subtitleHeight;

    self.dateStamp = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, subtitleHeight)];
    self.dateStamp.font = [UIFont systemFontOfSize:12];
    self.dateStamp.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [self.contentView addSubview:self.dateStamp];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
