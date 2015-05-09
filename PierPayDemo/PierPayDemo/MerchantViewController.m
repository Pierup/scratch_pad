//
//  MerchantViewController.m
//  PierPayDemo
//
//  Created by JHR on 15/3/20.
//  Copyright (c) 2015年 Pier.Inc. All rights reserved.
//

#import "MerchantViewController.h"
#import "PIRHttpExecutor.h"
#import "MerchantCollectionViewCell.h"
#import "ProductListViewController.h"
#import "ProductCartViewController.h"

#pragma mark ---------------- MerchantViewController ------------------------

@interface MerchantViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, MerchantCollectionViewCellDelegate>

@property (nonatomic ,weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *merchantArray;

@property (nonatomic, strong) NSMutableArray *cartProductArray;

@end

@implementation MerchantViewController

#pragma mark -------------------------- System ----------------------------

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cartProductArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self setTitle:@"Categories"];
    [self getMerchantList];
    
//    UIImage *image = [UIImage imageNamed:@"chopping_cart_icon"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
//    [button setImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(gotoShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MerchantCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MerchantCollectionViewCell"];
}

#pragma mark ------------------- Service ----------------------------------
// Get Merchant List
- (void)getMerchantList
{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         @"1",@"page_no",
//                         @"2",@"platform",
//                         @"10",@"limit",
//                         nil];
//    [[PIRHttpExecutor getInstance] sendMessage:^(id respond) {
//        NSArray *array =  [[(NSDictionary *)respond objectForKey:@"result"] objectForKey:@"items"];
//        self.merchantArray = [NSMutableArray arrayWithCapacity:array.count];
//        for (int i = 0; i < array.count; i++) {
//            MerchantModel *merchant = [[MerchantModel alloc] init];
//            //merchant.phone = [array[i] objectForKey:@"phone"];
//            //merchant.country_code = [array[i] objectForKey:@"country_code"];
//            merchant.merchant_id = [array[i] objectForKey:@"merchant_id"];
//            NSLog(@"%@", merchant.merchant_id);
//            merchant.product_small_url = [array[i] objectForKey:@"logo_small_url"];
//            merchant.business_name = [array[i] objectForKey:@"business_name"];
//            [self.merchantArray addObject:merchant];
//        }
//        [self performSelectorOnMainThread:@selector(refreshCollectionView) withObject:nil waitUntilDone:NO];
//    } andRequestJson:dic andFailure:^(id error, int errorCode) {
//        
//    } andPath:@"/merchant_api/v1/query/get_merchants" method:@"get"];
    
    self.merchantArray = [NSMutableArray arrayWithCapacity:1];
    MerchantModel *table = [[MerchantModel alloc] init];
    table.merchant_id = @"table";
    table.product_small_url = @"table.jpg";
    table.business_name = @"Tables";
    [self.merchantArray addObject:table];
    
    MerchantModel *sofa = [[MerchantModel alloc] init];
    sofa.merchant_id = @"sofa";
    sofa.product_small_url = @"sofa.jpg";
    sofa.business_name = @"Sofas";
    [self.merchantArray addObject:sofa];
    
    MerchantModel *rug = [[MerchantModel alloc] init];
    rug.merchant_id = @"rug";
    rug.product_small_url = @"rug.jpg";
    rug.business_name = @"Rugs";
    [self.merchantArray addObject:rug];
    
    MerchantModel *bed = [[MerchantModel alloc] init];
    bed.merchant_id = @"bed";
    bed.product_small_url = @"bed.jpg";
    bed.business_name = @"Beds";
    [self.merchantArray addObject:bed];
    
    MerchantModel *lamp = [[MerchantModel alloc] init];
    lamp.merchant_id = @"lamp";
    lamp.product_small_url = @"lamp.jpg";
    lamp.business_name = @"Lamps";
    [self.merchantArray addObject:lamp];
    
}

- (void)refreshCollectionView
{
    [self.collectionView reloadData];
}

#pragma mark ----------------------- Delegate ------------------------------


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.merchantArray.count > 0) {
        return self.merchantArray.count;
    }else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MerchantCollectionViewCell";
    MerchantCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    if (self.merchantArray.count) {
        MerchantModel *merchant = self.merchantArray[indexPath.row];
        [cell setMerchantNameLabel:merchant.business_name merchantImageViewUrl:merchant.product_small_url indexPath:indexPath];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/4 - 15, [UIScreen mainScreen].bounds.size.width/4+10);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)merchantCollectionViewWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.merchantArray.count > 0) {
        ProductListViewController *productViewController = [[ProductListViewController alloc] init];
        productViewController.delegate=self;
        productViewController.merchantModel = self.merchantArray[indexPath.row];
        productViewController.cartProductArray = self.cartProductArray;
        NSLog(@"%@", self.cartProductArray);
        [self.navigationController pushViewController:productViewController animated:YES];
    }
}

-(void)sendCart:(NSMutableArray *)cart {
    self.cartProductArray = cart;
    [self.cartCountLabel setText:[NSString stringWithFormat:@"%ld",[_cartProductArray count]]];
}

- (IBAction)gotoShoppingCart:(id)sender{
    ProductCartViewController *productViewController = [[ProductCartViewController alloc] init];
    productViewController.cartProductArray = self.cartProductArray;
    [self.navigationController pushViewController:productViewController animated:YES];
}

@end
