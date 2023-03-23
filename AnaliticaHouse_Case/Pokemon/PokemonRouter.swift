//
//  PokemonRouter.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum PokemonNavigationOption {
    case toDetails
}

protocol PokemonRoutingLogic { 
  func navigate(to option: PokemonNavigationOption)
}

protocol PokemonDataPassing: AnyObject {
  var dataStore: PokemonDataStore? { get }
}

class PokemonRouter: NSObject, PokemonDataPassing {
  weak var viewController: PokemonViewController?
  var dataStore: PokemonDataStore?
}

// MARK: - PokemonRoutingLogic -

extension PokemonRouter: PokemonRoutingLogic {
  func navigate(to option: PokemonNavigationOption) {
      switch option {
      case .toDetails:
          let destinationVC = UIStoryboard.init(name: "PokemonDetails", bundle: Bundle.main).instantiateViewController(withIdentifier: "PokemonDetails") as? PokemonDetailsViewController
          let destinationDS = destinationVC?.router?.dataStore
          destinationDS?.pokemonDetails = viewController?.pokemonAbility
          destinationDS?.pokemonItemData = viewController?.pokemons[self.viewController?.selecetedIndex ?? 0]
          self.viewController?.present(destinationVC!, animated: true)
          
      }
  }
}
