//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    iTunesManager *itunes;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    itunes = [iTunesManager sharedInstance];
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    
    
    
    
    _busca.translucent = YES;

    [_busca resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    NSArray *sectionNames = [[NSArray alloc] initWithObjects:@"Filmes", @"Músicas", @"Podcasts", @"Ebooks", nil];
//    return sectionNames;
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    switch (section) {
        case 0:
            title = @"Filmes";
            break;
            
        case 1:
            title = @"Músicas";
            break;
            
        case 2:
            title = @"Podcasts";
            break;
            
        case 3:
            title = @"Ebook";
            break;
            
        default:
            break;
    }
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    switch (section) {
        case 0:
            count = [itunes.filmes count];
            break;
            
        case 1:
            count = [itunes.musicas count];
            break;
        
        case 2:
            count = [itunes.podcasts count];
            break;
            
        case 3:
            count = [itunes.ebooks count];
            break;
        
        default:
            break;
    }
    return count;
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSMutableArray *aux = [itunes.dados objectAtIndex:(indexPath.section)];
    TableViewCell *celula = [[TableViewCell alloc] init];
    celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];

    if (indexPath.section == 0) {
        Filme *mid = [[itunes filmes]objectAtIndex:indexPath.row];
//        Filme *mid = [aux objectAtIndex:indexPath.row];
        [celula.nome setText:mid.nome];
        [celula.artista setText:mid.artista];
        [celula.duracao setText: [NSString stringWithFormat:@"%d min", [mid.duracao intValue]/6000]];
        [celula.genero setText:mid.genero];
        [celula.pais setText:mid.pais];
        [celula.lancamento setText:mid.lancamento];
    }
    else if (indexPath.section == 1) {
        Musica *mid = [[itunes musicas]objectAtIndex:indexPath.row];
//        Musica *mid = [aux objectAtIndex:indexPath.row];
        [celula.nome setText:mid.nome];
        [celula.artista setText:mid.artista];
        [celula.duracao setText: [NSString stringWithFormat:@"%d min", [mid.duracao intValue]/6000]];
        [celula.genero setText:mid.genero];
        [celula.pais setText:mid.pais];
        [celula.lancamento setText:mid.lancamento];
    }
    else if (indexPath.section == 2) {
        Podcast *mid = [[itunes podcasts]objectAtIndex:indexPath.row];
//        Podcast *mid = [aux objectAtIndex:indexPath.row];
        [celula.nome setText:mid.nome];
        [celula.artista setText:mid.artista];
        [celula.duracao setText: [NSString stringWithFormat:@"%d min", [mid.duracao intValue]/6000]];
        [celula.genero setText:mid.genero];
        [celula.pais setText:mid.pais];
        [celula.lancamento setText:mid.lancamento];
    }
    else if (indexPath.section == 3) {
        Ebook *mid = [[itunes ebooks]objectAtIndex:indexPath.row];
//        Ebook *mid = [aux objectAtIndex:indexPath.row];
        [celula.nome setText:mid.nome];
        [celula.artista setText:mid.artista];
        [celula.duracao setText:@" "];
        [celula.genero setText:mid.genero];
        [celula.pais setText:mid.pais];
        [celula.lancamento setText:mid.lancamento];
    }
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar = _busca;
    NSString *termo = [[NSString alloc] init];
    termo = searchBar.text;
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z0-9a-z]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:termo options:0 range:NSMakeRange(0, [termo length])];
    
    if (!numberOfMatches) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Caracteres inválidos" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alerta show];
        return;
    }
    
    [itunes buscarMidias:termo];
    [searchBar endEditing:YES];
    [self.tableview reloadData];
}
@end
