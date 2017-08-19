//
//  Product+CoreDataClass.m
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "Product+CoreDataClass.h"
#import "Picture+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Product

- (void) fillWithAttributes: (NSDictionary *) attributes {
    id t;
    
    t = [attributes valueForKeyPath:@"name"];
    if (t != nil && ![t isKindOfClass:[NSNull class]])
        self.name = [t description];
    
    t = [attributes valueForKeyPath:@"brand"];
    if (t != nil && ![t isKindOfClass:[NSNull class]])
        self.brand = [t description];
    
    t = [attributes valueForKeyPath:@"quantity"];
    if (t != nil && ![t isKindOfClass:[NSNull class]])
        self.quantity = @([t integerValue]);
    
}


+(Product *)newProduto:(NSDictionary *)elements{
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    Product *prod = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Product"
                      inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    [prod fillWithAttributes:elements];
    
    NSError *saveError = nil;
    [appDelegate.persistentContainer.viewContext save:&saveError];
    return prod;
}

+(NSArray *) allProducts {
    
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    NSError *error;
    NSArray *produtos = [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:&error];
    return produtos ;
}


@end
