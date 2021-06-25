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
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

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
