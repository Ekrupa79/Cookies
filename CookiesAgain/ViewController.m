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
#import "CookieCoreData.h"
#import "AppDelegate.h"

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
    [cookieCaller setupCookies];

    CookieCoreData *coreDataCaller = [[CookieCoreData alloc] init];
    cookies = [coreDataCaller getAllCookies];
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
    
    cell.layer.borderColor = [[UIColor redColor] CGColor];
    cell.layer.borderWidth = 2.0;
    
    Cookie *cookie = [cookies objectAtIndex:indexPath.row];
    cell.nameLbl.text = cookie.name;
    cell.priceLbl.text = [NSString stringWithFormat:@"£%@", cookie.price];

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

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
