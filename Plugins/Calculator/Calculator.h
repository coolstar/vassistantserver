#import <Foundation/Foundation.h>
#import "../../JSONKit.h"
@class VAssistantServer;
@interface CalculatorPlugin : NSObject {
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;

@end