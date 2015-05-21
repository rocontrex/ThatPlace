//
//  ImageTransformer.m
//  ThatPlace
//
//  Created by Matheus Alves on 21/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "ImageTransformer.h"
@import UIKit;

@implementation ImageTransformer
+(Class) transformedValueClass{
    return [NSData class];
}

-(id) transformedValue:(id)value{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

-(id) reverseTransformedValue:(id)value{
    return [UIImage imageWithData:value];
}
@end
