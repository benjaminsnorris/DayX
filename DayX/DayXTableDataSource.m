//
//  DayXTableDataSource.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXTableDataSource.h"

@implementation DayXTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"Datestamp";
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}
@end
