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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfData_constraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfData_constraintVertical;
@property (weak, nonatomic) IBOutlet UITextField *tfTitulo;
@property (weak, nonatomic) IBOutlet UITextView *tvDescricao;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_constraintHeight;
@property (weak, nonatomic) IBOutlet UIButton *btVoltar;

@property (nonatomic) UIGestureRecognizer *tapper;
@end

@implementation NovoMomentoViewController

NSString * documentDir;
NSString * path;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    self.tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapper];
    
    if (self.momentoBase.data != nil) {
        self.tfData_constraintHeight.constant = 0;
        self.tfData_constraintVertical.constant = 0;
        [self.tfData updateConstraints];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    documentDir =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [documentDir stringByAppendingPathComponent:@"imagem.igo"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self adjustContentView];
    [self desenharTextFields];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

- (IBAction)voltarNavigation:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frameMaster = self.view.frame;
    frameMaster.origin.y -= kbSize.height;
    self.view.frame = frameMaster;
    
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frameMaster = self.view.frame;
    frameMaster.origin.y += kbSize.height;
    self.view.frame = frameMaster;
    
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
    [self.contentScrollView updateConstraints];
    
    NSLog(@"%f", self.contentScrollView.frame.size.height);
    NSLog(@"%f", self.contentView_constraintHeight.constant);

}

//Drawing
- (void) desenharTextFields{
    CGRect rectView = CGRectMake(0, 0, 8, self.tfData.frame.size.height);
    
    UIView *boxUser = [[UIView alloc] initWithFrame:rectView];
    UIView *boxPass = [[UIView alloc] initWithFrame:rectView];
    
    [self.tfData setLeftViewMode:UITextFieldViewModeAlways];
    self.tfData.leftView = boxUser;
    [self.tfTitulo setLeftViewMode:UITextFieldViewModeAlways];
    self.tfTitulo.leftView =boxPass;
}

@end
