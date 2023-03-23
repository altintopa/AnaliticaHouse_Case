//
//  PokemonDetailsRouter.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum PokemonDetailsNavigationOption { }

protocol PokemonDetailsRoutingLogic { 
  func navigate(to option: PokemonDetailsNavigationOption)
}

protocol PokemonDetailsDataPassing: AnyObject {
  var dataStore: PokemonDetailsDataStore? { get }
}

class PokemonDetailsRouter: NSObject, PokemonDetailsDataPassing {
  weak var viewController: PokemonDetailsViewController?
  var dataStore: PokemonDetailsDataStore?
}

// MARK: - PokemonDetailsRoutingLogic -

extension PokemonDetailsRouter: PokemonDetailsRoutingLogic {
  func navigate(to option: PokemonDetailsNavigationOption) { }
}