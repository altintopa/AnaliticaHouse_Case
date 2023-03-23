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
}

class PokemonViewController: UIViewController {
  // MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public Properties -

    var pokemonlar:[Pokemon.PokemonListModel] = []
    
    var pokemonArray: [PokemonModel] = []
    var pokemonItemData: [PokemonItemModel] = []
    var pokemonAbility: [PokemonAbilityModel] = []
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
      //getPokemonData()
      tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
  }
    func preparePokemonData(){
        DispatchQueue.main.async {
            for item in self.pokemonArray {
                self.getPokemonItemData(url: item.url)
            }
        }
        if self.pokemonArray.count == self.pokemonItemData.count {
            self.tableView.reloadData()
        }
    }
    
    private func getPokemonData(){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            }
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(PokemonResponseModel.self, from: data)
                self.pokemonArray = result.results
                DispatchQueue.main.async {
                    self.preparePokemonData()
                }
            } catch {
                print("Something Wrong !")
            }
        }
        task.resume()
    }
    
    private func getPokemonItemData(url: String){
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            }
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(PokemonItemModel.self, from: data)
                self.pokemonItemData.append(result)
                DispatchQueue.main.async {
                    if self.pokemonItemData.count == 20{
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Something Wrong !")
            }
        }
        task.resume()
    }
    
    private func getPokemonDetails(url:String){
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            }
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(PokemonAbilityModel.self, from: data)
                self.pokemonAbility.removeAll()
                self.pokemonAbility.append(result)
                DispatchQueue.main.async {
                    self.router?.navigate(to: .toDetails)
                }
            } catch {
                print("Something Wrong !")
            }
        }
        task.resume()
    }

  // MARK: - IBActions -
    
}

// MARK: - PokemonDisplayLogic -

extension PokemonViewController: PokemonDisplayLogic {
    func displayPokemons(viewModel: Pokemon.PokemonList.ViewModel) {
        self.pokemonlar = viewModel.viewModel
        self.tableView.reloadData()
        print("saasdada")
    }
}

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonlar.count
        //return pokemonItemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        //cell.setup(name: pokemonItemData[indexPath.row].name, imageUrl: pokemonItemData[indexPath.row].sprites.frontDefault)
        cell.setup(name: pokemonlar[indexPath.row].name, imageUrl: pokemonlar[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = pokemonItemData[indexPath.row].abilities[0].ability.url
        selecetedIndex = indexPath.row
        getPokemonDetails(url: url)
        //self.router?.navigate(to: .toDetails)
    }
}
