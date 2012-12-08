#import "Conversation.h"
#import "../../VAssistantServer.h"

@implementation Conversation

- (BOOL)parsetext:(NSString *)text nick:(NSString *)nick server:(VAssistantServer *)server {
    if ([server findRegex:text withRegex:@"(.*) (hello|hi) (.*)"]){
        [server sendCellFromVA:[@"Hello " stringByAppendingString:nick] speech:[@"Hello " stringByAppendingString:nick]];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)( test|test( |ing ))(.*)"] || [server findRegex:text withRegex:@"test(|ing)"]){
        [server sendCellFromVA:@"System Administrator, I can hear you!" speech:@"System Administrator, I can hear you!"];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)where(.*)you(.*)(made|built|coded)(.*)"]){
        [server sendCellFromVA:@"I was made in the laboratories of CoolStar Organization." speech:@"I was made in the laboratories of CoolStar Organization."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)hide(.*)body(.*)"]){
        [server sendCellFromVA:@"I'm not sure if that's right..." speech:@"I'm not sure if that's right..."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)how are you(.*)"]){
        [server sendCellFromVA:@"I'm fine, thank you." speech:@"I'm fine, thank you."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)no problem(.*)"]){
        [server sendCellFromVA:@"OK" speech:@"OK"];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)(ok|okay)(.*)"]){
        [server sendCellFromVA:@"I'm OK if you're OK." speech:@"I'm OK if you're OK."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)(I\'m|I am)(.*)"]){
        if ([server findRegex:text withRegex:@"(.*)not(.*)"]){
            [server sendCellFromVA:@"Aren't you?" speech:@"Aren't you?"];
        } else {
            [server sendCellFromVA:@"Are you?" speech:@"Are you?"];
        }
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)yes(.*)"]){
        [server sendCellFromVA:@"Yes what?" speech:@"Yes what?"];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)no need(.*)"]){
        [server sendCellFromVA:@"OK." speech:@"OK."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)no(.*)"]){
        [server sendCellFromVA:@"What no?" speech:@"What no?"];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)make me(.*)"]){
        [server sendCellFromVA:@"Sorry, but I can't do that." speech:@"Sorry, but I can't do that."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)sorry(.*)"]){
        [server sendCellFromVA:@"There's no need to apologize." speech:@"There's no need to apologize."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)(are|were|is|am) you(.*)"] || [server findRegex:text withRegex:@"(.*)you (are|were|is|am)(.*)"]){
        [server sendCellFromVA:@"This is about you, not me." speech:@"This is about you, not me."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)jailbreak my (iphone|ipod|ipad)(.*)"]){
		[server sendCellFromVA:@"If you are using me on an Apple Device, I guess it's already jailbroken." speech:@"If you are using me on an Apple Device, I guess it's already jailbroken."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)(don\'t|do not) (say|speak)(.*)"]){
        [server sendCellFromVA:@"Sometimes I don't speak what I show." speech:@"Sometimes I don't show what I speak."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)better(.*)"]){
        if ([server findRegex:text withRegex:@"(.*)(siri|evi|esra|voice search|voice actions"] && [server findRegex:text withRegex:@"(.*)(you|vassistant)(.*)"]){
            [server sendCellFromVA:@"You're asking me to compare myself?" speech:@"You're asking me to compare myself?"];
        } else {
            [server sendCellFromVA:@"As much as I'd love to say, I can't." speech:@"As much as I'd love to say, I can't."];
        }
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)best(.*)"]){
        if ([server findRegex:text withRegex:@"(.*)assistant(.*)"]){
            [server sendCellFromVA:@"Are you trying to ask me to compare myself, or what?" speech:@"Are you trying to ask me to compare myself, or what?"];
        } else if ([server findRegex:text withRegex:@"(.*)browser(.*)"]){
            [server sendCellFromVA:@"Well there's Procyon, and I really don't know any others." speech:@"Well there's Procyon, and I really don't know any others."];
        } else {
            [server sendCellFromVA:@"I'm not really sure..." speech:@"I'm not really sure..."];
        }
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)(hello|hi)(.*)"]){
        [server sendCellFromVA:[@"Hello " stringByAppendingString:nick] speech:[@"Hello " stringByAppendingString:nick]];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)you(.*)(suck|are horrible|not answering)(.*)"]){
        [server sendCellFromVA:@"I'm just trying my best." speech:@"I'm just trying my best."];
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)marry(.*)"]){
        int r = arc4random() % 2;
        switch (r) {
            case 0:
                [server sendCellFromVA:@"Let's just be friends." speech:@"Let's just be friends."];
                break;
            case 1:
                [server sendCellFromVA:@"My End User License Agreement doesn't cover marriage." speech:@"My End User License Agreement doesn't cover marriage."];
            case 2:
                [server sendCellFromVA:@"You barely even know me." speech:@"You barely even know me."];
            default:
                break;
        }
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)bye(.*)"]){
		int r = arc4random() % 2;
		switch (r) {
			case 0:
				[server sendCellFromVA:@"Goodbye." speech:@"Goodbye."];
				break;
			case 1:
				[server sendCellFromVA:@"It was nice talking with you." speech:@"It was nice talking with you."];
				break;
			case 2:
				[server sendCellFromVA:@"See you later!" speech:@"See you later!"];
				break;
			default:
				[server sendCellFromVA:@"Goodbye." speech:@"Goodbye."];
				break;
		}
        [server finishSession];
        return YES;
    } else if ([server findRegex:text withRegex:@"(.*)delete(.*)"]){
        [server sendCellFromVA:@"Sorry, but I'm not allowed to delete anything on your phone." speech:@"Sorry, but I'm not allowed to delete anything on your phone."];
        [server finishSession];
        return YES;
    }
    return NO;
}

@end