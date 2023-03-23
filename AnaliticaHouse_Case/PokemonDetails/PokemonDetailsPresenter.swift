//
//  PokemonDetailsPresenter.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PokemonDetailsPresentationLogic: AnyObject {
    func presentPokemonDetails(response:PokemonDetails.PokemonDetailsModel.Response)
}

class PokemonDetailsPresenter {
  weak var viewController: PokemonDetailsDisplayLogic?
}

// MARK: - PokemonDetailsPresentationLogic -

extension PokemonDetailsPresenter: PokemonDetailsPresentationLogic {
    func presentPokemonDetails(response: PokemonDetails.PokemonDetailsModel.Response) {
        let name = response.pokemonItem.name
        let image = "\(response.pokemonItem.sprites.frontDefault)"
        let weight = "\(response.pokemonItem.weight)"
        let height = "\(response.pokemonItem.height)"
//        let effect = response.pokemonDetails[0].effectEntries[1].effect
//        let shortEffect = response.pokemonDetails[0].effectEntries[1].shortEffect
//        let generation = "\(response.pokemonDetails[0].generation.name)"
        let effect = response.pokemonDetails.effectEntries[1].effect
        let shortEffect = response.pokemonDetails.effectEntries[1].shortEffect
        let generation = "\(response.pokemonDetails.generation.name)"
        var arr: [PokemonDetails.pokeDetailModel] = []
        arr.append(PokemonDetails.pokeDetailModel(name: name, image: image, effect: effect, shortEffect: shortEffect, generation: generation, weight: weight, height: height))
        
//        let viewModel = PokemonDetails.PokemonDetailsModel.ViewModel(pokemonDetailsData: PokemonDetails.pokeDetailModel.init(name: name, image: image, effect: effect, shortEffect: shortEffect, generation: generation, weight: weight, height: height))
        
        let viewModel = PokemonDetails.PokemonDetailsModel.ViewModel(pokemonDetailsData: arr)
        
        self.viewController?.displayPokemonDetails(viewModel: viewModel)
    }
}
