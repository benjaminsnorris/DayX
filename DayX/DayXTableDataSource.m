//
//  DayXTableDataSource.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXTableDataSource.h"
#import "DayXEntryController.h"

#define TitleKey @"title"
#define ContentKey @"content"

@implementation DayXTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DayXEntryController sharedInstance].entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    DayXEntry *entry = [DayXEntryController sharedInstance].entries[indexPath.row];
    
    cell.textLabel.text = entry.title;
//    cell.detailTextLabel.text = @"Datestamp";
//    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
