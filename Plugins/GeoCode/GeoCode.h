#import <Foundation/Foundation.h>
#import "../../JSONKit.h"

@interface GoogleGeoCode : NSObject {

}

- (NSDictionary *)latlng:(NSString *)place;

@end
