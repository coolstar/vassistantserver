#import <Foundation/Foundation.h>
#import "../GeoPlanet/YahooGeoPlanet.h"
#import "../../JSONKit.h"

@class VAssistantServer;
@interface WeatherPlugin : NSObject {
}

- (NSDictionary *)dictionaryfortoday:(NSString *)woeid;
- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;

@end
