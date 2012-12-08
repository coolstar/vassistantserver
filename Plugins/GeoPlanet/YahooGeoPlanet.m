#import "YahooGeoPlanet.h"

@implementation YahooGeoPlanet

- (NSDictionary *)latlng:(NSString *)place {
	NSString *yahoourl = [NSString stringWithFormat:@"http://where.yahooapis.com/geocode?q=%@",[place stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *rawxml = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahoourl]];
    NSError *error = nil;
    NSDictionary *data = [XMLReader dictionaryForXMLData:rawxml error:&error];
	//NSArray *data = PerformXMLXPathQuery(rawxml, @"//*[local-name()='ResultSet']/*[local-name()='Result']");
	/*NSString *lat = [[[[data objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:1] objectForKey:@"nodeContent"];
	NSString *lng = [[[[data objectAtIndex:0] objectForKey:@"nodeChildArray"] objectAtIndex:2] objectForKey:@"nodeContent"];*/
    
    if (error != nil){
        return nil;
    }
    
    NSString *lat = [[[[data objectForKey:@"ResultSet"] objectForKey:@"Result"] objectForKey:@"latitude"] stringValue];;
    NSString *lng = [[[[data objectForKey:@"ResultSet"] objectForKey:@"Result"] objectForKey:@"longitude"] stringValue];
    
	NSDictionary *thelatlng = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",lng,@"lng",nil];
	return thelatlng;
}

- (NSString *)getwoeid:(NSString *)place {
	NSString *yahoourl = [NSString stringWithFormat:@"http://where.yahooapis.com/geocode?q=%@",[place stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *rawxml = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahoourl]];
    
    NSError *error = nil;
    NSDictionary *data = [XMLReader dictionaryForXMLData:rawxml error:&error];
    
    if (error != nil){
        return nil;
    }
    
    NSString *woeid = [[[[data objectForKey:@"ResultSet"] objectForKey:@"Result"] objectForKey:@"woeid"] objectForKey:@"text"];
    
	return woeid;
}

@end
