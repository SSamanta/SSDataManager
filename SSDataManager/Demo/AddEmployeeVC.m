//
//  AddEmployeeVC.m
//  SSDataManager
//
//  Created by Susim on 11/14/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "AddEmployeeVC.h"
#import "Employee.h"
#import "AppDelegate.h"
#import "SSDataManager.h"

@interface AddEmployeeVC ()
@property (weak,nonatomic) IBOutlet UITextField *empIdTf;
@property (weak,nonatomic) IBOutlet UITextField *empNameTf;
@property (weak,nonatomic) IBOutlet UILabel *statusLbl;
@end

@implementation AddEmployeeVC

#pragma mark View liefecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addEmp:(id)sender {
    [SSDataManager addEmployeeWithEmpID:self.empIdTf.text empName:self.empNameTf.text onCompletion:^(id object, NSError *error) {
        if (error) {
            NSLog(@"%@",error.description);
        }else {
            self.statusLbl.text = object;
        }
    }];
    [self.empNameTf resignFirstResponder];
}
@end
