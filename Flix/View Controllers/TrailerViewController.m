//
//  TrailerViewController.m
//  Flix
//
//  Created by jessicasyl on 6/25/21.
//

#import "TrailerViewController.h"

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *trailerWebView;
@property (nonatomic, strong) NSDictionary *trailer;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *movieID = self.movie[@"id"];
    //NSString *movieID2 = [movieID substringToIndex:4];
    
    NSLog(@"%@", movieID);
    
    //NSLog(@"%@", movieID2);

    
    NSString *urlBeginning =@"https://api.themoviedb.org/3/movie/";
    NSString *urlEnd = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US";
    NSString *urlFinal = [NSString stringWithFormat:@"%@%@%@", urlBeginning,movieID,urlEnd];
    
    NSLog(@"%@", urlFinal);
    
    //NSURL *urlTrailer = [NSURL URLWithString:urlFinal];
    
    NSURL *url = [NSURL URLWithString:urlFinal];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               
               NSLog(@"%@", [error localizedDescription]);
           }
           else {

               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.trailer=dataDictionary[@"results"][1];
               
               NSLog(@"%@",self.trailer);
               
               NSString *key = self.trailer[@"key"];
               
               
                ///
               // Convert the url String to a NSURL object.
               
               NSString *urlTrailerFinalString = [NSString stringWithFormat:@"%@%@", @"https://www.youtube.com/watch?v=",key];
               NSLog(@"%@", urlTrailerFinalString);
               NSURL *urlTrailerFinal = [NSURL URLWithString:urlTrailerFinalString];

               // Place the URL in a URL Request.
               NSURLRequest *request = [NSURLRequest requestWithURL:urlTrailerFinal
                                                        cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                    timeoutInterval:10.0];
               
               [self.trailerWebView loadRequest:request];
           }
    }];
 [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
