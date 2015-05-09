//
//  ShopNavigationController.m
//  PierPayDemo
//
//  Created by Sathish Nagappan on 4/28/15.
//  Copyright (c) 2015 Pier.Inc. All rights reserved.
//

#import "ShopNavigationController.h"

@interface ShopNavigationController ()

@end

@implementation ShopNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(IBAction)goToShoppingCart:(id)sender {
    NSLog(@"go to cart");
}

@end
