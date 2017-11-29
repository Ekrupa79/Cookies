//
//  ViewController.m
//  CookiesAgain
//
//  Created by Mac on 11/28/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "ViewController.h"
#import "CookiesJSON.h"
#import "CustomCell.h"
#import "Cookie.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize cookies;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UICollectionView Setup
    _cookieCollection.delegate = self;
    _cookieCollection.dataSource = self;
    [self.cookieCollection registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"CookieCell"];
    
    CookieJSON *cookieCaller = [[CookieJSON alloc] init];
    cookies = [cookieCaller setupCookies];
    //Intended for testing of Cookies array data, will be removed once CoreData is implemented
//    NSLog(@"%lu", (unsigned long)cookies.count);
//    for(int i = 0;i<cookies.count;i++){
//        NSLog(@"Name: %@", [[cookies objectAtIndex:i] name]);
//        NSLog(@"id: %d", [[[cookies objectAtIndex:i] cookieID] intValue]);
//        NSLog(@"imageUrl: %@",[[cookies objectAtIndex:i] imageURL]);
//        NSLog(@"price: %@", [[cookies objectAtIndex:i] price]);
//        NSLog(@"addDate: %@", [[cookies objectAtIndex:i] addDate]);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cookies.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [self.cookieCollection dequeueReusableCellWithReuseIdentifier:@"CookieCell" forIndexPath:indexPath];
    Cookie *cookie = [cookies objectAtIndex:indexPath.row];
    cell.nameLbl.text = cookie.name;
    cell.priceLbl.text = [NSString stringWithFormat:@"£%.02f", [cookie.price doubleValue]];

    //Setup for Image
    dispatch_async(dispatch_get_global_queue(0,0),^{
        NSData *cellData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:cookie.imageURL]];
        if(cellData == nil){return;}
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.cookieImage.image = [UIImage imageWithData:cellData];
        });
    });
    
    return cell;
}

@end
