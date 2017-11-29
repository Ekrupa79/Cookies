//
//  CustomCell.m
//  CookiesAgain
//
//  Created by Mac on 11/28/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _cookieImage.layer.cornerRadius = 50.0;
    _cookieImage.layer.borderColor = [[UIColor blackColor] CGColor];
    _cookieImage.layer.borderWidth = 2.0;
    _cookieImage.clipsToBounds = YES;
}

@end
