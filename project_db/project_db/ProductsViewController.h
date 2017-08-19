//
//  ProductsViewController.h
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product+CoreDataClass.h"

@interface ProductsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) Product *selectProd;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end
