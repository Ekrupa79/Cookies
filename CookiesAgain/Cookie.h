//
//  Cookie.h
//  CookiesAgain
//
//  Created by Mac on 11/28/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cookie : NSObject

@property (assign, nonatomic) int *success;
@property (strong, nonatomic) NSNumber *cookieID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *addDate;
@property (strong, nonatomic) NSNumber *price;

-(id)initWithID:(NSNumber *)cookieID name:(NSString *)name imageUrl:(NSString *)imageURL addDate:(NSString *)addDate price:(NSNumber *)price;

@end
