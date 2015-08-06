//
//  BlogPost.m
//  BlogReader2
//
//  Created by Alex Valladares on 05/08/15.
//  Copyright (c) 2015 Alex Valladares. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost


// Inicializador con titulo

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.author = nil;
        self.image = nil;
        self.date = nil;
        self.url = nil;
    }
    return self;
}

// Convenience Constructor: nos sirve para alocar e inicializar
// al mismo tiempo, usando el inicializador antes implementado.

+ (id) blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) imageURL {
    return [NSURL URLWithString:self.image];
}

- (NSString *) formattedDate {
    // Método para darle formato a las fechas
    
    // Primero creamos el objeto dateformatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // Le decimos el formato que nos va a venir del JSON
    [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    
    // Creamos una fecha temporal para la fecha del JSON
    NSDate *tempDate = [formatter dateFromString:self.date];
    
    // Cambiamos el formato al que queremos
    [formatter setDateFormat:@"EE MMM,dd"];
    
    // Devolvermos la fecha con el formato deseado
    return [formatter stringFromDate:tempDate];
    
}


@end
