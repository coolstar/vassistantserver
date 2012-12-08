#import <Foundation/Foundation.h>
#import "../../JSONKit.h"

@class VAssistantServer;
@interface DisplayPicture : NSObject {
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;

@end