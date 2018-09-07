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
	
    if ([url.host isEqualToString:@"www.reddit.com"] ||
        [url.host isEqualToString:@"reddit.com"] ||
        [url.host isEqualToString:@"m.reddit.com"] ||
        [url.host isEqualToString:@"old.reddit.com"] ||
        [url.host containsString:@".reddit.com"]) {
        
        if ([url.path isEqualToString:@"/"] || [url.path isEqualToString:@""]) {
            return [NSURL URLWithString:@"apollo://"];
        } else {
            return [NSURL URLWithString:[NSString stringWithFormat:@"apollo://reddit.com%@/?%@", url.path, url.query]];
        }
    }

    return nil;
}

@end
