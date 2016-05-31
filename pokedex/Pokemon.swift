//
//  Pokemon.swift
//  pokedex
//
//  Created by Waiwai on 29/5/2016.
//  Copyright © 2016 Waiwai. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionName: String!
    private var _resourceUrl: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLv: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var height: String {
        if _height == nil {
            _height = "N/A"
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _height = "N/A"
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = "N/A"
        }
        return _baseAttack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = "N/A"
        }
        return _defense
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLv: String {
        if _nextEvolutionLv == nil {
            _nextEvolutionLv = ""
        }
        return _nextEvolutionLv
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var type: String {
        if _type == nil {
            _type = "N/A"
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = "N/A"
        }
        return _description
    }
    
    init (name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _resourceUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _resourceUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let type = types[0]["name"]{
                        self._type = type
                    }
                    if types.count > 1 {
                        for x in 2...types.count {
                            if let name = types[x-1]["name"] {
                              self._type! += "/\(name)"
                            }
                        }
                        
                    }
                } else {
                    self._type = "N/A"
                }
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0{
                    if let url = descArr[0]["resource_uri"] {
                        Alamofire.request(.GET, NSURL(string: "\(URL_BASE)\(url)")!).responseJSON { response in
                            let result = response.result
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            
                            completed()
                        }
                        
                    }
                } else {
                    self._description = "N/A"
                }
                
                
                
                print(self._weight)
                print(self._height)
                print(self._baseAttack)
                print(self._defense)
                print(self._type)

                if let evolutionArr = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutionArr.count > 0 {
                    if let to = evolutionArr[0]["to"] as? String {
                        
                        //can't support mega pokemon right now but api still have mega data
                        if to.rangeOfString("mega") == nil {
                            if let str = evolutionArr[0]["resource_uri"] as? String {
                                let newStr = str.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                                self._nextEvolutionName = to
                            }
                            
                            if let lvl = evolutionArr[0]["level"] as? Int {
                                self._nextEvolutionLv = "\(lvl)"
                            }
                            print(self._nextEvolutionId)
                            print(self._nextEvolutionName)
                            print(self._nextEvolutionLv)
                        }
                    }
                }
                }
            }
            
        }
    }
    
