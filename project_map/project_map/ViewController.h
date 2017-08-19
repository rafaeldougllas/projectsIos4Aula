//
//  ViewController.h
//  project_map
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UITapGestureRecognizer *gestureTapRecognizer;
@property (strong, nonatomic) MKLocalSearch *localSearch;
@property (strong, nonatomic) NSArray *items;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

