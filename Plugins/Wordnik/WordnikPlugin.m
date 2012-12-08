#import "WordnikPlugin.h"
#import "../../VAssistantServer.h"

@implementation WordnikPlugin

- (id)init {
    self = [super init];
	apikey = @"f6ba9e32533224b5633884ae05d06eae81239235d7e6dc195";
    return self;
}

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    if ([server findRegex:text withRegex:@"(.*)(definition of|define) (.*)"]){
        NSString *word = [[text captureComponentsMatchedByRegex:@"(.*)(definition of|define) (.*)" options:RKLCaseless range:NSMakeRange(0, [text length]) error:nil] lastObject];
        NSString *def = [self definition:word];
        if (def != nil){
            [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
            [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSDictionaryView",@"class",def,@"text",nil]];
            [server finishSession];
            return YES;
        }
    } else if ([server findRegex:text withRegex:@"(.*) synonym of (.*)"]){
        NSString *word = [[text captureComponentsMatchedByRegex:@"(.*) synonym of (.*)" options:RKLCaseless range:NSMakeRange(0, [text length]) error:nil] lastObject];
        NSArray *syns = [self thesaurus:word];
        if (syns != nil){
            [server sendCellFromVA:@"I found this for you..." speech:@"I found this for you..."];
            NSString *syn = @"";
            for (NSString *x in syns){
                NSString *temp = syn;
                if (![syn isEqualToString:@""]){
                    syn = [temp stringByAppendingString:@", "];
                    temp = syn;
                }
                syn = [temp stringByAppendingString:x];
            }
            [server pushSnippet:[NSDictionary dictionaryWithObjectsAndKeys:@"CSThesaurusView",@"class",syn,@"text",nil]];
            [server finishSession];
            return YES;
        }
    }
    return NO;
}

- (NSString *)definition:(NSString *)word {

	NSString *wordnikurl = [NSString stringWithFormat:@"http://api.wordnik.com/v4/word.json/%@/definitions?includeRelated=false&includeTags=false&limit=1&sourceDictionaries=all&useCanonical=true",word];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:wordnikurl]];
	[request setValue:apikey forHTTPHeaderField:@"api_key"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
	NSData *rawjson = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	[request release];
    NSArray *json = [rawjson objectFromJSONData];
    if ([json count] > 0){
        NSDictionary *worddef = [json objectAtIndex:0];
        NSString *worddefinition = [worddef objectForKey:@"text"];
        return worddefinition;
    } else {
        return nil;
    }
}

- (NSArray *)thesaurus:(NSString *)word {
	NSString *wordnikurl = [NSString stringWithFormat:@"http://api.wordnik.com/v4/word.json/%@/related?type=synonym&useCanonical=true&limit=20",word];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:wordnikurl]];
	[request setValue:apikey forHTTPHeaderField:@"api_key"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
	NSData *rawjson = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	[request release];
	NSArray *synonyms = [[[rawjson objectFromJSONData] objectAtIndex:0] objectForKey:@"words"];
    if ([synonyms count] > 0){
        return synonyms;
    } else {
        return nil;
    }
}

@end
