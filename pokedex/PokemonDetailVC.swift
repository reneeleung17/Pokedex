//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Waiwai on 31/5/2016.
//  Copyright © 2016 Waiwai. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIcon.startAnimating()
        pokemon.downloadPokemonDetails { 
            self.updateUI()
            self.loadingIcon.stopAnimating()
        }

    }
    
    

    func updateUI() {
        namelbl.text = pokemon.name.capitalizedString
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
        pokedexLbl.text = "\(pokemon.pokedexId)"
        currentEvoImg.image = pokemonImage.image
        defenceLbl.text = "\(pokemon.defense)"
        baseAttackLbl.text = "\(pokemon.baseAttack)"
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        descLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
            currentEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionName)"
            
            if pokemon.nextEvolutionLv != "" {
                str += " - Level \(pokemon.nextEvolutionLv)"
            }
            evoLbl.text = str
        }
    }
    
    @IBAction func onBackButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
