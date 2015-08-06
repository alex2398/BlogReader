//
//  TableViewController.m
//  BlogReader2
//
//  Created by Alex Valladares on 04/08/15.
//  Copyright (c) 2015 Alex Valladares. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *urlTeamtreeHouse = @"http://blog.teamtreehouse.com/api/get_recent_summary/";
    

    @try {
            // Declaramos la variable de error
        NSError *error = nil;
        // Creamos un objeto NSURL para almacenar la direccion a la que acceder para obtener los datos JSON
        NSURL *blogURL = [NSURL URLWithString:urlTeamtreeHouse];
        // Creamos un objeto NSData para almacenar los datos obtenidos de la url
        NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

        // Creamos el array a partir de los datos JSON
        self.blogPosts = [NSMutableArray array];
    
        NSArray *blogPostArray = [dataDictionary objectForKey:@"posts"];
    
        // Recorremos el array de posts obtenido
    
        for (NSDictionary *bpDictionary in blogPostArray) {
        
            BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
            blogPost.author = [bpDictionary objectForKey:@"author"];
            blogPost.image = [bpDictionary objectForKey:@"thumbnail"];
            blogPost.date = [bpDictionary objectForKey:@"date"];
            blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
        
            [self.blogPosts addObject:blogPost];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Error al obtener los datos");
    }
}

             
                       
                       
             

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.blogPosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celda" forIndexPath:indexPath];
    
    // Configure the cell...
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    // Añadimos la imagen del JSON
    // Si el dato es nulo, JSON devuelve la clase NSNull, por lo que comprobamos la clase antes de nada
    if ([blogPost.image isKindOfClass:[NSString class]]) {
        // Creamos el NSData desde la URL y creamos la imagen desde ella
        NSData *imageData = [NSData dataWithContentsOfURL:blogPost.imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        // Asignamos la imagen a la imagen embebida en la celda del tableView
        cell.imageView.image = image;
        
    } else {
        cell.imageView.image = [UIImage imageNamed:@"treehouse.png"];
    }
    
    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ - %@",blogPost.author, [blogPost formattedDate]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showBlogPost"]) {
        // Extraemos el índice de la celda pulsada
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // Seleccionamos del array el blog asociado al index anterior
        BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
        // Establecemos la variable de destino con la url del blog
        [segue.destinationViewController setBlogPostURL:blogPost.url];
        }
}

// Método para ejecutar una acción al seleccionar una celda del tableView
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // Creamos una instancia del blogPost pulsado gracias al indexPath
//    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
//    
//    // Accedemos a la UIApplication (singleton) de forma compartida para poder abrir una url
//    UIApplication *application = [UIApplication sharedApplication];
//    
//    // Abrimos la url
//    [application openURL:blogPost.url];

 @end
