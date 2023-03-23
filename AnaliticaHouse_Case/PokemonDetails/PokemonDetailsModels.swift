//
//  PokemonDetailsModels.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum PokemonDetails {
  // MARK: - Use cases -
    
    struct PokemonDetailDataModel {
        var name: String
        var image: String
        var effect: String
        var shortEffect: String
        var generation: String
        var weight: String
        var height: String
    }
  
  enum PokemonDetailsModel {
    struct Request {
        
    }

    struct Response {
        var pokemonDetails: PokemonAbilityModel
        var pokemonItem: Pokemon.PokemonListModel
    }

    struct ViewModel {
        var pokemonDetailsData: [PokemonDetailDataModel] = []
    }
  }
}
