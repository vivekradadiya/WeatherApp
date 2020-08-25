//
//  WeatherModel.h
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherModel : NSCoder

@property (nonatomic, strong) NSString *strCityName;
@property double temperature;
@property (nonatomic, strong) NSString *strWeatherConditionName;
@property int weatherConditionID;

@end

NS_ASSUME_NONNULL_END
