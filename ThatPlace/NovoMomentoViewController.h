//
//  NovoMomentoViewController.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Momento.h"

@interface NovoMomentoViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) Momento *momentoBase;

@end
