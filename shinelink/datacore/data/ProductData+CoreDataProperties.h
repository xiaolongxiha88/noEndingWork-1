//
//  ProductData+CoreDataProperties.h
//  shinelink
//
//  Created by sky on 16/7/4.
//  Copyright © 2016年 sky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProductData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *productName;
@property (nullable, nonatomic, retain) NSString *productImage;
@property (nullable, nonatomic, retain) NSString *technologyParams;
@property (nullable, nonatomic, retain) NSString *feature;
@property (nullable, nonatomic, retain) NSString *outline;
@property (nullable, nonatomic, retain) NSString *identifying;
@property (nullable, nonatomic, retain) NSDate *imageData;

@end

NS_ASSUME_NONNULL_END
