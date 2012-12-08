#import "WeatherPlugin.h"
#import "../../VAssistantServer.h"

@implementation WeatherPlugin

- (NSDictionary *)dictionaryfortoday:(NSString *)woeid {
    NSString *yahoourl = [@"http://query.yahooapis.com/v1/public/yql?format=json&q=select%20*%20from%20weather.forecast%20where%20woeid=" stringByAppendingString:[@"2502265" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *rawdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahoourl]];
    NSDictionary *json = [rawdata objectFromJSONData];
    
    NSDictionary *item = [[[[json objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"item"];
    NSDictionary *location = [[[[json objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"location"];
    
    NSString *city = [[location objectForKey:@"city"] stringByAppendingFormat:@", %@",[location objectForKey:@"region"]];
    
    NSString *temp = [[[item objectForKey:@"condition"] objectForKey:@"temp"] stringByAppendingString:@"°F"];
    
    int condcode = [[[item objectForKey:@"condition"] objectForKey:@"code"] intValue];
    int cond = 0;
    if (condcode <= 12){
        cond = 3;
    } else if (condcode <= 16) {
        cond = 4;
    } else if (condcode <= 18) {
        cond = 3;
    } else if (condcode <= 26) {
        cond = 2;
    } else if (condcode <= 30) {
        cond = 1;
    } else if (condcode <= 32) {
        cond = 0;
    } else if (condcode <= 34) {
        cond = 1;
    } else if (condcode == 35) {
        cond = 3;
    } else if (condcode == 36) {
        cond = 0;
    } else if (condcode <= 40) {
        cond = 2;
    } else if (condcode <= 43) {
        cond = 4;
    } else if (condcode <= 47) {
        cond = 2;
    }
    
	return [NSDictionary dictionaryWithObjectsAndKeys:city,@"city",temp,@"temp",[NSNumber numberWithInt:cond],@"condition",nil];
}

- (NSDictionary *)dictionaryfortomorrow:(NSString *)woeid {
    NSString *yahoourl = [@"http://query.yahooapis.com/v1/public/yql?format=json&q=select%20*%20from%20weather.forecast%20where%20woeid=" stringByAppendingString:[@"2502265" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *rawdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahoourl]];
    NSDictionary *json = [rawdata objectFromJSONData];
    
    NSDictionary *item = [[[[json objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"item"];
    NSDictionary *location = [[[[json objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"location"];
    
    NSString *city = [[location objectForKey:@"city"] stringByAppendingFormat:@", %@",[location objectForKey:@"region"]];
    
    NSDictionary *forecast = [[item objectForKey:@"forecast"] objectAtIndex:1];
    int tempint = ([[forecast objectForKey:@"high"] intValue] + [[forecast objectForKey:@"low"] intValue])/2;
    NSString *temp = [NSString stringWithFormat:@"%d%@",tempint,@"°F"];
    
    int condcode = [[forecast objectForKey:@"code"] intValue];
    int cond = 0;
    if (condcode <= 12){
        cond = 3;
    } else if (condcode <= 16) {
        cond = 4;
    } else if (condcode <= 18) {
        cond = 3;
    } else if (condcode <= 26) {
        cond = 2;
    } else if (condcode <= 30) {
        cond = 1;
    } else if (condcode <= 32) {
        cond = 0;
    } else if (condcode <= 34) {
        cond = 1;
    } else if (condcode == 35) {
        cond = 3;
    } else if (condcode == 36) {
        cond = 0;
    } else if (condcode <= 40) {
        cond = 2;
    } else if (condcode <= 43) {
        cond = 4;
    } else if (condcode <= 47) {
        cond = 2;
    }
    
	return [NSDictionary dictionaryWithObjectsAndKeys:city,@"city",temp,@"temp",[NSNumber numberWithInt:cond],@"condition",nil];
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    if ([server findRegex:text withRegex:@"(.*)how(.*) weather (.*)tomorrow(.*)(in|at|near|from)(.*)"]){
        NSArray *splittext = [text captureComponentsMatchedByRegex:@"(.*)how(.*) weather (.*)tomorrow(.*)(in|at|near|from)(.*)" options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil];
		NSString *place = [splittext lastObject];
        YahooGeoPlanet *gp = [[YahooGeoPlanet alloc] init];
        NSString *woeid = [gp getwoeid:place];
        [gp release];
        NSDictionary *weatherdic = [self dictionaryfortomorrow:woeid];
        [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
        [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSWeatherView",@"class",weatherdic,@"data",nil]];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)how(.*) weather (.*)(in|at|near|from)(.*)"]){
        NSArray *splittext = [text captureComponentsMatchedByRegex:@"(.*)how(.*) weather (.*)(in|at|near|from)(.*)" options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil];
		NSString *place = [splittext lastObject];
        YahooGeoPlanet *gp = [[YahooGeoPlanet alloc] init];
        NSString *woeid = [gp getwoeid:place];
        [gp release];
        NSDictionary *weatherdic = [self dictionaryfortoday:woeid];
        [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
        [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSWeatherView",@"class",weatherdic,@"data",nil]];
        [server finishSession];
        return YES;
    } if ([server findRegex:text withRegex:@"(.*)how(.*) weather (.*)tomorrow(.*)"]){
        NSDictionary *weatherdic = [self dictionaryfortomorrow:@"2502265"];
        [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
        [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSWeatherView",@"class",weatherdic,@"data",nil]];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)how(.*) weather (like|today|now)(.*)"]){
        NSDictionary *weatherdic = [self dictionaryfortoday:@"2502265"];
        [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
        [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSWeatherView",@"class",weatherdic,@"data",nil]];
        [server finishSession];
        return YES;
    }
    return NO;
}

@end
