//
//  WeatherManager.h
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherManagerDelegate <NSObject>

- (void) didUpdateWeather: (WeatherModel *) weatherModel;
- (void) didFailedWithError: (NSError *) error;

@end

@interface WeatherManager : NSObject

@property id delegate;
@property NSString *strWeatherURL;


- (void) fetchWeatherForCity: (NSString *) cityName;
- (void) fetchWeatherUsingLatitude: (double) latitude andLongitude: (double) longitude;


@end

NS_ASSUME_NONNULL_END
