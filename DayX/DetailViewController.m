//
//  DetailViewController.m
//  DayX
//
//  Created by Ben Norris on 9/17/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "DayXEntryController.h"

#define margin 15
#define titleHeight 30
#define contentHeight 200
#define EntryKey @"entry"
#define TitleKey @"title"
#define ContentKey @"content"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *entryTitle;
@property (nonatomic, strong) UITextView *entryContent;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation DetailViewController

- (id)init {
    self = [super init];
    
    // Initialize the properties that need to be accessed before the view is loaded
    self.entryTitle = [UITextField new];
    self.entryContent = [UITextView new];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.top = [self navAndStatusBarHeight] + margin;
    
    self.entryTitle.frame = CGRectMake(margin, self.top, self.view.frame.size.width - (margin * 2), titleHeight);
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
    
    self.entryContent.frame = CGRectMake(margin, self.top, self.view.frame.size.width - (margin * 2), contentHeight);
    self.entryContent.delegate = self;
    self.entryContent.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.entryContent];
    self.top += contentHeight + margin;
    
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAndClose)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self saveEntry];
}
- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    
    self.entryTitle.text = dictionary[TitleKey];
    self.entryContent.text = dictionary[ContentKey];
}

- (void)saveAndClose {
    [self saveEntry];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveEntry {
    NSDictionary *entry = @{TitleKey: self.entryTitle.text, ContentKey: self.entryContent.text};
    if (self.dictionary) {
        [[DayXEntryController sharedInstance] replaceEntry:self.dictionary withEntry:entry];
    } else {
        [[DayXEntryController sharedInstance] addEntry:entry];
    }
    [self updateWithDictionary:entry];
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
