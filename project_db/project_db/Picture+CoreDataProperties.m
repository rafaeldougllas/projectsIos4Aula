//
//  Picture+CoreDataProperties.m
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "Picture+CoreDataProperties.h"

@implementation Picture (CoreDataProperties)

+ (NSFetchRequest<Picture *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Picture"];
}

@dynamic data;
@dynamic date;
@dynamic extension;
@dynamic product;

@end
