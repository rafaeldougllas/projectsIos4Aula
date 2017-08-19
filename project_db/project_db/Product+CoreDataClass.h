//
//  Product+CoreDataClass.h
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSManagedObject

+(NSArray *) allProducts;
+(Product *) newProduto:(NSDictionary *)elements;

@end

NS_ASSUME_NONNULL_END

#import "Product+CoreDataProperties.h"
