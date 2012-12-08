#import <Foundation/Foundation.h>
#import "../../JSONKit.h"
@class VAssistantServer;
@interface WordnikPlugin : NSObject {

	NSString *apikey;

}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server;
- (NSString *)definition:(NSString *)word;
- (NSArray *)thesaurus:(NSString *)word;

@end
