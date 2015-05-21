//
//  Momento.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@import UIKit;
@interface Momento : NSManagedObject

@property (nonatomic, retain) NSString *titulo;
@property (nonatomic, retain) NSString *descricao;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSDate *data;
@property (nonatomic, retain) UIImage *foto;
@property (nonatomic) int tipopino; //Basic: 0 - Família, 1 - Feliz, 2 - Tristeza

@end
