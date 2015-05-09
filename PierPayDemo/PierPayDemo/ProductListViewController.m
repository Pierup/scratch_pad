//
//  ProductListViewController.m
//  PierPayDemo
//
//  Created by zyma on 4/5/15.
//  Copyright (c) 2015 Pier.Inc. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListTableViewCell.h"
#import "PierPay.h"
#import "PIRHttpExecutor.h"
#import "ProductCartViewController.h"

@interface ProductListViewController ()<ProductListTableViewCellDeleagte, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *cartCountLable;
@property (nonatomic, strong) NSMutableDictionary *merchantParam;

@end

@implementation ProductListViewController

-(void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%@", self.cartProductArray);
    [self.delegate sendCart:self.cartProductArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Product"];
    [self initData];
    [self.cartCountLable setText:[NSString stringWithFormat:@"%ld",[_cartProductArray count]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    _merchantParam = [[NSMutableDictionary alloc] init];
    //_cartProductArray = [[NSMutableArray alloc] init];
    [self getMerchantProduct:self.merchantModel.merchant_id];
}

#pragma mark ------------------- Service ----------------------------------
//Get Products
- (void)getMerchantProduct:(NSString *)merchant_id
{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         @"2",@"platform",
//                         merchant_id,@"merchant_id",
//                         nil];
//    [[PIRHttpExecutor getInstance] sendMessage:^(id respond) {
//        NSArray *array =  [(NSDictionary *)respond objectForKey:@"result"];
//        NSMutableArray *productArray = [NSMutableArray arrayWithCapacity:array.count];
//        NSString *server_url = [(NSDictionary *)respond objectForKey:@"server_url"];
//        for (int i = 0; i < array.count; i++) {
//            ProductModel *shopListModel = [[ProductModel alloc] init];
//            shopListModel.amount = [array[i] objectForKey:@"amount"];
//            shopListModel.image = [array[i] objectForKey:@"image"];
//            shopListModel.currency = [array[i] objectForKey:@"currency"];
//            shopListModel.server_url = server_url;
//            shopListModel.shop_name = self.merchantModel.business_name;
//            [productArray addObject:shopListModel];
//        }
//        self.merchantModel.shopListModelArray = productArray;
//        [self.tableView reloadData];
//        
//    } andRequestJson:dic andFailure:^(id error, int errorCode) {
//        
//    } andPath:@"/merchant_api/v1/fake/products" method:@"get"];
    
    NSArray *productImages;
    NSArray *productAmounts;
    
    if ([merchant_id isEqualToString:@"sofa"]) {
        productImages = [NSArray arrayWithObjects:@"bantam.jpg", @"sleeper.jpg", @"swan.jpg", @"noguchi.jpg", @"como.jpg", nil];
        productAmounts = [NSArray arrayWithObjects:@"43.35", @"50.50", @"70.23", @"10.05", @"40.07", nil];
    } else if ([merchant_id isEqualToString:@"table"]){
        productImages = [NSArray arrayWithObjects:@"saarinen.jpg", @"min.jpg", @"nesting.jpg", @"noguchitable.jpg", @"nelson.jpg", nil];
        productAmounts = [NSArray arrayWithObjects:@"23.37", @"12.55", @"30.26", @"9.15", @"7.07", nil];
    } else if ([merchant_id isEqualToString:@"rug"]){
        productImages = [NSArray arrayWithObjects:@"nesta.jpg", @"rangoli.jpg", @"cowhide.jpg", nil];
        productAmounts = [NSArray arrayWithObjects:@"32.43", @"20.57", @"19.24", nil];
    } else if ([merchant_id isEqualToString:@"lamp"]){
        productImages = [NSArray arrayWithObjects:@"spun.jpg", @"omoon.jpg", @"grasshopper.jpg", @"cortina.jpg", nil];
        productAmounts = [NSArray arrayWithObjects:@"6.43", @"80.57", @"39.24", @"44.56", nil];
    } else if ([merchant_id isEqualToString:@"bed"]){
        productImages = [NSArray arrayWithObjects:@"minbed.jpg", @"nest.jpg", @"parallel.jpg", nil];
        productAmounts = [NSArray arrayWithObjects:@"16.47", @"28.52", @"33.29", @"24.57", nil];
    }
    
    NSMutableArray *productArray = [NSMutableArray arrayWithCapacity:[productImages count]];
    
    ProductModel *shopListModel;
    for(int i=0; i<productImages.count; i++){
        shopListModel = [[ProductModel alloc] init];
        shopListModel.amount = [productAmounts objectAtIndex:i];
        shopListModel.image = [productImages objectAtIndex:i];
        [productArray addObject:shopListModel];
    }
    
    self.merchantModel.shopListModelArray = productArray;
    
}

#pragma marl - --------------------------- Deleagte ---------------------------

#pragma mark - ProductListTableViewCellDeleagte

- (void)addToCart:(ProductModel *)model{
    NSLog(@"%@", self.cartProductArray);
    [_cartProductArray addObject:model];
    [self.cartCountLable setText:[NSString stringWithFormat:@"%ld",[_cartProductArray count]]];
}

-(NSString *)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    NSInteger randomInt = (NSInteger)(from+(arc4random() % (to-from+1)));//+1,result is [from to]; else is [from, to)
    return [NSString stringWithFormat:@"%ld",randomInt];
}

- (void)showSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Pier Payment"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Select Payment Model"
                                  otherButtonTitles:@"Pay now", @"Pay With Pier App",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1) {
        PierPay *pierpay = [[PierPay alloc] init];
        [pierpay createPayment:_merchantParam pay:^{
            [self presentViewController:pierpay animated:YES completion:nil];
        } completion:^(NSDictionary *result, NSError *error) {
            [self payWithPierComplete:result];
        }];
    }else if(buttonIndex == 2) {
        /**
         * charge
         * name:            Required     Type       Description
         * 1.phone           YES          NSString   user phone.
         * 2.country_code    YES          NSString   the country code of user phone.
         * 3.merchant_id     YES          NSString   your id in pier.
         * 4.server_url      YES          NSString   your server url of accepting auth token,amount,currency, and making the real payment with the pier server SDK.
         * 5.scheme          YES          NSString   merchant App scheme
         */
        NSDictionary *chargeDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [_merchantParam objectForKey:@"amount"], @"amount",
                                   [_merchantParam objectForKey:@"currency"], @"currency",
                                   [_merchantParam objectForKey:@"merchant_id"], @"merchant_id",
                                   [_merchantParam objectForKey:@"server_url"], @"server_url",
                                   @"piermerchant", @"scheme",
                                   [_merchantParam objectForKey:@"shop_name"],@"shop_name",nil];
        
        [PierPay createPayment:chargeDic];
        
    }else if(buttonIndex == 3) {
        
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - PierPayDelegate

/**
 *
 *  @abstract Call Back When Pay With Pier In Merchant App.
 *
 *  @param result
 *    key        Type            Description
 *  - status     NSNumber        Showing the status of sdk execution.It means successful if is '1', else is '2'.
 *  - message    NSString        Showing the message from pier.
 *  - amount     NSString        amount.
 *  - currency   NSString        NSString
 *  - result     NSDictionary    Showing the value of output params of pier (This parameter is extended).
 *
 */
- (void)payWithPierComplete:(NSDictionary *)result
{
    NSInteger status = [[result objectForKey:@"status"] integerValue];
    if (status == 2) {
        //failed
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Failed" message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (status == 1){
        //success
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Succeeded" message:[NSString stringWithFormat:@"Total Amount: %@",[result objectForKey:@"amount"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.merchantModel.shopListModelArray.count > 0) {
        return self.merchantModel.shopListModelArray.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ProductListTableViewCell";
    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.delegate = self;
    }
    [cell updateCell:[self.merchantModel.shopListModelArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - Action

- (IBAction)gotoShoppingCart:(id)sender{
    ProductCartViewController *productViewController = [[ProductCartViewController alloc] init];
    productViewController.cartProductArray = self.cartProductArray;
    productViewController.merchant_id = self.merchantModel.merchant_id;
    [self.navigationController pushViewController:productViewController animated:YES];
}


@end
