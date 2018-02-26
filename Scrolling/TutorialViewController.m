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
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.pages = [[NSMutableArray alloc] init];
    
    for ( int i = 0; i<4; i++ )
    {
        UIView *page = [self createPageViewAtIndex:i];
        [self.pages addObject:page];
        [self.scrollView addSubview:page];
        
//        UIView *page = [self createPageViewAutoLayoutAtIndex:i];
//        [self.pages addObject:page];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 4, 0)];
}

- (UIView*)createPageViewAtIndex:(NSInteger)index {
    
    UIView *page = [[UIView alloc] initWithFrame:self.view.bounds];
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [nextButton setTitle:@"Next Page" forState:UIControlStateNormal];
    [nextButton sizeToFit];
    
    CGRect frame = nextButton.frame;
    frame.origin.x = self.view.bounds.size.width/2 - frame.size.width/2;
    frame.origin.y = self.view.bounds.size.height/2 - frame.size.height/2;
    [nextButton setFrame:frame];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [page addSubview:nextButton];
    
    frame = page.frame;
    frame.origin.x = self.view.bounds.size.width * index;
    [page setFrame:frame];
    
    switch (index) {
        case 0:
            [page setBackgroundColor:[UIColor greenColor]];
            break;
            
        case 1:
            [page setBackgroundColor:[UIColor blueColor]];
            break;
            
        case 2:
            [page setBackgroundColor:[UIColor redColor]];
            break;
            
        case 3:
            [page setBackgroundColor:[UIColor orangeColor]];
            break;
    }
    
    return page;
}

- (UIView*)createPageViewAutoLayoutAtIndex:(NSInteger)index{
    
    UIView *page = [[UIView alloc] initWithFrame:self.view.bounds];
    page.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:page];
    
    [page.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    [page.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [page.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
    [page.heightAnchor constraintEqualToAnchor:self.scrollView.heightAnchor].active = YES;
    
    switch (index) {
        case 0: {
            
            [page.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor].active = YES;
            [page setBackgroundColor:[UIColor greenColor]];
            break;
        }
            
        case 1: {
            
            [page.leadingAnchor constraintEqualToAnchor:self.pages[index-1].trailingAnchor].active = YES;
            [page setBackgroundColor:[UIColor blueColor]];
            break;
        }
            
        case 2:
            [page.leadingAnchor constraintEqualToAnchor:self.pages[index-1].trailingAnchor].active = YES;
            [page setBackgroundColor:[UIColor redColor]];
            break;
            
        case 3:
            [page.leadingAnchor constraintEqualToAnchor:self.pages[index-1].trailingAnchor].active = YES;
            [page.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor].active = YES;
            [page setBackgroundColor:[UIColor orangeColor]];
            break;
    }
    return page;
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

- (void)nextButtonAction{
    
    CGFloat newXOffset = self.scrollView.contentOffset.x + self.scrollView.bounds.size.width;
    if ( newXOffset < self.scrollView.contentSize.width )
    {
        [self.scrollView setContentOffset:CGPointMake(newXOffset, 0) animated:YES];
    }
}

@end
