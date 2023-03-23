//
//  PokemonModels.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum Pokemon {
  // MARK: - Use cases -
    struct PokemonListModel{
        var name:String
        var image: String
        var abilityUrl: String
    }
    
  enum PokemonList {
    struct Request { 

    }

    struct Response {
        var response: [PokemonItemModel] = []
    }

    struct ViewModel {
        var viewModel: [PokemonListModel] = []
    }
  }
}
