//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"
#import <UIKit/UIKit.h>

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (void)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    @try {
        NSString *midia = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
        NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:midia]];
        
        NSError *error;
        NSDictionary *midias = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        }
        
        NSArray *resultados = [midias objectForKey:@"results"];
        
//        NSMutableArray *filmes = [[NSMutableArray alloc] init];
//        NSMutableArray *musicas = [[NSMutableArray alloc] init];;
//        NSMutableArray *podcastes = [[NSMutableArray alloc] init];;
//        NSMutableArray *ebookes = [[NSMutableArray alloc] init];
        
        _filmes = [[NSMutableArray alloc] init];
        _musicas = [[NSMutableArray alloc] init];;
        _podcasts = [[NSMutableArray alloc] init];;
        _ebooks = [[NSMutableArray alloc] init];
        
        NSString *ano = [[NSString alloc] init];
        
        for (NSDictionary *item in resultados) {
            if ([[item objectForKey:@"kind"] isEqual:@"feature-movie"]) {
                Filme *filme = [[Filme alloc] init];
                [filme setNome:[item objectForKey:@"trackName"]];
                [filme setArtista:[item objectForKey:@"artistName"]];
                [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [filme setGenero:[item objectForKey:@"primaryGenreName"]];
                [filme setPais:[item objectForKey:@"country"]];
                
                NSString *year = [item objectForKey:@"releaseDate"];
                ano = [year substringToIndex:4];
                            
                [filme setLancamento:ano];
                            
                [_filmes addObject:filme];
            }
            else if ([[item objectForKey:@"kind"] isEqual:@"song"]) {
                Musica *musica = [[Musica alloc] init];
                [musica setNome:[item objectForKey:@"trackName"]];
                [musica setArtista:[item objectForKey:@"artistName"]];
                [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [musica setGenero:[item objectForKey:@"primaryGenreName"]];
                [musica setPais:[item objectForKey:@"country"]];
                
                NSString *year = [item objectForKey:@"releaseDate"];
                ano = [year substringToIndex:4];
                            
                [musica setLancamento:ano];
                            
                [_musicas addObject:musica];
            }
            else if ([[item objectForKey:@"kind"] isEqual:@"podcast"]) {
                Podcast *podcast = [[Podcast alloc] init];
                [podcast setNome:[item objectForKey:@"trackName"]];
                [podcast setArtista:[item objectForKey:@"artistName"]];
                [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
                [podcast setPais:[item objectForKey:@"country"]];
    
                NSString *year = [item objectForKey:@"releaseDate"];
                ano = [year substringToIndex:4];
    
                [podcast setLancamento:ano];
    
                [_podcasts addObject:podcast];
            }
            else if ([[item objectForKey:@"kind"] isEqual:@"ebook"]) {
                Ebook *ebook = [[Ebook alloc] init];
                [ebook setNome:[item objectForKey:@"trackName"]];
                [ebook setArtista:[item objectForKey:@"artistName"]];
                [ebook setDuracao:0];
                [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
                [ebook setPais:[item objectForKey:@"country"]];
                
                NSString *year = [item objectForKey:@"releaseDate"];
                ano = [year substringToIndex:4];
                            
                [ebook setLancamento:ano];
                            
                [_ebooks addObject:ebook];
            }
        }
        
        

//        for (NSDictionary *item in resultadosmovie) {
//            Filme *filme = [[Filme alloc] init];
//            [filme setNome:[item objectForKey:@"trackName"]];
//            [filme setArtista:[item objectForKey:@"artistName"]];
//            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
//            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
//            [filme setPais:[item objectForKey:@"country"]];
//            
//            NSString *year = [item objectForKey:@"releaseDate"];
//            ano = [year substringToIndex:4];
//            
//            [filme setLancamento:ano];
//            
//            
//            [filmes addObject:filme];
//        }
//        for (NSDictionary *item in resultadosmusic) {
//            Musica *musica = [[Musica alloc] init];
//            [musica setNome:[item objectForKey:@"trackName"]];
//            [musica setArtista:[item objectForKey:@"artistName"]];
//            [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
//            [musica setGenero:[item objectForKey:@"primaryGenreName"]];
//            [musica setPais:[item objectForKey:@"country"]];
//            
//            NSString *year = [item objectForKey:@"releaseDate"];
//            ano = [year substringToIndex:4];
//            
//            [musica setLancamento:ano];
//            
//            [musicas addObject:musica];
//        }
//        for (NSDictionary *item in resultadospodcast) {
//            Podcast *podcast = [[Podcast alloc] init];
//            [podcast setNome:[item objectForKey:@"trackName"]];
//            [podcast setArtista:[item objectForKey:@"artistName"]];
//            [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
//            [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
//            [podcast setPais:[item objectForKey:@"country"]];
//            
//            NSString *year = [item objectForKey:@"releaseDate"];
//            ano = [year substringToIndex:4];
//            
//            [podcast setLancamento:ano];
//            
//            [podcastes addObject:podcast];
//        }
//        for (NSDictionary *item in resultadosebook) {
//            Ebook *ebook = [[Ebook alloc] init];
//            [ebook setNome:[item objectForKey:@"trackName"]];
//            [ebook setArtista:[item objectForKey:@"artistName"]];
//            [ebook setDuracao:0];
//            [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
//            [ebook setPais:[item objectForKey:@"country"]];
//            
//            NSString *year = [item objectForKey:@"releaseDate"];
//            ano = [year substringToIndex:4];
//            
//            [ebook setLancamento:ano];
//            
//            [ebookes addObject:ebook];
//        }
        
//        _dados = [[NSArray alloc] initWithObjects:filmes, musicas, podcastes, ebookes, nil];
    }
    @catch (NSException *exception) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Termo não encontrado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alerta show];
    }
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
