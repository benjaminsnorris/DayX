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
#define EntryKey @"entry"
#define TitleKey @"title"
#define ContentKey @"content"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *entryTitle;
@property (nonatomic, strong) UITextView *entryContent;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, assign) CGFloat top;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.top = [self navAndStatusBarHeight] + margin;
    
    self.entryTitle = [[UITextField alloc] initWithFrame:CGRectMake(margin, self.top, self.view.frame.size.width - (margin * 2), titleHeight)];
    self.entryTitle.delegate = self;
    self.entryTitle.placeholder = @"Entry title";
    self.entryTitle.borderStyle = UITextBorderStyleRoundedRect;
    self.entryTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.entryTitle addTarget:self action:@selector(saveEntry) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.entryTitle];
    self.top += titleHeight + margin;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.top, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    [self.view addSubview:lineView];
    self.top += margin + 1;
    
    self.entryContent = [[UITextView alloc] initWithFrame:CGRectMake(margin, self.top, self.view.frame.size.width - (margin * 2), contentHeight)];
    self.entryContent.delegate = self;
    self.entryContent.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.entryContent];
    self.top += contentHeight + margin;
    
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing)];
    
    NSDictionary *entry = [[NSUserDefaults standardUserDefaults] objectForKey:EntryKey];
    [self updateWithDictionary:entry];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self saveEntry];
}
- (void)updateWithDictionary:(NSDictionary *)dictionary {
    if(dictionary) {
        self.entryTitle.text = dictionary[TitleKey];
        self.entryContent.text = dictionary[ContentKey];
    }
}

- (void)saveEntry {
    NSDictionary *entry = @{TitleKey: self.entryTitle.text, ContentKey: self.entryContent.text};
    [[NSUserDefaults standardUserDefaults] setObject:entry forKey:EntryKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.entryTitle resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self.entryContent resignFirstResponder];
    return YES;
}

- (void)doneEditing {
    [self textFieldShouldReturn:self.entryTitle];
    [self textViewShouldEndEditing:self.entryContent];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self textDidChange];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self textDidChange];
}

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem = self.doneButton;
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
