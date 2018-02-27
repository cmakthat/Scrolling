//
//  TutorialViewController.m
//  Scrolling
//
//  Created by Curtis Mak on 2018-02-25.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray<UIView*> *pages;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = [[NSMutableArray alloc] init];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDelegate:self];
    [self setupPages];
}

- (void)setupPages{
    
    CGFloat buttonWidth = 200;
    CGFloat buttonHeight = 100;
    
    for ( int i = 0; i<4; i++ )
    {
        UIView *page = [[UIView alloc] initWithFrame:
                        CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - buttonWidth/2, self.view.bounds.size.height/2 - buttonHeight/2, buttonWidth, buttonHeight)];
        
        [button setTitle:@"Next Page" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [page addSubview:button];
        
        switch (i) {
            case 0:
                [page setBackgroundColor:[UIColor greenColor]];
                break;
                
            case 1:
                [page setBackgroundColor:[UIColor redColor]];
                break;
                
            case 2:
                [page setBackgroundColor:[UIColor blueColor]];
                break;
                
            case 3:
                [page setBackgroundColor:[UIColor orangeColor]];
                break;
        }
        [self.pages addObject:page];
        [self.scrollView addSubview:page];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * self.pages.count, 0)];
}

- (void)buttonAction{
    
    CGFloat scrollByHowMuch = self.scrollView.contentOffset.x + self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(scrollByHowMuch, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for ( int i = 0; i<self.pages.count; i++ )
    {
        UIView *page = self.pages[i];
        CGFloat alpha = ( 1 - ((page.frame.origin.x - scrollView.contentOffset.x)/self.view.frame.size.width));
        page.alpha = alpha;
        
        page.transform = CGAffineTransformMakeScale(alpha, alpha);
    }
}

@end
