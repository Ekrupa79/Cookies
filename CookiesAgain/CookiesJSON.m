//  CookieJSON.m
//  CookieProject
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "CookiesJSON.h"
#import "Cookie.h"
#import "AppDelegate.h"
#import "CookieCoreData.h"

@implementation CookieJSON

+(instancetype)sharedInstance{
    static CookieJSON *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}
-(instancetype)initPrivate{
    if (self = [super init]){}
    return self;
}

-(NSArray *)setupCookies{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://m1xdev.coinscloud.com:49994/cookies.json"]];
    NSError *cookieError = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&cookieError];
    
    NSMutableArray *cookies = [[NSMutableArray alloc] init];
    
    NSArray *cookieData = [result objectForKey:@"cookies"];
    
    CookieCoreData *cdCookie = [[CookieCoreData alloc] init];
    
    for(int i=0;i<cookieData.count;i++){
        NSNumber *cookieID = [cookieData[i] objectForKey:@"id"];
        NSString *name = [cookieData[i] objectForKey:@"name"];
        NSNumber *price = [cookieData[i] objectForKey:@"price"];
        NSString *imageURL = [cookieData[i] objectForKey:@"imageURL"];
        NSString *addedOn = [cookieData[i] objectForKey:@"addedOn"];
        Cookie *cookie = [[Cookie alloc] initWithID:cookieID name:name imageUrl:imageURL addDate:addedOn price:price];
        
        if(![cdCookie checkCookieExistence:cookie.name]){
            NSLog(@"COOKIE DOES NOT EXIST: %@", cookie.name);
            [cdCookie saveToCoreData:cookie];
        }else{
            NSLog(@"COOKIE EXISTS!");
        }
        
        [cookies addObject:cookie];
    }
    
    //This is where data would be dumped into CoreData. Instead it is being returned to the
    //ViewController as an array of Cookie objects to be used as items for the
    //UICollectionView.
    
    return cookies;
}

@end

