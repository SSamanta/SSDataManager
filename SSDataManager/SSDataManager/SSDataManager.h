//
//  SSDataManager.h
//  SSDataManager
//
//  Created by Susim on 10/31/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletionHandler)(id object, NSError *error);
@interface SSDataManager : NSObject
+ (void)addEmployeeWithEmpID:(NSString *)empId empName:(NSString *)empName onCompletion:(CompletionHandler)handler;
+ (void)fetchAllEmployeeOnCompletion:(CompletionHandler)handler;
@end
