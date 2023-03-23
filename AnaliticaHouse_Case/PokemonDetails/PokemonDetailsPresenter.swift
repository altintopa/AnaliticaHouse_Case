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
        let image = "\(response.pokemonItem.image)"
        let weight = "\(response.pokemonItem.weight)"
        let height = "\(response.pokemonItem.height)"
        var effect = ""
        var shortEffect = ""
        
        /// Bu kısımda gelen değerler almanca değilde ingilizce gelsin diye bu şekilde yapıldı. . .
        if response.pokemonDetails.effectEntries[0].language.name == "en" {
            effect = response.pokemonDetails.effectEntries[0].effect
            shortEffect = response.pokemonDetails.effectEntries[0].shortEffect
        }else {
            effect = response.pokemonDetails.effectEntries[1].effect
            shortEffect = response.pokemonDetails.effectEntries[1].shortEffect
        }
        
        let generation = "\(response.pokemonDetails.generation.name)"
        var arr: [PokemonDetails.PokemonDetailDataModel] = []
        arr.append(PokemonDetails.PokemonDetailDataModel(name: name, image: image, effect: effect, shortEffect: shortEffect, generation: generation, weight: weight, height: height))
        
        let viewModel = PokemonDetails.PokemonDetailsModel.ViewModel(pokemonDetailsData: arr)
        
        self.viewController?.displayPokemonDetails(viewModel: viewModel)
    }
}
