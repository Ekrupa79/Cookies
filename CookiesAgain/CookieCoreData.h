//
//  CookieCoreData.h
//  CookiesAgain
//
//  Created by Mac on 11/29/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Cookie.h"

@interface CookieCoreData : NSObject

-(NSManagedObjectContext *)getMangedObjectContext;
-(void)saveToCoreData:(Cookie *)cookieArr;
-(Cookie *)getFromCoreData:(NSString *)cookieName;
-(NSArray *)getAllCookies;
-(BOOL)checkCookieExistence:(NSString *)cookieName;

@end
