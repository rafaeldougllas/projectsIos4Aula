//
//  Picture+CoreDataProperties.h
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "Picture+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

+ (NSFetchRequest<Picture *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *extension;
@property (nullable, nonatomic, retain) Product *product;

@end

NS_ASSUME_NONNULL_END
