//
//  WeatherModel.m
//  WeatherApp
//
//  Created by Vivek Radadiya on 11/08/20.
//  Copyright © 2020 Vivek Radadiya. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel: NSCoder

//- (id) initWithCoder:(NSCoder *) decoder
//{
//    self = [super init];
//    if (self) {
//
//        self.strCityName = [decoder decodeObjectForKey: @"name"];
//        self.temperature = [decoder decodeDoubleForKey: @"temp"];
//
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    [coder encodeObject: _strCityName forKey: @"name"];
//    [coder encodeDouble: _temperature forKey: @"temp"];
//}


- (NSString *) strWeatherConditionName {
    
    switch (_weatherConditionID) {
        case 199 ... 233:
            return @"cloud.bolt";
            break;
        
        case 299 ... 322:
            return @"cloud.drizzle";
            break;
            
        case 499 ... 532:
            return @"cloud.rain";
            break;
        
        case 599 ... 623:
            return @"cloud.snow";
            break;
            
        case 700 ... 782:
            return @"cloud.fog";
            break;
            
        case 800 :
            return @"sun.max";
            break;
            
        case 801 ... 804:
            return @"cloud.bolt";
            break;
            
        default:
            return @"cloud";
            break;
    }
    
}


@end

