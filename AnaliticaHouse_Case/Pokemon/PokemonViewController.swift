//
//  PokemonViewController.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PokemonDisplayLogic: AnyObject {
    func displayPokemons(viewModel: Pokemon.PokemonList.ViewModel)
    func routeToDetails(toDetails: Pokemon.PokemonList.RouteToDetails)
}

class PokemonViewController: UIViewController {
    // MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public Properties -
    
    var pokemons:[Pokemon.PokemonListModel] = []
    var pokemonAbility: PokemonAbilityModel?
    var selecetedIndex: Int = -1
    
    var interactor: PokemonBusinessLogic?
    var router: (NSObjectProtocol & PokemonRoutingLogic & PokemonDataPassing)?
    
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
        let interactor = PokemonInteractor()
        let presenter = PokemonPresenter()
        let router = PokemonRouter()
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
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
    }
    
    private func toPokemonDetailData(url: String) {
        /// Bu kısımda seçilen pokemon ile ilgili detaylı bilgi almak için API'ye çıkılıyor.
        self.interactor?.getPokemonDetail(url:url)
    }
    
    // MARK: - IBActions -
    
}

// MARK: - PokemonDisplayLogic -

extension PokemonViewController: PokemonDisplayLogic {
    func routeToDetails(toDetails: Pokemon.PokemonList.RouteToDetails) {
        self.pokemonAbility = toDetails.toDetailsModel
        self.router?.navigate(to: .toDetails)
    }
    
    func displayPokemons(viewModel: Pokemon.PokemonList.ViewModel) {
        self.pokemons = viewModel.viewModel
        self.tableView.reloadData()
    }
}

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        cell.setup(name: pokemons[indexPath.row].name, imageUrl: pokemons[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selecetedIndex = indexPath.row
        toPokemonDetailData(url: self.pokemons[indexPath.row].abilityUrl)
    }
}
