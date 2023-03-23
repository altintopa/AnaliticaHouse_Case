//
//  Models.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//

import Foundation

//struct PokemonResponseModel: Codable {
//    var count: Int
//    var results: [PokemonModel]
//}
//
//struct PokemonModel: Codable {
//    var name: String
//    var url: String
//}

struct PokemonResponseModel: Codable {
    var count: Int
    var next: String
    var results: [PokemonModel]
}

struct PokemonModel: Codable {
    var name: String
    var url: String
}

struct PokemonItemModel: Codable {
    var abilities: [Ability]
    var height: Int
    var id: Int
    var name: String
    var order: Int
    var sprites: Sprites
    var weight: Int
}
struct Ability: Codable {
    var ability: AbilityDetail
    var isHidden: Bool
    var slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
struct AbilityDetail: Codable {
    var name:String
    var url: String
}
struct Sprites: Codable {
    var backDefault: String
    var backShiny: String
    var frontDefault: String
    var frontShiny: String
    var other: Other?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case other
    }
}
struct Other: Codable {
    var pokemonImage: DreamWorld

    enum CodingKeys: String, CodingKey {
        case pokemonImage = "dream_world"
    }
}
struct DreamWorld: Codable {
    var frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonAbilityModel: Codable {
    var id: Int
    var name:String
    var effectEntries: [EffectEntry]
    var generation: Generation
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case id,name,generation
    }
}
struct EffectEntry: Codable {
    var effect: String
    var shortEffect: String
    var language: Language
    
    enum CodingKeys: String, CodingKey {
        case shortEffect = "short_effect"
        case effect,language
    }
}
struct Language: Codable {
    var name: String
}
struct Generation: Codable {
    var name: String
    var url:String
}
