//
//  PokemonDetailsInteractor.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PokemonDetailsBusinessLogic: AnyObject { 
    func viewDidLoad()
}

protocol PokemonDetailsDataStore: AnyObject {
    var pokemonDetails: PokemonAbilityModel! {get set}
    var pokemonItemData: PokemonItemModel! {get set}
}

class PokemonDetailsInteractor {
    var presenter: PokemonDetailsPresentationLogic?
    var worker: PokemonDetailsWorker?
    var pokemonDetails: PokemonAbilityModel!
    var pokemonItemData: PokemonItemModel!
}

// MARK: - PokemonDetailsBusinessLogic -

extension PokemonDetailsInteractor: PokemonDetailsBusinessLogic, PokemonDetailsDataStore { 
    func viewDidLoad() {
        let response = PokemonDetails.PokemonDetailsModel.Response(pokemonDetails: self.pokemonDetails,pokemonItem: self.pokemonItemData)
        self.presenter?.presentPokemonDetails(response: response)
    }
}
