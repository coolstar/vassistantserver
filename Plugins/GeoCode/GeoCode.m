#import "GeoCode.h"

@implementation GoogleGeoCode

- (NSDictionary *)latlng:(NSString *)place {
	NSString *googleurl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=false",[place stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *rawjson = [NSData dataWithContentsOfURL:[NSURL URLWithString:googleurl]];
	NSDictionary *json = [rawjson objectFromJSONData];
	NSNumber *lat = [[[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
	NSNumber *lng = [[[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
	NSDictionary *thelatlng = [NSDictionary dictionaryWithObjectsAndKeys:lat, @"lat", lng, @"lng", nil];
	return thelatlng;
}

@end
