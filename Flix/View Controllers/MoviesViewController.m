//
//  MoviesViewController.m
//  Flix
//
//  Created by jessicasyl on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (strong,nonatomic) NSArray *filteredmovies;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate=self;
    self.searchBar.delegate=self;
    [self.activityIndicator startAnimating];
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
}
- (IBAction)showAlert:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Load Movies"
                                                                               message:@"No Internet Connection"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK button is pressed");
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
}

- (void)fetchMovies{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               self.alertButton.hidden =NO;
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               
               
               self.movies=dataDictionary[@"results"];
               self.filteredmovies = self.movies;
               
               
               [self.tableView reloadData];
               [self.activityIndicator stopAnimating];

               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text =movie[@"original_title"];
    cell.synopsisLabel.text =movie[@"overview"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image=nil;
    [cell.posterView setImageWithURL:posterURL];
    
//    NSURL *urlSmall = posterURL;
//    NSURL *urlLarge = posterURL;

//    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:urlSmall];
//    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:urlLarge];
//
//    __weak MoviesViewController *weakSelf = self;
//
//    [cell.posterView setImageWithURLRequest:requestSmall
//                          placeholderImage:nil
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {
//
//                                       // smallImageResponse will be nil if the smallImage is already available
//                                       // in cache (might want to do something smarter in that case).
//                                       weakSelf.cell.posterView.alpha = 0.0;
//                                       weakSelf.cell.imageView.image = smallImage;
//
//                                       [UIView animateWithDuration:0.3
//                                                        animations:^{
//
//                                                            weakSelf.cell.posterView.alpha = 1.0;
//
//                                                        } completion:^(BOOL finished) {
//                                                            // The AFNetworking ImageView Category only allows one request to be sent at a time
//                                                            // per ImageView. This code must be in the completion block.
//                                                            [weakSelf.cell.posterView setImageWithURLRequest:requestLarge
//                                                                                  placeholderImage:smallImage
//                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage * largeImage) {
//                                                                                                weakSelf.imageView.image = largeImage;
//                                                                                  }
//                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                                                                               // do something for the failure condition of the large image request
//                                                                                               // possibly setting the ImageView's image to a default image
//                                                                                           }];
//                                                        }];
//                                   }
//                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                       // do something for the failure condition
//                                       // possibly try to get the large image
//                                   }];
    
    
        
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        self.movies = self.filteredmovies;
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject[@"original_title"] containsString:searchText];
        }];
        self.movies = [self.movies filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredmovies);
        
    }
    else {
        self.movies = self.filteredmovies;
    }
    
    [self.tableView reloadData];
 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSString *searchText = (NSString *) self.searchBar.text;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailsViewController  = [segue destinationViewController];
    
    detailsViewController.movie = movie;
    NSLog(@"Tapping on a movie!");
}


@end
