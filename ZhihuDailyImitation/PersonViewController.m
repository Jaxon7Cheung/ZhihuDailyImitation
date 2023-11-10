//
//  PersonViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import "PersonViewController.h"
#import "CollectionViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.personView = [[PersonView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: self.personView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressBack) name: @"backNotification" object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(didselectCollection) name: @"didselectCollection" object: nil];
}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)didselectCollection {
    CollectionViewController* collectionViewController = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController: collectionViewController animated: YES];
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
