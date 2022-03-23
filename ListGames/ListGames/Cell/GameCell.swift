//
//  GameCell.swift
//  ListGames
//
//  Created by Yağmur Polat on 22.03.2022.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var released: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("yum")
    }

}
