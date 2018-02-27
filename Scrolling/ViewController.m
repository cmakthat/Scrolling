//
//  ViewController.m
//  Scrolling
//
//  Created by Curtis Mak on 2018-02-25.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
    
}

- (void)keyboardWillAppear:(NSNotification*)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%@", NSStringFromCGRect(keyboardFrame));
    
    [self.scrollView setContentOffset:CGPointMake(0, keyboardFrame.size.height) animated:YES];
}
- (void)keyboardWillHide:(NSNotification*)notification{
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (IBAction)learnMoreAction:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
