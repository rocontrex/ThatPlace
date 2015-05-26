//
//  FeedTableViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 11/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Momento.h"
#import "MomentoStore.h"
#import "FeedTableViewCell1.h"
#import "UsuarioStore.h"
@interface FeedTableViewController () //<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewFeed;
@property (weak, nonatomic) NSMutableArray *arrayMomentos;
//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayMomentos = [[MomentoStore instancia] getAllMoments];
    NSLog(@"%lu", [self.arrayMomentos count]);
    
    //_arrayMomentos = [[MomentoStore sharedStore] getAllMomento];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSFetchedResultsController *)fetchedResultsController {
    return [[UsuarioStore sharedStore] fetchedResultsController];
}
//Adicionado
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    //[[MomentoStore sharedStore] loadAllMomento];
//    //_arrayMomentos = [[MomentoStore sharedStore] getAllMomento];
//     //[self.tableViewFeed reloadData];
//    for(Momento *mom in self.arrayMomentos){
//        NSLog(@"%@", mom.titulo);
//    }
//    
//    [self.tableViewFeed reloadData];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayMomentos count];
}

/**---------------------------------------------------------------------------------------------**/
                    /**TENTATIVA DE DAR REFRESH NA TABLE VIEW DE MOMENTOS**/
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
//{
//    [self.fetchedResultsController performFetch:nil];
//    [self.tableViewFeed performSelectorOnMainThread:@selector(reloadData)
//                                withObject:nil
//                             waitUntilDone:YES];
//}
//
//
/**---------------------------------------------------------------------------------------------**/

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellIdentifier = @"Cell1";
    
    FeedTableViewCell1 *cell = (FeedTableViewCell1 *)[self.tableViewFeed
                                                dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FeedTableViewCell1 alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Momento *momento = [self.arrayMomentos objectAtIndex:indexPath.row];
   
    cell.lbTitulo.text = momento.titulo;
    cell.lbData.text = momento.data;
    cell.imBackgroudImage.image = momento.foto;
    
    NSLog(@"Descricao: %@",momento.descricao);
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@"\n"] ) {
        
        [textView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

@end
