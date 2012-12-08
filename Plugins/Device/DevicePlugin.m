#import "DevicePlugin.h"
#import "../../VAssistantServer.h"

@interface TimerManager : NSObject

@end

@interface AlarmManager : NSObject

@end

@implementation DevicePlugin

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    if ([server findRegex:text withRegex:@"(.*)pause(.*)"]){
        [server finishSession];
        [server sendAction:[NSDictionary dictionaryWithObjectsAndKeys:@"iPod-Pause",@"action",nil]];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)play(.*)by (.*)"]){
        NSString *artistname = [[text captureComponentsMatchedByRegex:@"(.*)play(.*)by (.*)" options:RKLCaseless range:NSMakeRange(0, [text length]) error:nil] lastObject];
        [server finishSession];
        [server sendAction:[NSDictionary dictionaryWithObjectsAndKeys:@"iPod-Play-Artist",@"action",artistname,@"args",nil]];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)play(.*)song (.*)"]){
        NSString *songname = [[text captureComponentsMatchedByRegex:@"(.*)play song (.*)" options:RKLCaseless range:NSMakeRange(0, [text length]) error:nil] lastObject];
        [server finishSession];
        [server sendAction:[NSDictionary dictionaryWithObjectsAndKeys:@"iPod-Play-Name",@"action",songname,@"args",nil]];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)play(.*)album (.*)"]){
        NSString *albumname = [[text captureComponentsMatchedByRegex:@"(.*)play album (.*)" options:RKLCaseless range:NSMakeRange(0, [text length]) error:nil] lastObject];
        [server finishSession];
        [server sendAction:[NSDictionary dictionaryWithObjectsAndKeys:@"iPod-Play-Album",@"action",albumname,@"args",nil]];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)play(.*)"]){
        [server finishSession];
        [server sendAction:[NSDictionary dictionaryWithObjectsAndKeys:@"iPod-Play",@"action",nil]];
    } else if ([server findRegex:text withRegex:@"(.*)timer(.*)"]){
        [server sendCellFromVA:@"Timer Set" speech:@"Timer Set"];
        [server finishSession];
        //TimerManager *man = [TimerManager sharedManager];
        //[man scheduleAt:2 withSound:@"Piano-Riff"];
        
        Alarm *alarm = [[Alarm alloc] init];
        [alarm setHour:10];
        [alarm setMinute:0];
        [alarm setTitle:@"test"];
        [alarm setSound:@"Piano-Riff"];
        
        AlarmManager *man = [AlarmManager sharedManager];
        [man loadAlarms];
        [man addAlarm:alarm active:YES];
        [man saveAlarms];
    } else if ([server findRegex:text withRegex:@"(.*) time (.*)in (.*)"]){
		NSArray *splittext = [text captureComponentsMatchedByRegex:@"(.*) time (.*)in (.*)" options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil];
		NSString *place = [splittext lastObject];
		GoogleGeoCode *ggeo = [GoogleGeoCode alloc];
		NSDictionary *coords = [ggeo latlng:place];
		NSString *lat = [[coords objectForKey:@"lat"] stringValue];
		NSString *lng = [[coords objectForKey:@"lng"] stringValue];
		[ggeo release];
		NSString *timezoneapi = [NSString stringWithFormat:@"http://www.earthtools.org/timezone/%@/%@",lat,lng];
		NSData *rawxml = [NSData dataWithContentsOfURL:[NSURL URLWithString:timezoneapi]];
        NSError *error = nil;
        NSDictionary *rawdata = [XMLReader dictionaryForXMLData:rawxml error:&error];
        if (error != nil){
            [server sendCellFromVA:@"There was a problem getting the info. Please try again later." speech:@"There was a problem getting the info. Please try again later."];
            [server finishSession];
            return YES;
        }
        NSString *localtime = [[[rawdata objectForKey:@"timezone"] objectForKey:@"localtime"] objectForKey:@"text"];
		NSString *zulu = [[localtime componentsSeparatedByString:@" "] lastObject];
		NSArray *zulutime = [zulu componentsSeparatedByString:@":"];
		int hour = [[zulutime objectAtIndex:0] intValue];
		int min = [[zulutime objectAtIndex:1] intValue];
		NSString *ampm = @"AM";
		if (hour >= 12){
			ampm = @"PM";
			hour -=12;
		}
		if (hour == 0){
			hour = 12;
		}
		NSString *time = [NSString stringWithFormat:@"%d:%d %@",hour,min,ampm];
		if (hour <= 9){
			time = [NSString stringWithFormat:@"0%d:%d %@",hour,min,ampm];
		}
        
        NSString *speech = [NSString stringWithFormat:@"It is %@",time];
        
        [server sendCellFromVA:speech speech:speech];
        [server finishSession];
		return YES;
    } else if ([server findRegex:text withRegex:@"(.*)time (.*)"]){
		NSDate *currentDate = [NSDate date];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"hh:mm a"];
		NSString *datestr = [dateFormatter stringFromDate:currentDate];
		[dateFormatter release];
		NSString *outstr = [[NSString alloc] initWithFormat:@"It is %@",datestr];
        [server sendCellFromVA:outstr speech:outstr];
        [server finishSession];
		return YES;
    }
    return NO;
}

@end