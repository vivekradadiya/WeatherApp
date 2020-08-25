//
//  ViewController.m
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import "ViewController.h"
#import "WeatherManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <UISearchBarDelegate, WeatherManagerDelegate, CLLocationManagerDelegate>
{
    
}
@end

@implementation ViewController

//MARK:- ViewController's lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sbPlaceSearchBar.delegate = self;
    _weatherManager = [[WeatherManager alloc] init];
    _weatherManager.delegate = self;
    [_weatherManager fetchWeatherForCity: @"Berlin"];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
}


//MARK:- UIButton's action methods

- (IBAction)btnSearchPlaceButtonTapped:(UIButton *)sender {
    if (![_sbPlaceSearchBar.text isEqualToString: @""]) {
        [_weatherManager fetchWeatherForCity: _sbPlaceSearchBar.text];
    }
    [self.view endEditing: YES];
}

- (IBAction)btnCurrentLocationButtonTapped:(UIButton *)sender {
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager requestLocation];
}


//MARK:- UISearchBarDelegateMethods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (![_sbPlaceSearchBar.text isEqualToString: @""]) {
        [_weatherManager fetchWeatherForCity: searchBar.text];
    }
    [self.view endEditing: YES];
}


//MARK:- CLLocationManagerDelegate's methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    double lat = [[locations lastObject] coordinate].latitude;
    double lon = [[locations lastObject] coordinate].longitude;
    
    if (lat && lon) {
//        [_locationManager stopUpdatingLocation];
        [_weatherManager fetchWeatherUsingLatitude: lat andLongitude: lon];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Error updating location : %@", error.localizedDescription);
    
}


//MARK:- WeatherManagerDelegate's methods

- (void)didUpdateWeather:(WeatherModel *) weatherModel {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_lblPlaceNameLabel setText: weatherModel.strCityName];
        [self->_lblTemperatureLabel setText: [NSString stringWithFormat: @"%@°C", @24.3]];
        [self->_imgWeatherConditionImage setImage: [UIImage systemImageNamed: weatherModel.strWeatherConditionName]];
    });
     
}

- (void)didFailedWithError:(NSError *) error {
    NSLog(@"Error updating weather : %@", error);
}


@end
