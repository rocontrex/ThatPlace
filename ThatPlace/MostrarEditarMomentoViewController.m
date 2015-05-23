//
//  MostrarEditarMomentoViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 21/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "MostrarEditarMomentoViewController.h"
#import "MomentoStore.h"

//Falta 1
@interface MostrarEditarMomentoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imFoto;
@property (weak, nonatomic) IBOutlet UITextField *tfTitulo;
@property (weak, nonatomic) IBOutlet UITextView *tvDescricao;
@property (weak, nonatomic) IBOutlet UITextField *tfData;
@property (weak, nonatomic) IBOutlet UIButton *btSalvar;
@property (weak, nonatomic) IBOutlet UIButton *btTirarFoto;
@property (weak, nonatomic) IBOutlet UIButton *btAlbum;
@end

@implementation MostrarEditarMomentoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btSalvar.hidden = TRUE;
    self.btAlbum.hidden = TRUE;
    self.btTirarFoto.hidden = TRUE;
    
    self.tfTitulo.enabled = FALSE;
    
    if(self.momento.foto != NULL){ //O objeto tem foto?
        self.imFoto.image = self.momento.foto;
    }
    self.tfTitulo.text = self.momento.titulo;
    if (self.momento.descricao != NULL) {
        self.tvDescricao.text = self.momento.descricao;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    self.tfData.text = [dateFormatter stringFromDate:self.momento.data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)btEditar:(id)sender {
    self.btSalvar.hidden = FALSE;
    self.btAlbum.hidden = FALSE;
    self.btTirarFoto.hidden = FALSE;
    
    self.tfTitulo.enabled = TRUE;
    self.tvDescricao.editable = TRUE;
    self.tfData.enabled = TRUE;
}
- (IBAction)btAlbum:(id)sender {
}
- (IBAction)btTirarFoto:(id)sender {
}
- (IBAction)btVoltar:(id)sender {
    [[self navigationController]popViewControllerAnimated:TRUE];
}
- (IBAction)btSalvar:(id)sender {
    if([self.tfTitulo.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro!" message:@"Crie um título para o momento" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.tfTitulo becomeFirstResponder];
        return;
    }else if ([self.tfData.text isEqualToString:@""]){
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro!" message:@"Insira a Data do momento" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
          [alert show];
          [self.tfData becomeFirstResponder];
          return;
    }else{
        self.momento.foto = self.imFoto.image;
        self.momento.titulo = self.tfTitulo.text;
        self.momento.descricao = self.tvDescricao.text;
        //self.momento.data = self.lbData.text;    NAO SEI AINDA COMO FAZER ISSO //ActionSheet
    }
    [[self navigationController]popViewControllerAnimated:TRUE];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
