//
//  BlogPost.h
//  BlogReader2
//
//  Created by Alex Valladares on 05/08/15.
//  Copyright (c) 2015 Alex Valladares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject
    
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSURL *url;

// Inicializador
- (id) initWithTitle:(NSString *)title;

// Constructor
+ (id) blogPostWithTitle:(NSString *)title;

- (NSURL *) imageURL;
- (NSString *) formattedDate;


@end
