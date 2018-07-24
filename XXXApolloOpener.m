#import <Opener/Opener.h>

@interface XXXApolloOpener : HBLOHandler

@end

@implementation XXXApolloOpener

- (instancetype)init {
    self = [super init];

    if (self) {
        self.name = @"Apollo Opener";
        self.identifier = @"com.gilshahar7.apolloopener";
    }

    return self;
}

- (id)openURL:(NSURL *)url sender:(NSString *)sender {
	NSString *urlString = [url.absoluteString lowercaseString];
    if ([url.host isEqualToString:@"www.m.reddit.com"] || [url.host isEqualToString:@"www.reddit.com"] || [url.host isEqualToString:@"m.reddit.com"] || [url.host isEqualToString:@"reddit.com"] || [url.host containsString:@".reddit.com"]) {
		if([urlString containsString:@"https"]){
			urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"apollo"];
		}else if([urlString containsString:@"http"]){
			urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"apollo"];
		}
		
		if([urlString isEqualToString:@"apollo://www.reddit.com/"] || [urlString isEqualToString:@"apollo://reddit.com/"] || [urlString isEqualToString:@"apollo://www.reddit.com"] || [urlString isEqualToString:@"apollo://reddit.com"]){
			urlString = @"apollo://";
		}
        return [NSURL URLWithString:urlString];
    }

    return nil;
}

@end