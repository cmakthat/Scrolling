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
@property (strong, nonatomic) NSMutableArray *pages;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pages = [[NSMutableArray alloc] init];
    [self.scrollView setDelegate:self];
    [self.scrollView setPagingEnabled:YES];
    [self setupPages];
}

- (void)setupPages{
    
    for ( int i = 0; i<4; i++ )
    {
        UIView *page = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageTapped)];
        [page addGestureRecognizer:tap];
        
        switch (i) {
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
                
            default:
                break;
        }
        
        [self.pages addObject:page];
        [self.scrollView addSubview:page];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * self.pages.count, 0)];
    
}

- (void)pageTapped{
    
    CGFloat howMuchToScrollByX = self.view.frame.size.width + self.scrollView.contentOffset.x;
    [self.scrollView setContentOffset:CGPointMake(howMuchToScrollByX, 0) animated:YES];

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyCustomNotificationAction" object:nil];
    
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


















