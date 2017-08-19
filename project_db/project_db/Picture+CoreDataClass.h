//
//  Picture+CoreDataClass.h
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

NS_ASSUME_NONNULL_BEGIN

@interface Picture : NSManagedObject
+(Picture *)newPic:(NSDictionary *)elements;

@end

NS_ASSUME_NONNULL_END

#import "Picture+CoreDataProperties.h"
