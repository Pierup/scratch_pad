//
//  MerchantCollectionViewCell.m
//  PierPayDemo
//
//  Created by JHR on 15/3/20.
//  Copyright (c) 2015年 Pier.Inc. All rights reserved.
//

#import "MerchantCollectionViewCell.h"
#import "SDWebImage/UIButton+WebCache.h"

@implementation MerchantCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.merchantNameLabel.layer.cornerRadius = 5;
    self.merchantNameLabel.layer.masksToBounds = YES;
}

- (void)setMerchantNameLabel:(NSString *)merchantName merchantImageViewUrl:(NSString *)merchantImageViewUrl indexPath:(NSIndexPath *)indexPath
{
    _merchantNameLabel.text = merchantName;
    _indexPath =  indexPath;
    
    UIImage *categoryImage = [UIImage imageNamed:merchantImageViewUrl];
    [self.imageButton setBackgroundImage:categoryImage forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:categoryImage forState:UIControlStateHighlighted];
    [self.imageButton setBackgroundImage:categoryImage forState:UIControlStateSelected];
    [self.imageButton addTarget:self action:@selector(tapImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapImageButtonAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(merchantCollectionViewWithIndexPath:)]) {
        [self.delegate merchantCollectionViewWithIndexPath:self.indexPath];
    }
}

@end
