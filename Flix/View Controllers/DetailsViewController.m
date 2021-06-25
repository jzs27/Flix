//
//  DetailsViewController.m
//  Flix
//
//  Created by jessicasyl on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    
    [self.backdropView setImageWithURL:backdropURL];
    
    NSURL *urlSmall = posterURL;
    NSURL *urlLarge = posterURL;

    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:urlSmall];
    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:urlLarge];


    [self.backdropView setImageWithURLRequest:requestSmall
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {

                                       // smallImageResponse will be nil if the smallImage is already available
                                       // in cache (might want to do something smarter in that case).
                                       self.backdropView.alpha = 0.0;
                                       self.backdropView.image = smallImage;

                                       [UIView animateWithDuration:0.3
                                                        animations:^{

                                                            self.backdropView.alpha = 1.0;

                                                        } completion:^(BOOL finished) {
                                                            // The AFNetworking ImageView Category only allows one request to be sent at a time
                                                            // per ImageView. This code must be in the completion block.
                                                            [self.backdropView setImageWithURLRequest:requestLarge
                                                                                  placeholderImage:smallImage
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage * largeImage) {
                                                                                                self.backdropView.image = largeImage;
                                                                                  }
                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                               // do something for the failure condition of the large image request
                                                                                               // possibly setting the ImageView's image to a default image
                                                                                           }];
                                                        }];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       // do something for the failure condition
                                       // possibly try to get the large image
                                   }];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    NSString *dateinfo =self.movie[@"release_date"];

    

    NSString *month = [dateinfo substringFromIndex:6];
    
    if ([[month substringToIndex:1] isEqualToString:@"1"]){
        month = @"Jan";
    }
    if ([[month substringToIndex:1] isEqualToString:@"2"]){
        month = @"Feb";
    }
    if ([[month substringToIndex:1] isEqualToString:@"3"]){
        month = @"Mar";
    }
    if ([[month substringToIndex:1] isEqualToString:@"4"]){
        month = @"Apr";
    }
    
    if ([[month substringToIndex:1] isEqualToString:@"5"]){
        month = @"May";
    }

    if ([[month substringToIndex:1] isEqualToString:@"6"]){
        month = @"Jun";
    }
    if ([[month substringToIndex:1] isEqualToString:@"7"]){
        month = @"Jul";
    }
    
    if ([[month substringToIndex:1] isEqualToString:@"8"]){
        month = @"Aug";
    }
    if ([[month substringToIndex:1] isEqualToString:@"9"]){
        month = @"Sept";
    }
    
    if ([[month substringToIndex:2] isEqualToString:@"10"]){
        month = @"Oct";
    }
    if ([[month substringToIndex:2] isEqualToString:@"11"]){
        month = @"Nov";
    }
    if ([[month substringToIndex:2] isEqualToString:@"12"]){
        month = @"Dec";
    }
    
    NSString *year = [dateinfo substringToIndex:4];
    NSString *monthandyear = [NSString stringWithFormat:@"%@ %@", month,year];
    
    
    self.yearLabel.text = monthandyear;
    
    
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    
    NSArray *genre_ids = self.movie[@"genre_ids"];
    
    
    NSString *genre_id = genre_ids[0];
    
    NSDictionary *genres=@{@28:@"Action",@12:@"Adventure",@16:@"Animation",@35:@"Comedy",@80:@"Crime",@99:@"Documentary",@18:@"Drama",@10751:@"Family",@14:@"Fantasy",@36:@"History",@27:@"Horror",@10402:@"Music",@9648:@"Mystery",@10749:@"Romance",@878:@"Science Fiction",@10770:@"TV Movie",@53:@"Thriller",@10752:@"War",@37:@"Western"};

    NSLog(@"%@", genre_id);
   
    
    
    NSString *genreStringNew = @"";
    
    for (NSString *gid in genre_ids){
        if (genreStringNew.length >0){
            genreStringNew = [genreStringNew stringByAppendingString:@", "];
        }
        NSString *genreString = [genres objectForKey: gid];
        genreStringNew = [genreStringNew stringByAppendingString:genreString];
    }
    
    NSLog(@"%@",genreStringNew);
    self.genreLabel.text =genreStringNew;
    
    [self.genreLabel sizeToFit];
    
    
    
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    DetailsViewController *detailsViewController  = [segue destinationViewController];
    
    detailsViewController.movie = self.movie;
    NSLog(@"Tapping on a movie!");
}


@end
