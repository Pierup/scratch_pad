//
//  ProductListViewController.h
//  PierPayDemo
//
//  Created by zyma on 4/5/15.
//  Copyright (c) 2015 Pier.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantViewController.h"

@protocol sendCart <NSObject>

-(void)sendCart:(NSMutableArray *)cart;

@end

@interface ProductListViewController : UIViewController

@property (nonatomic, strong) MerchantModel *merchantModel;

@property(nonatomic,assign)id delegate;
@property (nonatomic, strong) NSMutableArray *cartProductArray; //ProductModel

@end
