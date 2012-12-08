#import <Foundation/Foundation.h>
//#import "../../XPathQuery/XPathQuery.h"
#import "../../XMLReader.h"

@interface YahooGeoPlanet : NSObject {
}

- (NSDictionary *)latlng:(NSString *)place;
- (NSString *)getwoeid:(NSString *)place;

@end
