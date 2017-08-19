//
//  Picture+CoreDataClass.m
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "Picture+CoreDataClass.h"
#import "Product+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Picture

- (void) fillWithAttributes: (NSDictionary *) attributes {
    id t;
    
    t = [attributes valueForKeyPath:@"imagem"];
    if (t != nil && ![t isKindOfClass:[NSNull class]])
        self.data = UIImageJPEGRepresentation((UIImage *)t, 1.0);
    
    t = [attributes valueForKeyPath:@"produto"];
    if (t != nil && ![t isKindOfClass:[NSNull class]])
        self.product = t;
    
    self.date = [NSDate date];
    
    self.extension = @"jpeg";
    
}


+(Picture *)newPic:(NSDictionary *)elements{
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    Picture *pic = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Picture"
                    inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    [pic fillWithAttributes:elements];
    
    NSError *saveError = nil;
    [appDelegate.persistentContainer.viewContext save:&saveError];
    return pic;
}

@end
