//
//  DemoDevice+CoreDataProperties.h
//  shinelink
//
//  Created by sky on 16/3/22.
//  Copyright © 2016年 sky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DemoDevice.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoDevice (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *power;
@property (nullable, nonatomic, retain) NSString *dayPower;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *statueData;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
