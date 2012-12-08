#import "../../XMLReader.h"
#import "../GeoCode/GeoCode.h"

@class VAssistantServer;
@interface DevicePlugin : NSObject {
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;

@end