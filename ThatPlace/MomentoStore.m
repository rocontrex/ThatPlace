//
//  MomentoStore.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "MomentoStore.h"
#import "AppDelegate.h"

@interface MomentoStore()

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation MomentoStore

static NSString *DATA_MODEL_ENTITY_NAME = @"Momento";

+(instancetype)instancia{
    static MomentoStore *instancia = nil;
    
    if (!instancia) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        instancia = [[self alloc] initPrivate];
        instancia.managedObjectContext = appDelegate.managedObjectContext;
        
        //[instancia zerarStoredData];
    }
    
    return instancia;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[MomentoStore instancia]"userInfo:nil];
}

- (void)zerarStoredData{
    // Delete all objects
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:DATA_MODEL_ENTITY_NAME];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self createMomentoWithTitulo:@"titulo" andDescricao:@"descricao" andLatitude:-3.134324 andLongitude:-59.992323 andData:[NSDate date] andFoto:[UIImage imageNamed:@""] andTipoPino:1];
    
    if (error) {
        NSLog(@"Error fetching objects: %@", error.userInfo);
    }
    
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    for (NSManagedObject *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
}

- (Momento *) createMomentoWithTitulo:(NSString *)titulo andDescricao:(NSString *)descricao andLatitude:(float)latitude andLongitude:(float)longitude andData:(NSDate *)data andFoto:(UIImage *)foto andTipoPino:(int)tipopino{
    
    
    Momento * momento = [NSEntityDescription insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    
    momento.titulo = titulo;
    momento.descricao = descricao;
    momento.latitude = [NSNumber numberWithFloat:latitude];
    momento.longitude = [NSNumber numberWithFloat:longitude];
    momento.data = data;
    momento.foto = foto;
    momento.tipopino = tipopino;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
    return momento;
}

-(NSMutableArray *)getAllMoments{
    
    NSFetchedResultsController *fetchedResultsControllerLocal;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:DATA_MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titulo" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsControllerLocal = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    if (![fetchedResultsControllerLocal performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSMutableArray *nma = [NSMutableArray arrayWithArray:fetchedResultsControllerLocal.fetchedObjects];
    
    return nma;

}

@end
