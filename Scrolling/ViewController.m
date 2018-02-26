//
//  ViewController.m
//  Scrolling
//
//  Created by Curtis Mak on 2018-02-25.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginBottomConstraint;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)learnMoreAction:(id)sender {
    
    [self performSegueWithIdentifier:@"tutorialSegue" sender:nil];
}

- (void)keyboardWillAppear:(NSNotification*)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%@", NSStringFromCGRect(keyboardFrame));
    self.loginBottomConstraint.constant = keyboardFrame.size.height;
    [self.view layoutIfNeeded];
    
    CGPoint bottomPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomPoint animated:YES];
}

- (void)keyboardWillDisappear:(NSNotification*)notification{
    
    self.loginBottomConstraint.constant = 20;
    [self.view layoutIfNeeded];
    CGPoint topPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:topPoint animated:YES];
}

@end
