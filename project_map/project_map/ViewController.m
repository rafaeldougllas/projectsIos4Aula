//
//  ViewController.m
//  project_map
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "ViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [self initLocationService];
    
    self.items = (NSMutableArray*) @[];
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    [self addGestureToMap];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initLocationService{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//Consome mais
    [self.locationManager startUpdatingHeading];
}

-(void) centerMap{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude     = self.locationManager.location.coordinate.latitude;
    newRegion.center.longitude    = self.locationManager.location.coordinate.longitude;
    newRegion.span.latitudeDelta  = 0.0005;
    newRegion.span.longitudeDelta = 0.0005;
    
    [self.mapView setRegion:newRegion];
}

-(void)colectAddress{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //Vem um array com os possiveis locais
        CLPlacemark *placemark = placemarks[0];
        //Mas muda dependendo do pais
        NSLog(@"%@", placemark.thoroughfare);//Rua
        NSLog(@"%@", placemark.subLocality);//Bairro
    }];
}

-(void)setPinOnMap:(CLLocation *)location{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    MKCoordinateRegion region;
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    annotation.coordinate = region.center;
    annotation.title = @"lala";
    annotation.subtitle = @"lalal123";
    
    [self.mapView addAnnotation:annotation];
}


-(void)addGestureToMap{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMap:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.delaysTouchesBegan = YES;
    
    [tapGesture setCancelsTouchesInView:YES];
    [self.mapView addGestureRecognizer:tapGesture];
}

-(void)tapMap:(UITapGestureRecognizer *)recognizer{
    CGPoint touchPoint = [recognizer locationInView:self.mapView];
    
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    CLLocation *location  = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    [self setPinOnMap:location];
}


- (IBAction)getLocation:(id)sender {
    [self centerMap];
    [self colectAddress];
    
    
    NSLog(@"lat = %f", self.locationManager.location.coordinate.latitude);
    NSLog(@"lng = %f", self.locationManager.location.coordinate.longitude);
    [self setPinOnMap:self.locationManager.location];
    //[self startSearch:@"Subway"];
}

- (IBAction)removeLocations:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];
}

-(void)startSearch:(NSString *)searchString {
    //Nao faz uma busca enqt ele ta fazd uma busca
    if (self.localSearch.searching)
    {
        [self.localSearch cancel];
    }
    
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = self.locationManager.location.coordinate.latitude+0.001555;
    newRegion.center.longitude = self.locationManager.location.coordinate.longitude;
    
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = searchString;
    request.region = newRegion;
    
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error) {
        
        if (error != nil) {
            [self.localSearch cancel];
            self.localSearch = nil;
            NSLog(@"Erro");
        } else {
            if([response mapItems].count > 0){
                //Pegar os valores do lugar que ele achou
                //MKMapItem *item = [response mapItems][0];
                //adiciono o retorno da pesquisa no items
                self.items = [response mapItems];
                self.tableView.hidden = NO;
                [self.tableView reloadData];
                //item.placemark.coordinate.latitude
                //item.placemark.name
                
                NSLog(@"%@", response);
            }else{
                NSLog(@"Erro");
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.localSearch != nil) {
        self.localSearch = nil;
    }
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = ((MKMapItem *)self.items[indexPath.row]).placemark.name;
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MKMapItem *locationSearched = ((MKMapItem *) self.items[indexPath.row]);
    
    CLLocation *location  = [[CLLocation alloc] initWithLatitude:locationSearched.placemark.coordinate.latitude longitude:locationSearched.placemark.coordinate.longitude];
    
    self.tableView.hidden = YES;
    
    [self setPinOnMap:location];
}


- (IBAction)searchPlace:(id)sender {
    [self textFieldShouldReturn:self.textField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self startSearch:self.textField.text];

    [self.view endEditing:YES];
    
    return YES;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //Pino da localizacao do usuario
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    UIImage *image = [UIImage imageNamed:@"map_pin"];
    
    
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"map_pin"];
    
    if(pinView != nil){
        pinView.annotation = annotation;
    }else{
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"map_pin"];
        pinView.image = image;
        pinView.centerOffset = CGPointMake(0, -pinView.image.size.height / 2);
        
    }
    return pinView;
}


@end
