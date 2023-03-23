//
//  PokemonDetailsViewController.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PokemonDetailsDisplayLogic: AnyObject {
    func displayPokemonDetails(viewModel: PokemonDetails.PokemonDetailsModel.ViewModel)
}

class PokemonDetailsViewController: UIViewController {
    // MARK: - IBOutlets -
    
    @IBOutlet weak var pokemonImgView: UIImageView!
    @IBOutlet weak var lblShortEffect: UILabel!
    @IBOutlet weak var lblEffect: UILabel!
    @IBOutlet weak var lblGeneration: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    // MARK: - Public Properties -
    
    var pokemonData: PokemonDetails.PokemonDetailDataModel?
    
    var interactor: PokemonDetailsBusinessLogic?
    var router: (NSObjectProtocol & PokemonDetailsRoutingLogic & PokemonDetailsDataPassing)?
    
    // MARK: - Private Properties -
    
    // MARK: - Object lifecycle -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup -
    
    private func setup() {
        let viewController = self
        let interactor = PokemonDetailsInteractor()
        let presenter = PokemonDetailsPresenter()
        let router = PokemonDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareViews()
        
        self.interactor?.viewDidLoad()
    }
    
    // MARK: - Helpers -
    
    private func prepareViews() {
        
    }
    private func showData(){
        
        lblName.text = pokemonData?.name.uppercased()
        lblEffect.text = pokemonData?.effect
        lblShortEffect.text = pokemonData?.shortEffect
        lblGeneration.text = pokemonData?.generation
        pokemonImgView.load(url: URL(string: pokemonData?.image ?? "")!)
        lblHeight.text = pokemonData?.height
        lblWeight.text = pokemonData?.weight
        
    }
    
    // MARK: - IBActions -
}

// MARK: - PokemonDetailsDisplayLogic -

extension PokemonDetailsViewController: PokemonDetailsDisplayLogic {
    func displayPokemonDetails(viewModel: PokemonDetails.PokemonDetailsModel.ViewModel) {
        self.pokemonData = viewModel.pokemonDetailsData.first!
        self.showData()
    }
}
