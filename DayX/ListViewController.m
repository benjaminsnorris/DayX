//
//  ListViewController.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "DayXTableDataSource.h"
#import "DetailViewController.h"
#import "DayXEntryController.h"

#define EntryListKey @"entries"

@interface ListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DayXTableDataSource *dataSource;
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.title = @"Entries";
    
    self.dataSource = [DayXTableDataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    
    self.tableView.delegate = self;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.toolbar = [UIToolbar new];
    self.toolbar.tintColor = [UIColor redColor];
    UIBarButtonItem *clearAllButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear All" style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *buttons = [NSArray arrayWithObjects:spaceItem, clearAllButton, spaceItem, nil];
    CGSize toolbarSize = [self.toolbar sizeThatFits:self.view.bounds.size];
    self.toolbar.frame = CGRectMake(0, self.view.frame.size.height - toolbarSize.height, toolbarSize.width, toolbarSize.height);
    [self.view addSubview:self.toolbar];
    self.toolbar.hidden = YES;
    [self.toolbar setItems:buttons animated:YES];

//    self.navigationItem.leftBarButtonItem = self.clearButton;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailViewController = [DetailViewController new];
    [detailViewController updateWithEntry:[DayXEntryController sharedInstance].entries[indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)add {
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if([self.tableView isEditing]) {
        self.toolbar.hidden = NO;
    } else {
        self.toolbar.hidden = YES;
    }
}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSMutableArray *mutablePlayers = self.players.mutableCopy;
//    NSDictionary *player = mutablePlayers[sourceIndexPath.row];
//    [mutablePlayers removeObjectAtIndex:sourceIndexPath.row];
//    [mutablePlayers insertObject:player atIndex:destinationIndexPath.row];
//    [self savePlayers:mutablePlayers];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearAll {
    [[DayXEntryController sharedInstance] removeAllEntries];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
