//
//  DetailViewController.m
//  DayX
//
//  Created by Ben Norris on 9/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"

#define margin 15
#define titleHeight 30
#define contentHeight 200
#define dateHeight 20
#define titleKey @"title"
#define contentKey @"content"
#define dateKey @"date"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *entryTitle;
@property (nonatomic, strong) UITextView *entryContent;
@property (nonatomic, strong) NSDate *entryDatestamp;
@property (nonatomic, strong) UILabel *dateAndTime;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, strong) DayXEntry *entry;

@end

@implementation DetailViewController

- (id)init {
    self = [super init];
    
    // Initialize the properties that need to be accessed before the view is loaded
    self.entryTitle = [UITextField new];
    self.entryContent = [UITextView new];
    self.entryDatestamp = [NSDate new];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.top = [self navAndStatusBarHeight] + margin;
    CGFloat widthMinusMargin = self.view.frame.size.width - (margin * 2);
    
    // Display title
    self.entryTitle.frame = CGRectMake(margin, self.top, widthMinusMargin, titleHeight);
    self.entryTitle.delegate = self;
    self.entryTitle.placeholder = @"Entry title";
    self.entryTitle.borderStyle = UITextBorderStyleRoundedRect;
    self.entryTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.entryTitle addTarget:self action:@selector(saveEntry) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.entryTitle];
    self.top += titleHeight + margin;
    
    // Horizontal rule
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.top, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    [self.view addSubview:lineView];
    self.top += margin + 1;
    
    // Display content
    self.entryContent.frame = CGRectMake(margin, self.top, widthMinusMargin, contentHeight);
    self.entryContent.delegate = self;
    self.entryContent.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.entryContent];
    self.top += contentHeight + margin;
    
    // Display datestamp
    self.dateAndTime = [[UILabel alloc] initWithFrame:CGRectMake(margin, self.view.frame.size.height - dateHeight - margin, widthMinusMargin, dateHeight)];
    self.dateAndTime.text = [self formateDate:self.entryDatestamp];
    self.dateAndTime.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    self.dateAndTime.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.dateAndTime];
    
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAndClose)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self saveEntry];
}
- (void)updateWithEntry:(DayXEntry *)entry {
    self.entry = entry;
    
    self.entryTitle.text = entry.title;
    self.entryContent.text = entry.content;
    self.entryDatestamp = entry.datestamp;
}

- (void)saveAndClose {
    [self saveEntry];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveEntry {
    NSDictionary *dictionary = @{titleKey: self.entryTitle.text, contentKey: self.entryContent.text, dateKey: [NSDate date]};
    DayXEntry *entry = [[DayXEntry alloc] initWithDictionary:dictionary];
    if (self.entry) {
        [[DayXEntryController sharedInstance] replaceEntry:self.entry withEntry:entry];
    } else {
        [[DayXEntryController sharedInstance] addEntry:entry];
    }
    [self updateWithEntry:entry];
    [self.dateAndTime setText:[self formateDate:[NSDate date]]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.entryTitle resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self.entryContent resignFirstResponder];
    return YES;
}

    // Used to hide the keyboard
//- (void)doneEditing {
//    [self.view endEditing:YES];
//    self.navigationItem.rightBarButtonItem = nil;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self textDidChange];
//}
//
//- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self textDidChange];
//}
//
//- (void)textDidChange {
//    self.navigationItem.rightBarButtonItem = self.doneButton;
//}

- (NSString *)formateDate:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:date];
}
- (CGFloat)navAndStatusBarHeight {
    return self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
