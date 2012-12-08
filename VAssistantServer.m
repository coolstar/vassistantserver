#import "VAssistantServer.h"

@implementation VAssistantServer

-(id)init {
    server = [[CPDistributedMessagingCenter centerNamed:@"org.coolstar.vassistantserver"] retain];
    [server runServerOnCurrentThread];
    [server registerForMessageName:@"parseQuery" target:self selector:@selector(parseQuery:withObject:)];
    [server registerForMessageName:@"exit" target:self selector:@selector(exit)];
    convplugin = [[Conversation alloc] init];
    wordnikplugin = [[WordnikPlugin alloc] init];
    deviceplugin = [[DevicePlugin alloc] init];
    calculatorplugin = [[CalculatorPlugin alloc] init];
    weatherplugin = [[WeatherPlugin alloc] init];
    displayplugin = [[DisplayPicture alloc] init];
    return [super init];
}

-(void)parseQuery:(NSString *)signal withObject:(NSDictionary *)object {
    NSString *nick = @"test";
    if ([wordnikplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else if ([deviceplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else if ([displayplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else if ([convplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else if ([calculatorplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else if ([weatherplugin parsetext:[object objectForKey:@"query"] nick:nick server:self]){
    } else {
         [self sendCellFromVA:@"Sorry, but I was not able to understand what you were saying." speech:@"Sorry, but I was not able to understand what you were saying."];
        [self finishSession];
    }
}

-(void)finishSession {
    [[CPDistributedMessagingCenter centerNamed:@"org.coolstar.vassistantclient"] sendMessageName:@"completeQuery" userInfo:nil];
}

-(void)sendCellFromVA:(NSString *)text speech:(NSString *)voicemsg {
    [[CPDistributedMessagingCenter centerNamed:@"org.coolstar.vassistantclient"] sendMessageName:@"DisplayMSG" userInfo:[NSDictionary dictionaryWithObjectsAndKeys:text,@"text",voicemsg,@"speech",nil]];
}

-(void)sendAction:(id)action {
    [[CPDistributedMessagingCenter centerNamed:@"org.coolstar.vassistantclient"] sendMessageName:@"PerformAction" userInfo:action];
}

-(void)pushSnippet:(NSDictionary *)snippet {
    [[CPDistributedMessagingCenter centerNamed:@"org.coolstar.vassistantclient"] sendMessageName:@"DisplaySnippet" userInfo:snippet];
}

-(BOOL)findRegex:(NSString *)text withRegex:(NSString *)regex {
    NSArray *splittext = [text captureComponentsMatchedByRegex:regex options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil];
	if ([splittext count] > 1){
		return YES;
	} else {
		return NO;
	}
}

-(void)exit {
    exit(0);
}

-(void)dealloc {
    [server stopServer];
    [server release];
    [super dealloc];
}

@end