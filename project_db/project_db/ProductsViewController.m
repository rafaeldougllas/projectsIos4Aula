//
//  ProductsViewController.m
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "ProductsViewController.h"
#import "Product+CoreDataClass.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.products = [Product allProducts];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Product *prod = self.products[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ : %i",prod.name, prod.brand, prod.quantity.intValue];
    
    return cell;
    
}

- (IBAction)takePicture:(id)sender {
    UIView *view = sender;
    
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)view];
    
    self.selectProd = self.products[indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Aviso" message:@"Escolha uma das Opções" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker =  [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *galeriaAction = [UIAlertAction actionWithTitle:@"Galeria" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker =  [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    
    [alert addAction:cameraAction];
    [alert addAction:galeriaAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

@end
