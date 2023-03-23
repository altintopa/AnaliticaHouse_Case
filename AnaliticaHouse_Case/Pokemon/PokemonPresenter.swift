//
//  PokemonPresenter.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol PokemonPresentationLogic: AnyObject {
    func presentPokemons(response: Pokemon.PokemonList.Response)
    func toDetails(pokemonDetails: PokemonAbilityModel)
}

class PokemonPresenter {
    var pokemonList: [Pokemon.PokemonListModel] = []
    weak var viewController: PokemonDisplayLogic?
}

// MARK: - PokemonPresentationLogic -

extension PokemonPresenter: PokemonPresentationLogic {
    func presentPokemons(response: Pokemon.PokemonList.Response) {
        let responseArray = response.response
        
        for item in responseArray {
            pokemonList.append(Pokemon.PokemonListModel(name: item.name, image: item.sprites.frontDefault, abilityUrl: item.abilities[0].ability.url, weight: item.weight, height: item.height))
        }
        
        let viewModel = Pokemon.PokemonList.ViewModel(viewModel: pokemonList)
        self.viewController?.displayPokemons(viewModel: viewModel)
    }
    
    func toDetails(pokemonDetails: PokemonAbilityModel) {
        let toDetailsData = pokemonDetails
        self.viewController?.routeToDetails(toDetails: Pokemon.PokemonList.RouteToDetails(toDetailsModel: toDetailsData))
    }
}
