//
//  DayXTableDataSource.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXTableDataSource.h"
#import "DayXEntryController.h"
#import "DayXTableViewCell.h"

@implementation DayXTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DayXEntryController sharedInstance].entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DayXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[DayXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    DayXEntry *entry = [DayXEntryController sharedInstance].entries[indexPath.row];
    cell.title.text = entry.title;
    cell.contentSummary.text = entry.content;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *formattedDateAndTime = [dateFormatter stringFromDate:entry.datestamp];
    cell.dateStamp.text = formattedDateAndTime;
    
    return cell;

}

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DayXEntryController sharedInstance] removeEntry:[DayXEntryController sharedInstance].entries[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

@end
