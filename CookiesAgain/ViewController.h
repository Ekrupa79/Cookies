//
//  ViewController.h
//  CookiesAgain
//
//  Created by Mac on 11/28/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *cookies;
@property (strong, nonatomic) IBOutlet UICollectionView *cookieCollection;

@end

