//
//  EmpListVC.m
//  SSDataManager
//
//  Created by Susim on 11/14/13.
//  Copyright (c) 2013 Susim. All rights reserved.
//

#import "EmpListVC.h"
#import "AppDelegate.h"
#import "Employee.h"

@interface EmpListVC ()
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSFetchedResultsController* fetchResultsController;
@end

@implementation EmpListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchEmp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResultsController.fetchedObjects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmpCell"];
    Employee *emp = self.fetchResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = emp.empName;
    cell.detailTextLabel.text = emp.empId;
    return cell;
}
#pragma mark Core Data methods
- (void)fetchEmp {
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL:appDel.modelURL];
    NSFetchRequest *fetchRequest = [model fetchRequestTemplateForName:@"allEmployeeFetchRequest"];
    NSSortDescriptor* sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"empId" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptors]];
    self.fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDel.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error ;
    [self.fetchResultsController performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }else {
        [self.tableView reloadData];
    }
    
}
@end
