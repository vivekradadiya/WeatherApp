//
//  ViewController.h
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherManager.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *sbPlaceSearchBar;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeatherConditionImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceNameLabel;

- (IBAction)btnCurrentLocationButtonTapped:(UIButton *)sender;
- (IBAction)btnSearchPlaceButtonTapped:(UIButton *)sender;

@property (nonatomic, strong) WeatherManager *weatherManager;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

