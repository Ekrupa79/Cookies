//
//  Cookie.m
//  CookiesAgain
//
//  Created by Mac on 11/28/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "Cookie.h"

@implementation Cookie

-(id)initWithID:(NSNumber *)cookieID name:(NSString *)name imageUrl:(NSString *)imageURL addDate:(NSString *)addDate price:(NSNumber *)price{
    
    //NSLog(@"%u, %@, %@, %@, %g",cookieID,name,imageURL,addDate,price);
    
    if (self = [super init]){
        _cookieID = cookieID;
        _name = name;
        _imageURL = imageURL;
        _addDate = addDate;
        _price = price;
    }
    return self;
}

@end
