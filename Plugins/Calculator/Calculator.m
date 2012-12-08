#import "Calculator.h"
#import "../../VAssistantServer.h"

@implementation CalculatorPlugin

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    NSString *q = text;
    if ([server findRegex:text withRegex:@"(.*)(what is|calculate|compute|find (us|me|him|her|it)) (.*)"]){
        q = [[text captureComponentsMatchedByRegex:@"(.*)(what is|calculate|compute|find (us|me|him|her|it)) (.*)" options:RKLCaseless range:NSMakeRange(0,[text length]) error:nil] lastObject];
    }
    NSString *googleurl = [NSString stringWithFormat:@"http://www.google.com/ig/calculator?hl=en&q=%@",[[q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]];
    NSData *rawjson = [NSData dataWithContentsOfURL:[NSURL URLWithString:googleurl]];
    NSString *json = [[NSString alloc] initWithData:rawjson encoding:NSUTF8StringEncoding];
    [json autorelease];
    NSRange calcrange1 = [json rangeOfString:@"rhs: \""];
    NSString *calchalf = [json substringFromIndex:calcrange1.location+6];
    NSRange calcrange2 = [calchalf rangeOfString:@"\",error"];
    NSString *calc = [calchalf substringToIndex:calcrange2.location];
    
    NSRange errorrange1 = [json rangeOfString:@"error: \""];
    NSString *errorhalf = [json substringFromIndex:errorrange1.location+8];
    NSRange errorrange2 = [errorhalf rangeOfString:@"\",icc"];
    NSString *error = [errorhalf substringToIndex:errorrange2.location];
    if ([error isEqualToString:@""]){
        [server sendCellFromVA:calc speech:calc];
        [server finishSession];
        return YES;
    }
    return NO;
}

@end