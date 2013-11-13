//
//  Salary.h
//  SSDataManager
//
//  Created by Susim on 11/13/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Salary : NSManagedObject

@property (nonatomic, retain) NSString * empId;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSManagedObject *relationship;

@end
