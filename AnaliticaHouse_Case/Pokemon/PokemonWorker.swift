//
//  PokemonWorker.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class PokemonWorker {

    func getPokemonData(completion: @escaping ([PokemonModel]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            }
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(PokemonResponseModel.self, from: data)
                completion(result.results)
            } catch {
                print("Something Wrong !")
            }
        }
        task.resume()
    }
    
    
    func getPokemonItemData(url: String, completion: @escaping (PokemonItemModel) -> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            }
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(PokemonItemModel.self, from: data)
                completion(result)
            } catch {
                print("Something Wrong !")
            }
        }
        task.resume()
    }
    
}
