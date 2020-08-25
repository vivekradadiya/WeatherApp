//
//  WeatherManager.m
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import "WeatherManager.h"
#import "WeatherModel.h"


@implementation WeatherManager

- (void) fetchWeatherForCity: (NSString *) cityName {
    
    _strWeatherURL = [NSString stringWithFormat: @"https://api.openweathermap.org/data/2.5/weather?q=%@&appid=730a1c15ca6a90f7642c2333422138cf", cityName];
    
    NSURL *weatherURL = [[NSURL alloc] initWithString: _strWeatherURL];
    
    NSURLSessionConfiguration *urlSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration: urlSessionConfiguration];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL: weatherURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching weather data : %@", error);
            [self->_delegate didFailedWithError: error];
            return;
        }
        
        WeatherModel *weatherModel = [[WeatherModel alloc] init];
        weatherModel = [self parseWeatherData: data];
        if (weatherModel != nil) {
            [self->_delegate didUpdateWeather: weatherModel];
        }
        
    }];
    [task resume];
    
}


- (void) fetchWeatherUsingLatitude: (double) latitude andLongitude: (double) longitude {
    
    _strWeatherURL = [NSString stringWithFormat: @"https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=730a1c15ca6a90f7642c2333422138cf", latitude, longitude];
    
    NSURL *weatherURL = [[NSURL alloc] initWithString: _strWeatherURL];
    
    NSURLSessionConfiguration *urlSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration: urlSessionConfiguration];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL: weatherURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching weather data : %@", error);
            [self->_delegate didFailedWithError: error];
            return;
        }
        
        WeatherModel *weatherModel = [[WeatherModel alloc] init];
        weatherModel = [self parseWeatherData: data];
        if (weatherModel != nil) {
            [self->_delegate didUpdateWeather: weatherModel];
        }
        
    }];
    [task resume];
    
}


- (WeatherModel *) parseWeatherData: (NSData *) data {
    
    WeatherModel *weatherModel = [[WeatherModel alloc] init];
    NSError *error;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &error];
    
    if (error) {
        NSLog(@"Error decoding JSON data : %@", error.localizedDescription);
        [self->_delegate didFailedWithError: error];
        return nil;
    }
    
    if ([jsonObject isKindOfClass: [NSDictionary class]]) {
        
        NSMutableDictionary *dicJsonObject = [[NSMutableDictionary alloc] initWithDictionary: jsonObject];
        NSString *cityName = [dicJsonObject valueForKey: @"name"];
        double temperature = [[[dicJsonObject valueForKey: @"main"] valueForKey: @"temp"] doubleValue];
        NSMutableArray *arrWeatherData = [[NSMutableArray alloc] initWithArray: [dicJsonObject valueForKey: @"weather"]];
        
        weatherModel.strCityName = cityName;
        weatherModel.temperature = temperature;
        weatherModel.weatherConditionID = [[[arrWeatherData objectAtIndex: 0] valueForKey: @"id"] intValue];
        
    }
    
    return weatherModel;
    
}

@end
