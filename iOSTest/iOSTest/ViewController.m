//
//  ViewController.m
//  iOSTest
//
//  Created by Sathish Nagappan on 4/7/15.
//  Copyright (c) 2015 Sathish Nagappan. All rights reserved.
//

#import "ViewController.h"
#import "PierPay.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (IBAction)payNow{
    NSDictionary *charge = [NSDictionary        dictionaryWithObjectsAndKeys:
                            @"Peter",       @"name",
                            @"1234567890",  @"phone",
                            @"US",          @"country_code",
                            @"MC0000000086",   @"merchant_id",
                            @"1.00",   @"amount",
                            @"USD",   @"currency",
                            @"http://fake-merchant.elasticbeanstalk.com/server/sdk/pay/MC0000000086",   @"server_url",
                            @"13123132",   @"order_id",
                            @"PierShop",   @"shop_name",nil];
    
    PierPay *pierpay = [[PierPay alloc] initWith:charge delegate:self];
    [self presentViewController:pierpay animated:YES completion:nil];
}

- (IBAction)payWithPier{
    NSDictionary *charge = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"MC0000000086",   @"merchant_id",
                            @"1.00",   @"amount",
                            @"USD",   @"currency",
                            @"http://fake-merchant.elasticbeanstalk.com/server/sdk/pay/MC0000000086",   @"server_url",
                            @"13123132",   @"order_id",
                            @"iOSTest",   @"shop_name",
                            @"testdummymerchant",   @"scheme",
                            nil];

    [PierPay createPayment:charge];
}

- (void)payWithPierComplete:(NSDictionary *)charge {
    NSLog(@"pay with pier complete");
    // Do anything after payment completion
    NSLog(@"%@", charge);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
