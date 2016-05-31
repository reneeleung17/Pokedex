//
//  Pokemon.swift
//  pokedex
//
//  Created by Waiwai on 29/5/2016.
//  Copyright © 2016 Waiwai. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _evolutionText: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
    }
}