//
//  PokemonInteractor.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PokemonBusinessLogic: AnyObject { 
    func viewDidLoad()
    func getPokemonDetail(url:String)
}

protocol PokemonDataStore: AnyObject { }

class PokemonInteractor {
    var presenter: PokemonPresentationLogic?
    var worker = PokemonWorker()
    var pokemonData: [PokemonItemModel] = []
}

// MARK: - PokemonBusinessLogic -

extension PokemonInteractor: PokemonBusinessLogic, PokemonDataStore { 
    func viewDidLoad() {
        self.getPokemonAllData()
    }
    
    func getPokemonDetail(url: String) {
        self.getPokemonDetails(url: url)
    }
}

extension PokemonInteractor {
    private func getPokemonAllData(){
        self.worker.getPokemonData(completion: { PokeModel in
            for result in PokeModel {
                self.worker.getPokemonItemData(url: result.url, completion: { PokeItemModel in
                    self.pokemonData.append(PokeItemModel)
                    DispatchQueue.main.async {
                        /// Bu kısımda for döngüsünden çıkmak için if sorgusu yazıldı . .
                        if self.pokemonData.count == 20 {
                            let response = Pokemon.PokemonList.Response(response: self.pokemonData)
                            self.presenter?.presentPokemons(response: response)
                        }
                    }
                })
            }
        })
    }
    
    private func getPokemonDetails(url: String){
        self.worker.getPokemonDetails(url: url) { PokeAbility in
            DispatchQueue.main.async {
                self.presenter?.toDetails(pokemonDetails: PokeAbility)
            }
        }
    }
}
