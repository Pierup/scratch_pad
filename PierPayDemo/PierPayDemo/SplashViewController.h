//
//  SplashViewController.h
//  PierPayDemo
//
//  Created by Sathish Nagappan on 4/28/15.
//  Copyright (c) 2015 Pier.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIButton *enterButton;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)IBOutlet UIPageControl *pageControl;
- (IBAction)enterTapped:(UIButton *)sender;

@end
