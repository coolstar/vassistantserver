#import "CPDistributedMessagingCenter.h"
#import "RegexKitLite.h"
#import "Plugins/Conversation/Conversation.h"
#import "Plugins/Wordnik/WordnikPlugin.h"
#import "Plugins/Device/DevicePlugin.h"
#import "Plugins/Calculator/Calculator.h"
#import "Plugins/Weather/WeatherPlugin.h"
#import "Plugins/DisplayPicture/DisplayPicture.h"

@interface VAssistantServer : NSObject {
    CPDistributedMessagingCenter *server;
    Conversation *convplugin;
    WordnikPlugin *wordnikplugin;
    DevicePlugin *deviceplugin;
    CalculatorPlugin *calculatorplugin;
    WeatherPlugin *weatherplugin;
    DisplayPicture *displayplugin;
}

-(void)sendCellFromVA:(NSString *)text speech:(NSString *)voicemsg;
-(void)finishSession;
-(BOOL)findRegex:(NSString *)text withRegex:(NSString *)regex;
-(void)sendAction:(id)action;
-(void)pushSnippet:(NSDictionary *)snippet;

@end