//
//  SplashViewController.m
//  PierPayDemo
//
//  Created by Sathish Nagappan on 4/28/15.
//  Copyright (c) 2015 Pier.Inc. All rights reserved.
//

#import "SplashViewController.h"
#import "MerchantViewController.h"

@interface SplashViewController ()

@property (nonatomic) CGFloat scrollOffset;

@end

@implementation SplashViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.enterButton.backgroundColor = [UIColor purpleColor];
    [self.enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupScrollView {
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * (screenWidth +1);
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, screenWidth+1, screenHeight)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"splash%d.jpg", i+1]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [image setClipsToBounds:YES];
        
        [self.scrollView addSubview:image];
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(screenWidth*numberOfViews, self.scrollView.frame.size.height);
    
//    [self.pageControl setNumberOfPages:numberOfViews];
//    [self.pageControl setCurrentPage:0];
//    [self.pageControl setBackgroundColor:[UIColor greenColor]];
    //[self.scrollView addSubview:self.pageControl];
    
    [self.view addSubview:self.scrollView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void) onTimer {
    
    self.scrollOffset += self.scrollView.frame.size.width;
    if (self.scrollOffset > self.scrollView.contentSize.width) {
        self.scrollOffset = 0;
    }
    
    //This makes the scrollView scroll to the desired position
    [self.scrollView setContentOffset:CGPointMake(self.scrollOffset, 0) animated:YES];
    
}

- (IBAction)enterTapped:(UIButton *)sender {
    MerchantViewController *mainController = [[MerchantViewController alloc] init];
    [self.navigationController pushViewController:mainController animated:YES];
}

@end
