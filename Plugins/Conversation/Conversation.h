@class VAssistantServer;
@interface Conversation : NSObject {
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;

@end