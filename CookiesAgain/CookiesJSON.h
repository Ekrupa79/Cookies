//
//  CookieJSON.h
//  CookieProject
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookieJSON : NSObject

@property (strong) NSMutableArray *coreDataCookies;

+(instancetype)sharedInstance;
-(NSArray *)setupCookies;

@end

