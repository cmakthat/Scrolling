//
//  ViewController.m
//  Scrolling
//
//  Created by Curtis Mak on 2018-02-25.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

#import "ViewController.h"
#import "TutorialViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customAction) name:@"MyCustomNotificationAction" object:nil];
    
}

- (void)customAction{
    
    NSLog(@"CUSTOM ACTION");
}

- (void)keyboardWillShow:(NSNotification*)notification{
    
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.scrollView setContentOffset:CGPointMake(0, keyboardRect.size.height) animated:YES];
}


- (void)keyboardWillHide:(NSNotification*)notification{
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (IBAction)learnMoreAction:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    vc.sendInfoOver = @"Hello from learn more action";
    [self.navigationController pushViewController:vc animated:YES];
//
//    [self performSegueWithIdentifier:@"hello" sender:@"Hello from learn more action"];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//    TutorialViewController *vc = segue.destinationViewController;
//    vc.sendInfoOver = sender;
//}


@end
