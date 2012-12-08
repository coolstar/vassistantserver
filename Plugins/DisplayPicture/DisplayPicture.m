#import "DisplayPicture.h"
#import "../../VAssistantServer.h"

@implementation DisplayPicture

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    if ([server findRegex:text withRegex:@"(.*)(display|show)(.*)(picture|drawing|image|illustration)(.*)( a | an | the | )(.*)"]){
        NSArray *splittext = [text captureComponentsMatchedByRegex:@"(.*)(display|show)(.*)(picture|drawing|image|illustration)(.*)( a | an | the | )(.*)" options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil];
		NSString *query = [splittext lastObject];
		NSString *urlstrraw = @"http://ajax.googleapis.com/ajax/services/search/images?v=1.0&imgsz=small%7Cmedium%7Clarge%7Cxlarge&q=";
		NSString *urlstr = [NSString stringWithFormat:@"%@%@",urlstrraw,[query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]];
		NSString *jsonresp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		[jsonresp release];
		NSArray *obj = [[[data objectFromJSONData] objectForKey:@"responseData"] objectForKey:@"results"];
		NSDictionary *firstresult = [obj objectAtIndex:0];
		NSString *imgurl = [firstresult objectForKey:@"url"];
		
        [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
        [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSImageView",@"class",[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]],@"data",nil]];
        
        return YES;
    }
    return NO;
}

@end