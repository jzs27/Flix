//
//  PosterCollectionsViewController.m
//  Flix
//
//  Created by jessicasyl on 6/24/21.
//

#import "PosterCollectionsViewController.h"
#import "UIImageView+AFNetworking.h"


@interface PosterCollectionsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end

@implementation PosterCollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    [self.posterView setImageWithURL:posterURL];
    self.titleLabel.text = self.movie[@"title"];
    [self.titleLabel sizeToFit];
    // Do any additional setup after loading the view.
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
