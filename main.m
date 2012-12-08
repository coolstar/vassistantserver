#import "VAssistantServer.h"

int main(int argc, char **argv, char **envp) {
    NSLog(@"%@",@"Started!");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    VAssistantServer *server = [[VAssistantServer alloc] init];
    [[NSRunLoop currentRunLoop] run];
    [server release];
    [pool drain];
    
    NSLog(@"%@",@"Quit!");
    
	return 0;
}

// vim:ft=objc
