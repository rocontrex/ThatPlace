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
@end

@implementation MostrarEditarMomentoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        if(!self.momento.foto){
            //ADICIONAR UMA FOTO LEGAL
        }else if (!self.momento.descricao){
        self.tvDescricao.text = @"Adicionar alguma descrição sobre este momento.";
        }else{
            self.imFoto.image = self.momento.foto;
            self.tfTitulo.text = self.momento.titulo;
            self.tvDescricao.text = self.momento.descricao;
            //self.tfData.text = self.momento.data;
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    }else/* if ([self.tfData.text isEqualToString:@""]){
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro!" message:@"Insira a Data do momento" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
          [alert show];
          [self.tfData becomeFirstResponder];
          return;
          }else*/{
              self.momento.foto = self.imFoto.image;
              self.momento.titulo = self.tfTitulo.text;
              self.momento.descricao = self.tvDescricao.text;
              //self.momento.data = self.lbData.text;    NAO SEI AINDA COMO FAZER ISSO //ActionSheet
          }
    [[self navigationController]popViewControllerAnimated:TRUE];
}

@end
