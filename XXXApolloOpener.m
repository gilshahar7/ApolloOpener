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
        [url.host isEqualToString:@"reddit.app.link"] ||
        [url.host containsString:@".reddit.com"]) {

        if ([url.host isEqualToString:@"reddit.app.link"]) {
            NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url 
                                                resolvingAgainstBaseURL:NO];
            NSArray *queryItems = urlComponents.queryItems;
            NSString *og_redirect = [self valueForKey:@"$og_redirect" 
                            fromQueryItems:queryItems];

            if ([og_redirect length] != 0) {
                url = [NSURL URLWithString:og_redirect];
            } else {
                return nil;
            }
        }

        return [self createApolloURLFromURL:url];
    }

    return nil;
}

- (NSURL *)createApolloURLFromURL:(NSURL *)url {
    // If URL is /r/:subreddit/wiki or (/about), let the Official Reddit app handle
    if (url.pathComponents.count >= 4 &&
            ([url.pathComponents[3] isEqualToString:@"wiki"] ||
            [url.pathComponents[3] isEqualToString:@"about"])) {
        return nil;
    }

    // if URL is /live/, let the Official Reddit app handle
    if (url.pathComponents.count >= 3 && [url.pathComponents[1] isEqualToString:@"live"]) {
        return nil;
    }

    if ([url.path isEqualToString:@"/"] || [url.path isEqualToString:@""]) {
        return [NSURL URLWithString:@"apollo://"];
    } else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"apollo://reddit.com%@/?%@", url.path, url.query]];
    }
}

/*
Thanks to:
- https://stackoverflow.com/questions/8756683/best-way-to-parse-url-string-to-get-values-for-keys
*/
- (NSString *)valueForKey:(NSString *)key fromQueryItems:(NSArray *)queryItems {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", key];
    NSURLQueryItem *queryItem = [[queryItems 
                                  filteredArrayUsingPredicate:predicate]
                                 firstObject];
    return queryItem.value;
}

@end
