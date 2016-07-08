//
//  GetDevice+CoreDataProperties.h
//  shinelink
//
//  Created by sky on 16/3/23.
//  Copyright © 2016年 sky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GetDevice.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetDevice (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *deviceSN;
@property (nullable, nonatomic, retain) NSData *demoImage;
@property (nullable, nonatomic, retain) NSData *nowImage;
@property (nullable, nonatomic, retain) NSString *power;
@property (nullable, nonatomic, retain) NSString *dayPower;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *ailasName;
@property (nullable, nonatomic, retain) NSData *statueImage;
@property (nullable, nonatomic, retain) NSString *statueData;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *totalPower;
@property (nullable, nonatomic, retain) NSString *topNum;

@end

NS_ASSUME_NONNULL_END
