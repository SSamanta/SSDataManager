//
//  Employee.h
//  SSDataManager
//
//  Created by Susim on 11/13/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Salary;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * empId;
@property (nonatomic, retain) NSString * empName;
@property (nonatomic, retain) Salary *relationship;

@end
