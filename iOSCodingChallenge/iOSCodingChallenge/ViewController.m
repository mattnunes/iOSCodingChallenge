//
//  ViewController.m
//  iOSCodingChallenge
//
//  Created by Administrator on 5/6/15.
//  Copyright (c) 2015 Touch of Modern. All rights reserved.
//

#import "ViewController.h"
#import "ProductCell.h"
#import "DataService.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

- (void)handleError:(nonnull NSError *)error;
- (void)productsDidLoad:(nonnull NSArray <Product *> *)products;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIRefreshControl *refreshControl;

@property DataService *service;
@property NSArray *products;

@property NSProgress *productsProgress;

@end

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
@implementation ViewController

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.service = [[DataService alloc] init];
    }
    return self;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:[self refreshControl]];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refresh:self];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)handleError:(nonnull NSError *)error
{
    NSString *title = NSLocalizedString(@"Error Loading Products",
                                        @"Error Loading Products message");
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title
                                                                        message:[error localizedDescription]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK")
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)productsDidLoad:(nonnull NSArray <Product *> *)products
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    self.products = [products sortedArrayUsingDescriptors:@[sortDescriptor]];
    [self.tableView reloadData];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (IBAction)refresh:(id)sender
{
    [self.productsProgress cancel];
    [self.refreshControl beginRefreshing];
    
    self.productsProgress = [self.service getProducts:^(NSArray<Product *> * _Nullable products, NSError * _Nullable error) {
        
        [self.refreshControl endRefreshing];
        self.productsProgress = nil;
        
        if (error) {
            [self handleError:error];
        }
        else {
            [self productsDidLoad:products];
        }
    }];
}

#pragma mark - UITableViewDataSource
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ProductCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setProduct:[self.products objectAtIndex:indexPath.row] service:[self service]];
    return cell;
}

#pragma mark - UITableViewDelegate
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Remove",
                             @"Remove");
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *mProducts = [NSMutableArray arrayWithArray:[self products]];
    [mProducts removeObjectAtIndex:[indexPath row]];
    self.products = [NSArray arrayWithArray:mProducts];
    
    // Animate the row removal
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

@end

