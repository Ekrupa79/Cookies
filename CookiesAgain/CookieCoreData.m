//
//  CookieCoreData.m
//  CookiesAgain
//
//  Created by Mac on 11/29/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "CookieCoreData.h"
#import "AppDelegate.h"
#import "Cookie.h"

@implementation CookieCoreData

-(NSManagedObjectContext *)getMangedObjectContext{
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    return context;
}

-(void)saveToCoreData:(Cookie *)cookie{
    NSManagedObjectContext *context = self.getMangedObjectContext;
    NSManagedObject *cookieEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CookieEntity" inManagedObjectContext:context];
    [cookieEntity setValue:[cookie.cookieID stringValue] forKey:@"cookieID"];
    [cookieEntity setValue:cookie.name forKey:@"name"];
    [cookieEntity setValue:cookie.imageURL forKey:@"imageURL"];
    [cookieEntity setValue:cookie.addDate forKey:@"addDate"];
    [cookieEntity setValue:[cookie.price stringValue] forKey:@"price"];
    
    __block NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Unable to Save: saveToCoreData %@", [error localizedDescription]);
    }
}

-(Cookie *)getFromCoreData:(NSString *)cookieName{
    NSManagedObjectContext *context = self.getMangedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CookieEntity"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", cookieName]];
    Cookie *cookieFromCoreData = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return cookieFromCoreData;
}

-(NSArray *)getAllCookies{
    NSManagedObjectContext *context = self.getMangedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CookieEntity"];
    NSMutableArray *allCookies = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return allCookies;
}

-(BOOL)checkCookieExistence:(NSString *)cookieName{
    NSManagedObjectContext *context = self.getMangedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CookieEntity"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", cookieName]];
    __block NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if(count == NSNotFound){NSLog(@"BAD ERROR: checkCookieExistence");}
    else if(count == 0){NSLog(@"%lu",(unsigned long)count);return NO;}
    return YES;
}

@end
