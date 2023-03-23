//
//  PokemonTableViewCell.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var pokemonImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(name:String, imageUrl:String){
        lblPokemonName.text = name
        pokemonImgView.load(url: URL(string: imageUrl)!)
        
    }
}
