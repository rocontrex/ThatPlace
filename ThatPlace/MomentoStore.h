//
//  MomentoStore.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
#import "Momento.h"

@interface MomentoStore : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

+ (instancetype) instancia;

- (Momento *) createMomentoWithTitulo: (NSString *) titulo andDescricao: (NSString *) descricao andLatitude: (float) latitude andLongitude: (float) longitude andData : (NSDate *) data andFoto : (UIImage *) foto andTipoPino: (int) tipopino;

-(NSMutableArray *) getAllMoments;

@end;