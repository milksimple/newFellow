//
//  JXQuestionViewController.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXQuestionViewController.h"
#import "JXFriendViewController.h"

@interface JXQuestionViewController ()

@end

@implementation JXQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.enabled = NO;
    titleButton.frame = CGRectMake(0, 0, 120, 36);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [titleButton setTitle:@"鸟司问答" forState:UIControlStateNormal];
    self.navigationController.navigationBar.barTintColor = JXColor(101, 205, 63);
    [titleButton setImage:[UIImage imageNamed:@"nav_question"] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleButton;
    
    UIButton *tstButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    tstButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:tstButton];
    [tstButton addTarget:self action:@selector(tstButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tstButtonClicked {
    [self.navigationController pushViewController:[[JXFriendViewController alloc] init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
