//
//  NovoMomentoViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "NovoMomentoViewController.h"
#import "MomentoStore.h"

@interface NovoMomentoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfData;
@property (weak, nonatomic) IBOutlet UITextField *tfTitulo;
@property (weak, nonatomic) IBOutlet UITextView *tvDescricao;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_constraintHeight;

@property (nonatomic) Momento *momentoBase;

@end

@implementation NovoMomentoViewController

NSString * documentDir;
NSString * path;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self adjustContentView];
    
    documentDir =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [documentDir stringByAppendingPathComponent:@"imagem.igo"];
    
    
}
- (IBAction)SalvarMomento:(id)sender {
}

- (IBAction)TirarFoto:(id)sender {
    UIImagePickerController * picker;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self createThumbnail];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (IBAction)RoloCamera:(id)sender {
    UIImagePickerController * picker;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        picker = [[UIImagePickerController alloc] init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        [self createThumbnail];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

-(void) createThumbnail{
    UIImage *originalImage = self.imageView.image; // Give your original Image
    CGSize destinationSize = CGSizeMake(25, 25); // Give your Desired thumbnail Size
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *thumbNailimageData = UIImagePNGRepresentation(newImage);
    UIGraphicsEndImageContext();
    
    [thumbNailimageData writeToFile:path atomically:NO];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tfData resignFirstResponder];
    [self.tfTitulo resignFirstResponder];
    [self.tvDescricao resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) adjustContentView{
    UIView *lo = [self.contentScrollView.subviews lastObject];
    NSInteger oy = lo.frame.origin.y;
    NSInteger ht = lo.frame.size.height;
    
    NSLog(@"oy: %d / ht: %d", oy, ht);
    
    CGRect novoframe = self.contentScrollView.frame;
    novoframe.size.height = oy + ht;
    self.contentScrollView.frame = novoframe;
    self.contentView_constraintHeight.constant = oy+ht;
    
    NSLog(@"%f", self.contentScrollView.frame.size.height);
    NSLog(@"%f", self.contentView_constraintHeight.constant);

}


@end
