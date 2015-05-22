//
//  Momento.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "Momento.h"

@implementation Momento

@dynamic titulo;
@dynamic descricao;
@dynamic latitude;
@dynamic longitude;
@dynamic data;
@dynamic foto;
@dynamic tipopino;

- (id) initWithLatitude: (float) latitude andLongitude: (float) longitude{
    self = [super init];
    
    self.latitude = [NSNumber numberWithFloat:latitude];
    self.longitude = [NSNumber numberWithFloat:longitude];
    
    return self;
}

- (id) initWithLatitude: (float) latitude andLongitude: (float) longitude andData : (NSDate *) data{
    self = [super init];
    
    self.latitude = [NSNumber numberWithFloat:latitude];
    self.longitude = [NSNumber numberWithFloat:longitude];
    self.data = data;
    
    return self;
}

@end
